# infra-pkg 工作规范与 SOP

本文件是本项目的唯一操作规范（source of truth），适用于所有代理与维护者。`CLAUDE.md` 必须是指向 `AGENTS.md` 的相对软链接；规范只在这里修改。当前用户明确要求优先；继承上级 `../AGENTS.md`，历史会话用于理解约定，不把旧端口、旧目录、临时锁版或单次授权当成当前事实。

本手册于 **2026-11-21** 根据现有配方、工具实现与历史会话核对。具体版本查包目录和 README；实际入库状态查 `~/pgsty/repo`；线上发布状态另行验收，不在本文件维护一份版本清单。

## 1. 常用指令的含义

通常按批次处理更新，约每月 1–3 批。先确定本轮包清单，再完成用户要求的阶段；已授权的连续流程直接做完，不逐步重复确认。

| 用户说法 | 应完成的工作 |
| --- | --- |
| 扫描、检查更新、重新扫描 | 覆盖本地重打包和官方直下载包，核对上游与实际仓库，输出完整差异及下载计划；单独的扫描请求不改配方、不启动构建 |
| 更新、下载与构建、`build` | 固定版本与输入校验值，更新配方，**实际运行对应 `make <package>`**，验收两架构 RPM/DEB，记录文档和状态 |
| 新增包、纳入构建 | 评估发布资产和兼容性，选择打包方式，添加顶层配方、忽略规则、文档并构建验收 |
| `stash` | 按本批清单将制品归集到 `tmp/stash/`；这里不是 `git stash` |
| `place` | 将归集制品复制到 `~/pgsty/repo` 的对应目录，并校验副本；仅复制不代表索引已更新 |
| 按 SOP 入库、入库并更新索引 | 归集、放置、APT 导入、RPM/仓库元数据签名、索引更新、四路客户端验收；保留旧包 |
| `purge`、清理被覆盖的旧 RPM | 先列旧包 → 保留新包的对应表，生成 `tmp/purge.sh`；**未经用户确认不得执行** |
| 更新 infra changelog | 同步本手册列出的 README 和六份外部中英文文档，保持批次与状态一致 |
| 每包一个提交 | 双架构和两种格式的配方作为一个包提交；公共工具、忽略规则和批次日志单独提交 |
| 同步到 m3/m1、上传 CDN | 按约定方向同步并验证；明确要求上传时才执行发布目标，随后验证公网索引与签名 |

构建、入库、签名、Git 提交/推送、机器间同步、CDN 发布是分别可核验的结果。不要把构建成功写成已发布。只负责软件包交付；升级说明涉及数据库或应用迁移时，记录必要提示，不代用户执行生产迁移。

## 2. 现有结构与入口

本仓库维护 Pigsty Infra 通用 Linux 包，涵盖可观测性、存储、数据库工具、网络、开发工具链和 AI 工具。常规输出为 amd64/x86_64 与 arm64/aarch64 的 RPM、DEB；noarch 包单独处理。

| 路径 | 用途 |
| --- | --- |
| `<package>/Makefile` | 每包一个顶层目录；根 Makefile 自动发现 `*/Makefile` |
| `<package>/*.yaml`、`<package>/src/` | nFPM 配方、配置、unit、生命周期脚本；以 Makefile 实际引用的 manifest 为准 |
| `mk/vendor-direct.mk` | 官方 DEB/RPM 原包的下载、校验与复制流程 |
| `LICENSES/` | 可复用的标准许可证正文；定制版权和 NOTICE 留在包自己的资源中 |
| `bin/nfpm`、`.nfpm-version` | 固定 nFPM 版本的包装器及版本要求 |
| `bin/lint_specs.py`、`bin/render_debian_docs.py` | 配方检查、构建时生成 Debian 文档和临时 manifest |
| `tarball/` | 两架构共享下载缓存；输入应带版本及架构，或有可核验的版本映射 |
| `dist/deb/`、`dist/rpm/` | 所有架构的最终制品；不是本期清单，也不是正式软件仓库 |
| `tmp/` | 本轮计划、日志、校验清单、验收报告、归集和回滚材料；不按目录名整体清理 |

旧的 `amd64/<package>`、`arm64/<package>`、`noarch/<package>` 目录以及按架构拆分的 dist 路径已经淘汰。

