# forge-util — skills, test, and lint

LIB_DIR = $(or $(FORGE_LIB),lib)

.PHONY: help install clean verify test lint check init check-lib

help:
	@echo "forge-util targets:"
	@echo "  make install  Deploy skills (Claude, Gemini, Codex, OpenCode)"
	@echo "  make verify   Check skills deployed across all providers"
	@echo "  make clean    Remove previously installed skills"
	@echo "  make test     Run module validation"
	@echo "  make lint     Schema + docs linting"
	@echo "  make check    Verify module structure"

init:
	@if [ ! -d $(LIB_DIR)/mk ]; then \
	  echo "Initializing forge-lib submodule..."; \
	  git submodule update --init $(LIB_DIR); \
	fi

ifneq ($(wildcard $(LIB_DIR)/mk/common.mk),)
  include $(LIB_DIR)/mk/common.mk
endif

ifneq ($(wildcard $(LIB_DIR)/mk/skills/install.mk),)
  include $(LIB_DIR)/mk/skills/install.mk
endif

ifneq ($(wildcard $(LIB_DIR)/mk/skills/verify.mk),)
  include $(LIB_DIR)/mk/skills/verify.mk
endif

ifneq ($(wildcard $(LIB_DIR)/mk/lint.mk),)
  include $(LIB_DIR)/mk/lint.mk
endif

check-lib:
	@if [ ! -f "$(LIB_DIR)/Cargo.toml" ]; then \
	  echo ""; \
	  echo "ERROR: forge-lib submodule is not initialized."; \
	  echo "Run: make init && make install"; \
	  echo ""; \
	  exit 1; \
	fi

install: check-lib install-skills
	@echo "Installation complete. Restart your session or reload skills."

clean: clean-skills

verify: verify-skills

test: $(VALIDATE_MODULE)
	@$(VALIDATE_MODULE) $(CURDIR)

lint: lint-schema lint-shell lint-docs

check:
	@test -f module.yaml && echo "  ok module.yaml" || echo "  MISSING module.yaml"
	@test -x "$(VALIDATE_MODULE)" && echo "  ok validate-module" || echo "  MISSING validate-module (run: make -C $(LIB_DIR) build)"
