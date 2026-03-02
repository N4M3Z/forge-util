# Contributing

Guide for adding utility skills to forge-util.

## Getting started

```bash
git clone --recurse-submodules https://github.com/N4M3Z/forge-util.git
cd forge-util
make install    # deploy skills to all providers
make verify     # confirm deployment
make test       # validate conventions (runs validate-module from forge-lib)
make lint       # schema + docs linting
```

If you cloned without `--recurse-submodules`:

```bash
git submodule update --init lib
```

## Skill structure

Each skill lives in its own directory under `skills/` with two required files:

```
skills/YourSkill/
    SKILL.md        # Canon — provider-neutral AI instructions
    SKILL.yaml      # Sidecar — provider routing and metadata
```

### SKILL.md (canon)

Provider-neutral frontmatter + AI instructions:

```yaml
---
name: YourSkill
description: "What this skill does. USE WHEN trigger keywords."
version: "1.0.0"
---
```

The `description` field drives skill discovery. Use `USE WHEN` to list trigger keywords explicitly.

### SKILL.yaml (sidecar)

Provider routing and deployment metadata. Canon fields (`name`, `description`, `version`) live in SKILL.md only — never duplicate them here.

## Adding a new utility skill

1. Create `skills/YourSkill/SKILL.md` and `skills/YourSkill/SKILL.yaml`
2. Add the skill to `defaults.yaml` under each target provider
3. Add tool dependencies to `INSTALL.md`
4. Run `make lint && make test`

## Deploy and validate

```bash
make install    # deploy to providers
make verify     # confirm installed
make test       # check conventions
make lint       # schema + docs
```

## Git

Conventional Commits: `type: description`. Lowercase, no trailing period, no scope.

Types: `feat`, `fix`, `docs`