- 多数配方使用 `ARCH ?= amd64`、`ARCHS ?= amd64 arm64`，导出 `ARCH`/`RARCH`；`make` 顺序构建两架构，`make one ARCH=...` 只构建指定架构。
- 通常一个 YAML 同时生成 RPM/DEB；确有架构元数据差异才拆分，如 `postgrest/nfpm.amd64.yaml` 与 `nfpm.arm64.yaml`。
- `victoria-metrics`、`victoria-logs` 故意保留为组合配方，各自生成多个同版本包。统计和归集时展开所有产物。
- noarch（如 `pev2`、`grafana-plugins`、`kafka`、`jmx-exporter`）通常没有架构循环；DEB 架构为 `all`，RPM 为 `noarch`。
- 兼容目标：`make claude` 指向 `claude-code`，`make t3-code` 指向 `t3code`，`make orca` 指向 `orca-ide`。实际包名和二进制名不一定相同。

## 3. 开工检查

1. 确认当前目录、分支、主工作树和已有改动，读取涉及包的 Makefile、manifest、README/BUILDINFO/策略说明。保留用户已有修改和暂存内容。
2. 核对工作阶段、批次日期（Asia/Shanghai）、目标包、双架构/格式范围；重跑复用本批任务目录，不复制整套缓存或仓库。
3. **下载或构建前**用 `git check-ignore -v <实际输出路径>` 验证缓存、解压目录、二进制、RPM/DEB、容器镜像等确实被忽略；否则先选择仓库外位置或补精确规则。
4. 检查所需工具：make、Python、curl、归档工具；nFPM 及 Python YAML 依赖按当前包装器要求；验收按需使用 rpm、dpkg-deb、容器/VM、编译器。不要为绕过版本检查擅改 `.nfpm-version`。
5. 检查目标主机的代理与缓存。m0/m1/m3/m5 的通用外网代理是本机 `http://127.0.0.1:8888`；`8118` 仅用于指定主机上的 AI 派活/模型调用。

```bash
git status --short
git branch --show-current
git worktree list --porcelain
git diff --stat
git diff --cached --stat
git check-ignore -v tarball/example.tar.gz dist/rpm/example.rpm tmp/example.json
```

不自动 `git stash/reset/clean`，不清空 `dist/`、`tarball/`、`tmp/` 或正式仓库。历史要求自动调用 Claude 复核已撤销，由当前代理执行必要检查。

## 4. SOP：扫描版本与形成批次计划

### 4.1 先建立三份基线

同时记录 **实际仓库版本、当前配方/已构建版本、上游目标版本**。本期升级/下载计划以实际仓库为基线：配方已经更新但尚未入库、同版本更高 release、新包或缺失架构，都应列入。

- 仓库：`~/pgsty/repo/apt/infra` 与 `~/pgsty/repo/yum/infra/{x86_64,aarch64}`。读取当前索引，并与磁盘包头比对；“已放入目录但索引未引用”单独标记。
- 配方：所有顶层 `*/Makefile`，包括官方直下载、组合配方、noarch、按需工具链；与 README 清单交叉检查，避免漏掉手工下载项。
- 制品：检查 `dist/`、相关 `tarball/` 的版本与校验值。文件存在、文件名相同或旧报告说成功，都不能证明当前制品正确。

按 **包名 + 架构 + 包格式** 比较版本。RPM 使用 Epoch/Version/Release 的 RPM 语义；DEB 使用 Debian 版本比较（如 `dpkg --compare-versions`）。不要用字符串、文件修改时间或 `sort -V` 代替包管理器语义。目录名、上游名、RPM/DEB 名不同的配方显式建立映射，如 `pg_exporter` → `pg-exporter`、`pgsty/mc` → `mcli`、IvorySQL 的格式间包名差异。

### 4.2 上游检查规则

1. 默认跟随已采用渠道的正式发行版。核对 Release 页面、tag、发布日期、draft/prerelease 标记和两架构 Linux 资产；`latest` 可能滞后，要与 releases 列表交叉核对。
2. 解析实际 tag 规则，如 `v...`、`rust-v...`、日期型 RELEASE、`+k3s...`；保留原始 tag，不把归一化版本拼回一个不存在的 URL。
3. 非 GitHub 来源查官方发行清单/包索引，如 Go、Node.js LTS、VS Code、Grafana、Claude Code、Rust。插件合集还需核对内含插件，不能只看合集版本。
4. 固定版本槽（`cargo-pgrx-*`）、冻结/EOL、手工归档、源码构建包分别处理。新 pgrx 版本通常新增槽并保留旧槽，不将所有槽追成同一最新版。
5. Draft/预发布候选、资产不全、查询失败、许可证或 ABI 变化单独列出；只有用户指定或既有配方明确采用的预发布渠道才进入对应构建计划。
6. 下载前再次核对目标资产；同一 URL/tag 被上游重新上传时，检查发布身份、包内版本和摘要，不能继续信任旧缓存或直接把新摘要写成“正确值”。

