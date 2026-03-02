---
name: DiscordCLI
version: 0.1.0
description: "Export Discord messages — DMs, channels, servers. USE WHEN discord, export messages, pull DMs, discord history, discord export."
---

# Discord

Export Discord messages using DiscordChatExporter CLI. Supports DMs, server channels, date filtering, and multiple output formats.

## Usage

| Tool                          | Location                                      | Purpose                        |
|-------------------------------|-----------------------------------------------|--------------------------------|
| `DiscordChatExporter.Cli`     | `~/.local/bin/dce/DiscordChatExporter.Cli`    | Discord message export CLI     |

## Authentication

Token stored in `.env` as `DISCORD_TOKEN`. The CLI reads this env var natively — no `-t` flag needed when set.

```bash
source .env
```

User tokens access all DMs and servers the user belongs to. Bot tokens only access channels the bot participates in.

## Workflow Routing

| Workflow           | Trigger                                                    | Section                              |
|--------------------|------------------------------------------------------------|--------------------------------------|
| **List DMs**       | "list DMs", "show conversations", "who have I messaged"    | [List DMs](#list-dms)                |
| **Export DMs**     | "export DMs", "pull DMs", "download messages"              | [Export DMs](#export-dms)            |
| **Export Channel** | "export channel", "pull channel", "export server"          | [Export Channel](#export-channel)    |
| **Search/Filter**  | "messages from X", "messages after date", "filter"         | [Filtering](#filtering)             |
| **List Servers**   | "list servers", "show guilds"                              | [List Servers](#list-servers)        |

## List DMs

```bash
~/.local/bin/dce/DiscordChatExporter.Cli dm
```

Returns channel IDs and participant names. Use the channel ID for targeted exports.

## Export DMs

### All DMs

```bash
~/.local/bin/dce/DiscordChatExporter.Cli exportdm -f Json -o ~/Downloads/discord/
```

### Specific conversation

```bash
~/.local/bin/dce/DiscordChatExporter.Cli export -c CHANNEL_ID -f Json -o ~/Downloads/discord/
```

## Export Channel

### List server channels

```bash
~/.local/bin/dce/DiscordChatExporter.Cli guilds
~/.local/bin/dce/DiscordChatExporter.Cli channels -g SERVER_ID
```

### Export specific channel

```bash
~/.local/bin/dce/DiscordChatExporter.Cli export -c CHANNEL_ID -f Json -o ~/Downloads/discord/
```

### Export entire server

```bash
~/.local/bin/dce/DiscordChatExporter.Cli exportguild -g SERVER_ID -f Json -o ~/Downloads/discord/
```

## Filtering

### Date range

```bash
~/.local/bin/dce/DiscordChatExporter.Cli export -c CHANNEL_ID --after "2025-01-01" --before "2025-06-01" -f Json
```

### Content filter

```bash
# Messages from a specific user
~/.local/bin/dce/DiscordChatExporter.Cli export -c CHANNEL_ID --filter "from:username" -f Json

# Messages containing text
~/.local/bin/dce/DiscordChatExporter.Cli export -c CHANNEL_ID --filter "has:link" -f Json
```

### Include threads

```bash
~/.local/bin/dce/DiscordChatExporter.Cli export -c CHANNEL_ID --include-threads All -f Json
```

## List Servers

```bash
~/.local/bin/dce/DiscordChatExporter.Cli guilds
```

## Output Formats

| Format        | Flag             | Use case                           |
|---------------|------------------|------------------------------------|
| JSON          | `-f Json`        | Programmatic processing            |
| Plain text    | `-f PlainText`   | Readable archive                   |
| HTML (dark)   | `-f HtmlDark`    | Browser-viewable with styling      |
| HTML (light)  | `-f HtmlLight`   | Browser-viewable, light theme      |
| CSV           | `-f Csv`         | Spreadsheet import                 |

## Options

| Flag                | Purpose                                                |
|---------------------|--------------------------------------------------------|
| `-o PATH/`          | Output directory (trailing slash) or file path         |
| `--after DATE`      | Only messages after this date or message ID            |
| `--before DATE`     | Only messages before this date or message ID           |
| `--filter EXPR`     | Content filter (`from:user`, `has:link`, `has:image`)  |
| `--media`           | Download attached files, images, avatars               |
| `--reuse-media`     | Skip re-downloading already-fetched assets             |
| `--parallel N`      | Export N channels concurrently                         |
| `--reverse`         | Newest messages first                                  |
| `--utc`             | Normalize timestamps to UTC                            |
| `-p SIZE`           | Split output by message count (`100`) or size (`10mb`) |
| `--include-threads` | `None`, `Active`, or `All`                             |

## Constraints

- User tokens violate Discord TOS — use for personal archival only, not automation
- Rate limits enforced by default (`--respect-rate-limits`)
- Default output directory is cwd — always specify `-o` with trailing slash for directories
- Large exports (all DMs) can take significant time — use `--parallel` to speed up
- The `DISCORD_TOKEN` env var is read natively by the CLI
