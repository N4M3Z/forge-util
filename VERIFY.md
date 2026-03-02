# Verify

## Health check

```bash
test -f Modules/forge-util/module.yaml       && echo "module.yaml present"
test -f Modules/forge-util/hooks/hooks.json   && echo "hooks.json present"
test -d Modules/forge-util/skills             && echo "skills/ present"
```

## Structure validation

```bash
make verify    # check skills deployed across all providers
```

## Functionality tests

```bash
command -v recall >/dev/null          && echo "recall: OK"          || echo "recall: NOT INSTALLED"
command -v slackdump >/dev/null       && echo "slackdump: OK"       || echo "slackdump: NOT INSTALLED"
test -x ~/.local/bin/dce/DiscordChatExporter.Cli && echo "dce: OK" || echo "dce: NOT INSTALLED"
```

## Success criteria

- Module directory exists with `module.yaml`, `hooks/hooks.json`
- Skills deployed to provider directories (`make verify` passes)
- At least one utility tool installed (recall, slackdump, or dce)