输出至少含：包名、四路实际版本、配方版本、目标 tag/版本、发布页、下载链接、处理方式、状态和必要备注。分别统计“需更新、已构建待入库、新增/补架构、已最新、固定/冻结、待确认/失败”；失败查询不算已最新。

### 4.3 现有辅助脚本的边界

本机 `bin/` 中可能有未纳入 Git 的扫描/更新助手，使用前先确认文件存在并读 `--help`：

```bash
python3 bin/check_update.py --json
python3 bin/infra_update_all.py --check --proxy http://127.0.0.1:8888
```

这些工具主要比较 **Makefile 与上游**，不读取实际 APT/YUM 基线，也不能完整处理所有来源、固定槽和组合版本，结果必须补核。`infra_update_all.py` 还有回退到预发布的逻辑；`pkg_update.py` 和非 `--check` 的全量更新器会修改配方，`--no-download --no-build` 也不是只读模式。它们不普遍自动更新 SHA256、硬编码资产 URL、`VERSION2` 等，不能直接当成完整 SOP。旧提示词中的 `scripts/*.py` 路径也不代表现有入口。

## 5. SOP：下载、缓存与配方更新

### 5.1 固定并校验输入

1. 为本批准备来源清单：上游仓库/tag、完整资产 URL、架构、文件名、预期 SHA256 及摘要来源；优先使用官方 checksum、签名索引或 release asset digest。没有独立摘要时明确记录来源和本地计算值，不声称验证过上游签名。
2. 经 `8888` 下载到共享 `tarball/` 的临时文件，HTTP 失败立即报错，确认非空并校验后再改为正式缓存名。无版本文件名必须核对内容；确认是旧输入才替换本次相关缓存。
3. 检查压缩包结构、二进制平台与版本。原生 DEB/RPM 还要读取包头，不凭后缀判断架构。校验失败不得靠修改预期摘要绕过。
4. Makefile 的 `download` 往往只**读取**共享缓存，在线下载落在包目录，未必回填缓存；需要可重用输入时显式保存。校验可能在 `download` 内，也可能是独立 `verify`，按真实依赖顺序执行。
5. Mac 容器通过 `http://host.docker.internal:8888` 访问宿主代理；Linux 按容器网络确认入口。国内源/本地服务按需直连；不要把代理凭据写入配方。

普通配方可通过当前命令的 `http_proxy`/`https_proxy`（必要时同时设置大写变量）取源；vendor-direct 使用 `PROXY`，无需代理时 `PROXY=`。所有通过网络取得的输入应在解压/打包前校验。

### 5.2 选择正确的打包方式

| 方式 | 实施规则 |
| --- | --- |
| nFPM 重打包 | 固定上游 Linux 二进制/运行时和许可证，更新 Makefile 与所有相关 manifest，构建两架构 RPM/DEB |
| `VENDOR_DIRECT=1` | 使用官方两架构 DEB/RPM，固定四个 URL/文件名/SHA256，通过 `mk/vendor-direct.mk` 原样复制到 dist；保留官方 metadata 和文件布局 |
| `VENDOR_DEB=1` | 如 T3 Code，官方 DEB 保持原字节，用已校验载荷补建 RPM，单独验证权限、脚本和依赖 |
| 源码构建/外部构建 | 无合适 Linux 资产或既有配方要求时，固定源码 tag/commit、工具链、依赖锁和构建参数；更新 BUILDINFO 与最终输入摘要 |
| 手工归档/缓存输入 | 遵从包内既定约定；版本化缓存名 + 固定 SHA256 可作为输入边界，不为一次性归档强造通用重建系统 |

新增包先说明用途、两架构资产、许可证、运行依赖与 ABI、binary-only 或 service 定位。优先沿用同类配方。轻量单二进制通常重打包；已选定官方原包的配方继续原样分发，不为统一 `PGSTY` 字段而重新封装。新增顶层 Makefile 即成为根构建目标；大型/专门工具链是否加入默认批次，按根 `ON_DEMAND_PKGS` 处理。

### 5.3 配方与载荷约定

