# CLAUDE.md — Spec-Driven Development

## Workflow

After installation, reload or restart the host and accept project trust. Use `/simple-task <description>` for small changes. For formal work, invoke `/sdd-requirements <feature-name>`, then `/sdd-design`, `/sdd-tasks`, and `/sdd-implement` after each explicit approval.
Skills automatically restore durable workflow state and approved compact context; users do not call MCP tools or paste workflow JSON.

## On-demand directories

- Skills: `.claude/skills/`
- Hooks: `.claude/hooks/`
- Steering: `.spec/steering/`

## Model routing

High-level planning, architecture, review, and security execute in the current turn on Opus.
Implementation and TDD execute in the current turn on Sonnet; do not spawn a redundant specialist.
