import json
from pathlib import Path
import struct
import tempfile
import unittest

from prepare import EXECUTABLE, GRAFANA_DEPENDENCY, PLUGIN_ID, prepare


class PrepareTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.plugin = {
            "id": PLUGIN_ID,
            "type": "datasource",
            "backend": True,
            "executable": EXECUTABLE,
            "info": {"version": "1.0.0"},
            "dependencies": {"grafanaDependency": GRAFANA_DEPENDENCY},
        }
        self.write_metadata()
        for arch, machine in (("amd64", 62), ("arm64", 183)):
            header = bytearray(64)
            header[:6] = b"\x7fELF\x02\x01"
            struct.pack_into("<H", header, 18, machine)
            binary = self.root / f"{EXECUTABLE}_linux_{arch}"
            binary.write_bytes(header)
            binary.chmod(0o755)
        (self.root / f"{EXECUTABLE}_future_platform").write_bytes(b"unused")
        (self.root / "MANIFEST.txt").write_text("upstream signature")
        (self.root / "module.js").write_text("frontend")

    def write_metadata(self):
        (self.root / "plugin.json").write_text(json.dumps(self.plugin))

    def snapshot(self):
        return {
            p.name: (p.readlink().as_posix() if p.is_symlink() else p.read_bytes(),
                     p.lstat().st_mode)
            for p in self.root.iterdir()
        }

    def assert_rejected_without_pruning(self, version="1.0.0", arch="amd64"):
        before = self.snapshot()
        with self.assertRaises(ValueError):
            prepare(self.root, version, arch)
        self.assertEqual(before, self.snapshot())

    def assert_selected_backend(self, arch):
        metadata = (self.root / "plugin.json").read_bytes()
        prepare(self.root, "1.0.0", arch)
        self.assertEqual(
            {p.name for p in self.root.glob(f"{EXECUTABLE}_*")},
            {f"{EXECUTABLE}_linux_{arch}"},
        )
        self.assertFalse((self.root / "MANIFEST.txt").exists())
        self.assertEqual((self.root / "plugin.json").read_bytes(), metadata)
        self.assertEqual((self.root / "module.js").read_text(), "frontend")

    def test_retain_only_amd64_backend(self):
        self.assert_selected_backend("amd64")

    def test_retain_only_arm64_backend(self):
        self.assert_selected_backend("arm64")

    def test_wrong_version_preserves_input(self):
        self.assert_rejected_without_pruning(version="1.0.1")

    def test_changed_dependency_preserves_input(self):
        self.plugin["dependencies"]["grafanaDependency"] = ">=14"
        self.write_metadata()
        self.assert_rejected_without_pruning()

    def test_changed_plugin_identity_preserves_input(self):
        self.plugin["id"] = "different-datasource"
        self.write_metadata()
        self.assert_rejected_without_pruning()

    def test_wrong_elf_machine_preserves_input(self):
        target = self.root / f"{EXECUTABLE}_linux_amd64"
        target.write_bytes((self.root / f"{EXECUTABLE}_linux_arm64").read_bytes())
        self.assert_rejected_without_pruning()

    def test_invalid_elf_preserves_input(self):
        (self.root / f"{EXECUTABLE}_linux_amd64").write_bytes(b"not an ELF")
        self.assert_rejected_without_pruning()

    def test_non_executable_backend_preserves_input(self):
        (self.root / f"{EXECUTABLE}_linux_amd64").chmod(0o644)
        self.assert_rejected_without_pruning()

    def test_symlink_backend_preserves_input(self):
        target = self.root / f"{EXECUTABLE}_linux_amd64"
        target.unlink()
        target.symlink_to(f"{EXECUTABLE}_linux_arm64")
        self.assert_rejected_without_pruning()


if __name__ == "__main__":
    unittest.main()