- 自建目录和包名采用小写、连字符；保持 RPM/DEB 名一致，官方原包的命名差异照实记录。二进制命令名保持软件实际接口。
- 自建包 `vendor: PGSTY`、`maintainer: Ruohang Feng <rh@vonng.com>`；许可证使用准确 SPDX 表达式，不能复制旧版错误许可。
- 新上游版本通常从 `1PGSTY` 开始；同一上游版本重打包递增 release，保证客户端能升级。保留已有合理 Epoch；预发布按现有 manifest 的 `prerelease`/版本规则表达，不伪装 stable。官方包保留原 release。
- 检查所有相关版本和摘要：包括组合配方的多个 YAML、附属二进制、插件版本、硬编码 URL/文件名及分架构 pin；不能只替换 `VERSION=`。
- 自建二进制/运行时放 `/usr/bin`、`/usr/lib/<package>` 等规范位置；环境文件 `/etc/default/<name>`，unit `/usr/lib/systemd/system`，法律文件 `/usr/share/doc/<package>/`。自建载荷不写入 `/usr/local`；Node.js 的 npm 全局安装前缀是另一回事，官方原包路径也不强改。
- 只打包必要运行内容与有用文档。标准许可证正文复用 `LICENSES/`；带定制版权的 LICENSE、上游要求的 NOTICE 及 bundled 组件法律材料完整保留。发行归档缺 NOTICE 时检查精确源码 tag。
- 服务配置按配方使用 `config|noreplace`；vendor unit 是普通文件，不标为配置。用户/目录与 hook 保持必要、幂等；升级尊重管理员的启停状态，卸载不删除业务数据。
- **监控组件不硬依赖被监控组件**。运行时部署前提可在文档说明。普通二进制包不因“能长期运行”就被强加 unit、用户或状态目录。
- 不设全仓 systemd 最低版本，优先去掉非必要的兼容敏感指令。实际 ELF/glibc/动态库需求必须准确声明，不能为了“通用包”虚报兼容性。
- Debian 的 `${NFPM_CHANGELOG}`、`${NFPM_COPYRIGHT}` 由包装器生成，保留占位符并使用 `bin/nfpm`。需要固定构建日期/复现时设置并记录 `SOURCE_DATE_EPOCH`；当前生成器未设置时使用构建时间，不能假定已自动固定到发布日期。

### 5.4 经常遇到的特殊情况

- `claude-code` 已替代封存的自建 `claude`。从官方 APT/DNF 索引取得四个原包和可信摘要，校验索引签名及包内版本；`make claude` 只是兼容入口。
- Codex、Pi 等可能需要完整上游运行时、相对软链、helper 和第三方库。升级时核对官方布局和逐文件内容，不退回只复制主程序的方案。
- Victoria 组合、Loki/logcli/loki-canary、k3s 与 images、timescaledb-tools 的附属程序需要检查版本联动；冻结的 Promtail 不因 Loki 升级被机械更新。
- `rust-toolchain` 和 `cargo-pgrx-*` 按需构建；新版本槽声明实际 Rust 最低版本和支持的 PG 范围，验证与旧槽共存以及目标 ABI。
- 冻结/许可策略读当前包内说明。用户于 2026-11-21 明确要求 Sealos 回滚并永久锁定在最后的 Apache-2.0 正式版 **5.0.1**，恢复 nFPM 重打包；详见 `sealos/LOCKED.md` 与 Makefile 的 `LOCKED_VERSION`。后续扫描列为“锁定”，常规更新、全量更新和官方原包切换均不得升级 Sealos；只有用户明确要求解除 Sealos 锁定时才可变更。包头许可与源码许可不一致时记录差异。
- 上游自身的版本字符串/metadata 错误，经固定资产身份与摘要核实后可记录接受，不擅自修补官方二进制。历史上已接受的手工插件归档、插件签名裁剪等按包内既有契约处理。

## 6. SOP：实际构建与验收

| 命令 | 含义 |
| --- | --- |
| `make prometheus` | 从根目录构建该配方的所有声明架构和格式 |
| `make -C prometheus one ARCH=amd64` | 构建单包单架构；包内单独构建前可先在根执行 `make dir` |
| `make -C prometheus one ARCH=arm64` | 同上，arm64 |
| `make all` | 构建根 `PKGS`；**不包含 `ON_DEMAND_PKGS`** |
| `make amd64` / `make arm64` | 只遍历 `PKGS` 中含 `one:` 的配方；跳过 noarch 与按需包 |
| `make k3s-images` / `make rust-toolchain` / `make cargo-pgrx-0200` | 显式按需构建；具体槽以当前目录为准 |
| `make lint` | 执行全仓配方静态检查 |

