# Promscale archive notice

Promscale v0.17.0 was the final upstream release. Timescale discontinued the
project in February 2023 and ended support on April 30, 2023. The upstream
repository is archived and receives no compatibility or security maintenance.

This PGSTY package exists only to preserve the historical connector in an
installable form. It is intentionally frozen, is not enabled automatically, and
is not recommended for new deployments.

Promscale is not a standalone metrics database. It requires PostgreSQL,
TimescaleDB, and a mutually compatible `promscale_extension`. Compatibility
with current PostgreSQL or TimescaleDB releases is not guaranteed; validate the
complete database and extension stack before use.
