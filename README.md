# PostgreSQL Imhex Patterns

A collection of [Imhex](https://imhex.werwolv.net/) pattern language (`.hexpat`) files for inspecting PostgreSQL files.

## Patterns

| File | Description |
|------|-------------|
| [`postgres_control.hexpat`](patterns/postgres_control.hexpat) | PostgreSQL `pg_control` file |
| [`postgres_heap_page.hexpat`](patterns/postgres_heap_page.hexpat) | PostgreSQL heap page layout |
| [`postgres_snapshot.hexpat`](patterns/postgres_snapshot.hexpat) | Serialized snapshot files |
| [`postgres_xlog.hexpat`](patterns/postgres_xlog.hexpat) | PostgreSQL WAL (Write-Ahead Log) |

## Search Path

Add the repository to the search path in `Settings -> Folders` to benefit from the automatic pattern detection.

## Usage

```
# Open a WAL segment
imhex /var/lib/postgresql/data/pg_wal/000000010000000000000001
```

Then, open the `postgres_xlog.hexpat` pattern. If the repository has been added to the search path, imhex should automatically suggest the correct pattern.

### WAL parsing

WAL parsing is done in two steps:
1. The first step parses the xlog pages and creates the `page_content` virtual file                                                                                                                                                                                           
2. Open the virtual file `page_content` with `Right Click` -> `View Raw Data`. This will open a new tab with the content of xlog pages, stripped of the page headers.
3. Re-apply `postgres_xlog.hexpat` to parse the WAL records. imhex should automatically propose the correct pattern if the search path is correctly setup.