按期更新只构建本批目标；“完整重建”应明确覆盖包括哪些按需配方。不要用不完整的 `make all` 结果宣称所有包均已重建。同一配方两架构常共用解压目录，不并发运行两个独立的 make；也不要一边构建一边清理同一目录。

实际流程是：下载 → 校验 → 必要的解压/源码构建 → nFPM 或官方包复制 → 验证 → 清理本次中间物。调用固定版本 `bin/nfpm`；有多个已安装 nFPM 时通过 `NFPM_BIN` 指定真实可执行文件。

验收按以下顺序完成：

1. **构建记录**：保存每个 make 命令、架构、退出码和日志；出现错误先解决本包原因，不继续把缺件当成功。
2. **包头与数量**：核对名称、完整版本/release/epoch、架构、依赖、许可。常规逻辑包 4 件；noarch 是 1 DEB + 1 RPM；组合配方按实际子包展开。
3. **载荷**：检查 `rpm -qpl` / `dpkg-deb -c` 或解包清单，核对路径、权限、软链、配置、法律文件及 ELF 架构/ABI；自建 RPM 与 DEB 的对应二进制应一致。官方原包在 dist 的 SHA256 必须与已验证输入相同。
4. **运行**：在匹配架构的 Linux 容器或 VM 安装并执行实际命令，检查版本与最小可用行为；macOS 不能直接代替 Linux 运行验收。有些工具不用 `--version`，按其接口验证。
5. **有变更才扩展验证**：hook/unit 变化测试安装、升级、管理员配置保留及卸载；完整运行时变化核对 helper/资源发现；ABI 变化测试支持平台。`bin/check-cli-install` 和 `bin/check-*-unit-upgrade` 如存在，只在一次性容器使用；模拟 systemctl 的测试不等于真实服务启动。
6. **系统边界**：容器/QEMU 的 seccomp、namespace、AppArmor 结果不能直接作为原生机器结论。涉及沙箱或系统服务时按需要用 barn/VM；区分包缺陷、上游行为、宿主策略和未测功能。
7. **收尾**：运行 `make lint`、`git diff --check`，复核本次 clean 只清理配方临时文件。保留共享输入、成品和验收证据；失败时保留诊断。不要为格式小问题制造冗长警告清单。

至少留下本批 `manifest.json`（配方/包名/版本/架构/格式/文件路径/大小/SHA256/验证状态）、`SHA256SUMS`、构建日志和简短 `REPORT.md`。全仓逐包验收按字母顺序推进，可用 `tmp/RESULT.md` 记录进度。验证深度与改动相称，静态检查、版本启动、真实功能测试分别说明。

## 7. SOP：stash、place 与本地入库

### 7.1 stash：按本批清单归集

从已验收的 manifest 选取本批制品，避免 `dist/*` 通配混入旧版、失败重建或其他任务的产物。包头是分类依据；官方文件名可能使用下划线、`amd64`、`arm64` 等非 nFPM 命名，不能只靠扩展名前缀或文件名架构后缀分拣。

| 归集目录 | 内容 | place 目标 |
| --- | --- | --- |
| `tmp/stash/apt-infra/` | amd64、arm64、all 的 DEB；noarch DEB 只放一份 | `~/pgsty/repo/apt/infra/stash/` |
| `tmp/stash/yum-infra-x86_64/` | x86_64 RPM + 每个 noarch RPM 一份 | `~/pgsty/repo/yum/infra/x86_64/` |
| `tmp/stash/yum-infra-aarch64/` | aarch64 RPM + 每个 noarch RPM 一份 | `~/pgsty/repo/yum/infra/aarch64/` |

按每个逻辑包核对两架构、两格式是否齐全；noarch 是 **2 个独立制品、3 份归集副本**，不是缺一件。组合配方拆成各子包核验；格式间不同原生包名保留映射。为本次归集保存 manifest 与 SHA256；已有 stash 不整体删除，旧内容不能自动进入本批。

### 7.2 place：复制并验证

1. 记录目标目录当前包与索引状态，核对同名文件。同路径同摘要可复用；同路径不同字节须查清是上游重传、已签名副本还是错误版本，保留必要回滚副本再替换。
2. 只复制 manifest 中确认过的文件到上表目标，逐个核对大小、SHA256 和包头。不要将待签名的 RPM 与 `dist/` 或 `tarball/` 硬链接，签名会改变文件。
3. 保留历史包；`place` 不附带 purge、APT 清池或远端上传。完成后报告“已放置/待索引”，不要写成已可安装。

