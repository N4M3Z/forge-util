# Install

## Requirements

| Dependency                                                                       | Required    | Install                                                            |
|----------------------------------------------------------------------------------|-------------|--------------------------------------------------------------------|
| [DiscordChatExporter.Cli](https://github.com/Tyrrrz/DiscordChatExporter)         | For Discord | Download .NET binary to `~/.local/bin/dce/`                        |
| [slackdump](https://github.com/rusq/slackdump)                                  | For Slack   | `brew install slackdump`                                           |
| [recall](https://github.com/zippoxer/recall)                                    | For Sessions| `brew install zippoxer/tap/recall`                                 |
| Python 3                                                                         | For Sessions| `brew install python3` (session index repair script)               |
| [safety-net](https://github.com/kenryu42/claude-code-safety-net)                | Recommended | Blocks destructive commands — see [root INSTALL.md](../../INSTALL.md) |

## Deploy

Already included in `defaults.yaml` as a forge module. No build step required.

```bash
make install    # deploy skills to all providers
make verify     # check deployment
```

## Configuration

Each skill manages its own authentication:

- **DiscordCLI**: `DISCORD_TOKEN` in `.env` (gitignored)
- **SlackCLI**: `slackdump workspace new` (browser-based, cached per workspace)
- **Sessions**: No auth needed (reads local files)

## Troubleshooting

| Problem                                      | Fix                                                              |
|----------------------------------------------|------------------------------------------------------------------|
| `dce` command not found                      | Ensure `~/.local/bin/dce/` is in PATH                            |
| `slackdump` workspace auth expired           | Re-run `slackdump workspace new`                                 |
| `recall` returns no results                  | Run `recall --reindex` to rebuild search index                   |
| Session repair script errors                 | Check Python 3 installed: `python3 --version`                    |
