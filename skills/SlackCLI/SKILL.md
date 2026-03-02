---
name: SlackCLI
version: 0.1.0
description: "Export Slack messages — DMs, channels, threads, search. USE WHEN slack, export messages, pull DMs, slack history, slack export, slack search."
---

# SlackCLI

Export Slack messages using slackdump CLI. Supports DMs, channels, threads, search, date filtering, and file attachments.

## Usage

| Tool         | Location                      | Purpose                           |
|--------------|-------------------------------|-----------------------------------|
| `slackdump`  | `/opt/homebrew/bin/slackdump` | Slack workspace export CLI (v4+)  |

## Authentication

Uses EZ-Login 3000 (browser-based) — no tokens needed. Credentials cached per-workspace.

```bash
# First-time setup — opens a browser for Slack login
slackdump workspace new

# List authenticated workspaces
slackdump workspace list

# Switch workspace
slackdump workspace select
```

Workspaces cached in `~/Library/Caches/slackdump/`.

## Workflow Routing

| Workflow            | Trigger                                                    | Section                              |
|---------------------|------------------------------------------------------------|--------------------------------------|
| **List Channels**   | "list channels", "show channels", "what channels"          | [List Channels](#list-channels)      |
| **Export Channels**  | "export channel", "pull channel", "download channel"       | [Export Channels](#export-channels)  |
| **Export DMs**      | "export DMs", "pull DMs", "download messages"              | [Export DMs](#export-dms)            |
| **Dump Specific**   | "dump thread", "dump conversation", "specific messages"    | [Dump](#dump)                        |
| **Search**          | "search slack", "find messages", "search for"              | [Search](#search)                    |
| **View**            | "view export", "read export", "open archive"               | [View](#view)                        |

## List Channels

```bash
# All visible channels (public, private, DMs, group messages)
slackdump list channels

# JSON output
slackdump list channels -format JSON

# Only channels you belong to
slackdump list channels -member-only

# Filter by type (im = DMs, mpim = group DMs, public_channel, private_channel)
slackdump list channels -chan-types im
```

## List Users

```bash
slackdump list users
slackdump list users -format JSON
```

## Export Channels

### Entire workspace

```bash
slackdump export -o workspace.zip
```

### Specific channels

```bash
slackdump export -o export.zip C051D4052 C07ABCDEF
```

### Only channels you belong to

```bash
slackdump export -member-only -o my-channels.zip
```

### By channel URL

```bash
slackdump export -o export.zip https://myworkspace.slack.com/archives/C051D4052
```

## Export DMs

### All DMs only

```bash
slackdump export -chan-types im -o dms.zip
```

### All group DMs only

```bash
slackdump export -chan-types mpim -o group-dms.zip
```

### All DMs and group DMs

```bash
slackdump export -chan-types im,mpim -o all-dms.zip
```

### Specific DM by ID or URL

```bash
slackdump export -o dm.zip DHYNUJ00Y
slackdump export -o dm.zip https://myworkspace.slack.com/archives/DHYNUJ00Y
```

## Dump

Low-level JSON dump of specific conversations or threads. Use when you need raw API output rather than Slack Export format.

### Specific conversations

```bash
slackdump dump C051D4052 DHYNUJ00Y
```

### Specific thread

```bash
# By URL
slackdump dump https://myworkspace.slack.com/archives/C051D4052/p1665917454731419

# By colon notation (channel:thread_ts)
slackdump dump C051D4052:1665917454.731419
```

### From a file list

```bash
slackdump dump @my_channels.txt
```

### Convert dump to readable format

```bash
slackdump format <dump_file>
```

## Search

```bash
# Search messages
slackdump search messages "meeting notes"

# Search files
slackdump search files "report"

# Search both
slackdump search all "project updates"

# Faster (skip user resolution)
slackdump search messages -no-channel-users "status update"
```

## View

```bash
# View an export or dump in the browser
slackdump view export.zip
slackdump view dump_file.json
```

## Filtering

### Date range

```bash
# UTC timestamps, format: YYYY-MM-DDTHH:MM:SS
slackdump export -o export.zip -time-from 2025-01-01T00:00:00 -time-to 2025-06-01T00:00:00

slackdump dump -time-from 2025-01-01T00:00:00 C051D4052
```

### Channel types

| Type              | Flag value        |
|-------------------|-------------------|
| DMs               | `im`              |
| Group DMs         | `mpim`            |
| Public channels   | `public_channel`  |
| Private channels  | `private_channel` |
| All (default)     | `mpim,im,public_channel,private_channel` |

## Options

| Flag                    | Purpose                                                  |
|-------------------------|----------------------------------------------------------|
| `-o PATH`               | Output file (`.zip`) or directory                        |
| `-time-from TIMESTAMP`  | Only messages after this UTC timestamp                   |
| `-time-to TIMESTAMP`    | Only messages before this UTC timestamp                  |
| `-chan-types TYPES`      | Filter channel types (comma-separated)                   |
| `-member-only`          | Only channels the current user belongs to                |
| `-files`                | Download file attachments (default: true)                |
| `-files=false`          | Skip file downloads                                     |
| `-avatars`              | Download user avatars                                    |
| `-type standard`        | Standard file storage (for slack-export-viewer compat)   |
| `-workspace NAME`       | Override which workspace to use                          |
| `-v`                    | Verbose output                                           |
| `-y`                    | Answer yes to all prompts                                |

## Constraints

- First run requires `slackdump workspace new` — interactive browser login
- Date filtering uses UTC timestamps, not local time
- Large workspace exports can take significant time due to Slack rate limits
- Default output is a ZIP file in Slack Export format
- The `dump` command produces raw JSON (not Slack Export format) — use `slackdump format` to convert
- Search outputs to a database directory, not directly to JSON files