### 7.3 按 SOP 入库并更新索引

先读取 `~/pgsty/repo` 的当前规范、Makefile 和工具，以下是本次核对的接口。只操作 infra 范围；同一仓库的导入、签名、索引任务串行，避免并发写入。

**APT：** 发行名 `generic`，组件 `main`，架构 `amd64 arm64`，以 `apt/infra/conf/distributions` 为准。按本批文件清单调用 `reprepro includedeb`；保留未引用历史文件，避免导入顺带清池。例如 `$deb_file` 表示清单中一个已验证 DEB：

```bash
reprepro --keepunreferencedfiles -b "$HOME/pgsty/repo/apt/infra" includedeb generic "$deb_file"
reprepro -b "$HOME/pgsty/repo/apt/infra" check generic
reprepro -b "$HOME/pgsty/repo/apt/infra" list generic
```

`make -C ~/pgsty/repo/apt add-infra` 会导入 `infra/stash/*.deb`；只有确认该目录恰好对应本批时才采用这个快捷目标，并核实保留历史文件的配置。不要手改 `pool/`、数据库或 `Packages` 来假装完成导入。

**YUM：** 两个平铺 leaf 为 `infra/x86_64` 和 `infra/aarch64`。当前 `repo/yum/build` 使用 SOW，在候选副本中校验/规范 RPM 签名、生成索引、签署 `repomd.xml` 再发布：

```bash
make -C "$HOME/pgsty/repo/yum" build-infra
```

当前 `sign-infra` 是同一流程的别名；不再照搬旧的分离签名与 createrepo 步骤，也不要运行覆盖 PGSQL 的全局 `make build/sign`。默认流程不清理旧 RPM；`prune` 属于另一个需要明确清单的删除操作。

签名策略：APT 索引、仓库 RPM 和 YUM `repomd.xml` 使用当前 PGSTY 密钥；核对 `SignWith`/`SIGN_KEY` 与本机可用密钥。2026-11-21 配置的指纹为 `9592A7BC7A682E7333376E09E7935D8DB9BD8B20`；后续以已确认的仓库配置为准。不要为了让验签“通过”往仓库新增第三方信任密钥。

官方原包在 `tarball/`/`dist/` 保持原字节；**YUM 仓库副本经 PGSTY 签名后整包 SHA256 可能改变**，必须分别记录签名前后摘要，并校验包头/载荷一致。不能再用上游整包摘要判断已重签副本失败，也不能反过来改写上游 pin。

### 7.4 入库完成条件

- 本批每个包在所需架构/格式上都被活跃索引引用，版本、依赖、文件路径、大小和摘要匹配；没有缺件或重复 NEVRA。
- APT：`reprepro check generic` 通过；检查 Packages/Packages.gz、Release/InRelease/Release.gpg 的引用与签名，`all` 包在两架构索引都可见。
- YUM：检查 repomd 签名及其引用的元数据校验值，确认 primary/filelists/other 与实际 RPM 一致，RPM 使用预期密钥验签。
- 用临时仓库配置分别验证 APT amd64、APT arm64、DNF x86_64、DNF aarch64 可刷新索引、解析目标版本并下载/安装本批代表包；不污染宿主的全局软件源。模拟架构测试明确标记其限制。
- 记录已有包的保留情况、签名后的摘要、索引变化和验收结果。未做 CDN 上传时，最终状态明确为“本地已入库，尚未线上发布”。

“旧版本 RPM”“APT 包池未引用 DEB”“旧 repodata 文件”是三类不同对象；存在历史文件不等于当前索引损坏。

## 8. SOP：purge 旧 RPM

范围限于 `~/pgsty/repo/yum/infra/x86_64/` 和 `~/pgsty/repo/yum/infra/aarch64/`。目标是每个实际包名/架构只保留一个最新版本；`cargo-pgrx-0194`、`cargo-pgrx-0200` 等不同包名的版本槽应共存。

1. 读取磁盘 RPM 包头，以 RPM Epoch/Version/Release 比较同包同架构，不能按文件名拆分、修改时间或索引是否引用判断新旧。noarch 在两个 leaf 分别核对。
2. 每个待删包必须在同一 leaf 找到真实存在、有效且版本更高的保留包；同 NEVRA 异摘要、改名、缺架构或无法比较的项单列，不自动删除。
3. 生成 Markdown 对照表（待删绝对路径、保留的新包、版本、理由）和 **`tmp/purge.sh`**。脚本简单明确，**一行一个带正确 shell 引号的 `rm -- '绝对路径'`**，不使用通配、循环或泛化 prune 命令扩大范围。
4. **表格与脚本交用户 review；未经确认绝不执行，包括 YOLO 模式。** 对当前清单已经得到明确确认时，不重复索要相同确认；执行前重核保留包和待删文件未变，超出批准范围的变化另行报告。
5. 执行后核对目标确已移除、最新包保留、重复版本组清零，并按第 7 节重新生成和验证索引/签名，使仓库不再引用已删文件。只批准脚本删除、尚未允许仓库维护时，明确报告待重建索引，不能宣称仓库可用。

APT 未引用包、旧 repodata、下载缓存和 Git 历史清理不包含在此流程。不要用 `make apt-purge`、`make yum-prune` 或 `reprepro deleteunreferenced` 绕过用户对具体删除清单的确认。

## 9. SOP：README 与中英文日志

常规批次更新记录同时核对以下七个文件；修改相邻仓库前先读其规范并保留其他改动。用户明确限定“只改本地 README”或正在进行未发布重构时遵从该范围，不把内部调整写成外部发布。

| 文件 | 内容 |
| --- | --- |
| `./README.md` | 当前配方/制品清单、下载来源、批次日志与准备/入库状态 |
| `~/pgsty/pigsty.cc/content/docs/repo/infra/list.md` | 中文当前版本清单 |
| `~/pgsty/pigsty.cc/content/docs/repo/infra/log.md` | 中文变更记录 |
| `~/pgsty/pigsty.io/content/docs/repo/infra/list.md` | 英文当前版本清单 |
| `~/pgsty/pigsty.io/content/docs/repo/infra/log.md` | 英文变更记录 |
| `~/pgsty/pgext/content/release/infra.md` | 英文发布记录 |
| `~/pgsty/pgext/content/release/infra.zh.md` | 中文发布记录 |

- 日志默认用“**日期 + 表格**”，写旧版 → 新版及简短必要备注；同批增量合并到该日期，保留真实历史。合并日期遵照用户要求，不能任意改写旧批次。
- 与 manifest 核对包名、版本、release、架构、是否官方原包、组合子包和 noarch。必要的迁移/ABI/冻结说明简短准确；不塞入下载过程、临时路径或过长操作叙述。
- 未入库批次标为本地已构建/待入库；外部“当前版本”列表不能将候选包无标记地宣称为已可安装。入库后更新相应状态，线上发布另记验收结果。
- 中文与英文的版本、日期、状态保持一致。文档修改不自动授权提交、跨站部署或发布。

## 10. SOP：逐包提交

用户要求提交时，先检查 diff、暂存区、忽略规则和新增文件的大小/类型，只纳入本次源文件。

1. 每包一个提交，包含该包两架构/格式相关的 Makefile、manifest、必要资源与 BUILDINFO；Victoria 组按同版本组合配方作为一组处理。
2. 提交信息优先遵照本次用户要求和邻近历史，例如 `bump <package> from <old> to <new>`、`update <package> to <version>`、`<package>: <具体修复>`。清楚的一行即可。
3. 全局 Makefile、共享工具/许可证、`.nfpm-version`、`.gitignore` 和 README 批次汇总按职责单独提交；包专属 README 条目可随包，避免共享文件把其他包修改混入。
4. 精确指定 `git add` 路径/改动块；不要用 `git add .`、`git add -A` 或强制添加忽略文件。逐次看 staged diff 和文件清单，保持原有无关暂存内容不变。
5. 运行适合改动的检查，报告提交数、每包提交和剩余变更。要求推送时再推送并验证远端；只要求提交时不自动推送。

Git 默认只保存代码、配置、轻量文档/元数据。构建产物、可执行文件、压缩包、镜像、数据库导出及大体积文本数据都不入 Git；拿不准的例外须先取得明确指示。优先保存来源清单、摘要和可复现方法。

忽略规则须在生成大文件**之前**生效，防止代理恢复/差异快照把它们写入对象库。已有忽略规则不会移除旧对象；本规范不授权删 stash、恢复快照、Git 对象或改写历史。`AGENTS.md` 和 `CLAUDE.md` 软链接属于需要纳入版本控制的轻量规范，不应被忽略。

## 11. SOP：多机同步与 CDN 发布

只在用户要求相应阶段时执行；开始前确认主机身份、真实目录、目标和当前仓库状态。

- 本仓根 `make push/pull` 的 `DEVEL_PATH` 当前是 `sv:/data/pgsty/infra-pkg`，用于构建树 rsync，**不是 infra 仓库发布**；`pushd/pulld` 带 `--delete`，不作为普通同步的默认替代。
- 已约定正式 infra 仓库同步方向：**m5 本地 → m3 → m1**，范围为 `~/pgsty/repo/apt/infra` 和 `~/pgsty/repo/yum/infra`。先确认当前本机是否就是权威源 m5，不因 SSH 别名相似反向覆盖。
- 弱网/移动网络场景优先发送来源与 SHA256 清单，在 m3 复用 `infra-pkg` 缓存、经 m3 的 8888 下载，再由 m3 向 m1 传大文件。使用用户指定或 SSH 配置中的连接地址。
- 同版本重新打包可能因时间戳、压缩或签名产生不同字节。远端重建后必须与权威源 SHA256 比较；要实现精确镜像，应传输缺失的原制品或固定全部构建输入，不能用“版本相同”代替“一致”。
- 严格镜像使用 `rsync --delete` 前做 dry-run，检查删除差异并保留必要的仓库外回滚材料；本次请求已明确授权镜像覆盖时继续执行，否则不把普通增量同步扩展成删除。末尾 `/` 与同步范围必须准确。
- 同步后比较相对路径、文件大小、SHA256；声称完全镜像时再核对权限、软链、目录和修改时间。无缺失/多余，且包、索引、签名一起一致，才报告同步完成。

明确要求上传时，在已验收的 m1 仓库执行：

```bash
ssh m1 'cd ~/pgsty/repo && make co-infra cf-infra'
```

执行前复核当前 Makefile 的 COS/Cloudflare 目标；两者使用 `rclone sync`，会使目标服从源目录。保存日志并跟进退出码，不能启动后台上传后就报告完成。随后比对两处远端文件、按仓库工具刷新相关 infra CDN 缓存，并从 `repo.pigsty.cc` / `repo.pigsty.io` 验证 APT/YUM 活跃索引、签名和代表包与本地一致。

## 12. 交付与规范维护

最终说明应包含：本轮包及版本、独立制品/副本数量、通过的检查、必要的兼容性限制、报告/manifest 路径，以及构建/入库/签名/提交/推送/同步/发布各自做到哪一步。只报告实际结果；没有测试的 GUI、真实数据库、认证后模型调用或原生沙箱，不笼统声称通过。

维护本手册时以**当前代码 + 最近明确约定**纠正历史流程；已经撤销的临时策略不恢复。仓库命令变更时同步修订相关 SOP，`CLAUDE.md` 始终保持 `AGENTS.md` 相对软链接。验证入口：

```bash
test -L CLAUDE.md && test "$(readlink CLAUDE.md)" = AGENTS.md
cmp AGENTS.md CLAUDE.md
git diff --check
```

以下会话是关键约定的来源索引，不替代执行前的现场核验：

| 约定 | 原始会话 |
| --- | --- |
| 以实际仓库为升级基线；入库与发布分开；m5 → m3 → m1；m1 上传 | [扫描 infra-pkg 软件包更新](codex://threads/01a1cd2d-3581-7392-9fcd-852c25fb2688) |
| 8888 下载、常规更新批次、完整制品验收 | [检查 infra-pkg 软件包更新](codex://threads/01a1f644-da19-7551-af75-5f2efc7d0b65) |
| Rust/pgrx 版本槽、依赖与共存 | [评估 Rust 工具链与 pgrx 版本更新](codex://threads/01a1f9bb-e760-7fb0-8b26-845c84ed66b8) |
| 官方 claude-code 原包替代旧自建 claude | [改用 Claude Code 官方包](codex://threads/01a1c499-7cfe-7a00-abd7-491c5960b41f) |
| 完整运行时及容器/VM 验收边界 | [验收并重构 vibe agent 模块](codex://threads/01a1c4c5-5a83-74d2-b956-20fc39b2da16) |
| noarch 的一份 DEB、两处 RPM 副本 | [核对 tmp/stash 包架构数量](codex://threads/019d0ff1-9702-71d1-8f98-d183b8708a09) |
| 逐包提交，公共变更独立 | [分别提交软件包更新](codex://threads/01a1c498-24b1-71e1-bf74-344c58e06892) |
| 大文件、代理快照与 Git 膨胀教训 | [排查 .git 历史与体积](codex://threads/01a0ed35-5ee9-7bd2-bfbb-d0df040689ea) |
