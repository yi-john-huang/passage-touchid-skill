# Project Structure

## Published layout
- `README.md` explains project-local and global skill discovery, consent, and security boundaries; `LICENSE` is MIT.
- `.agents/skills/passage-touchid-credentials/SKILL.md` is the canonical Agent Skills entry point. `references/bootstrap.md`, `ssh.md`, `aws.md`, and `recovery.md` are selected by the agent only for relevant tasks.
- `.claude/skills/passage-touchid-credentials` is a tracked **relative symlink** to the canonical skill, not an independent instruction copy. Preserve it when changing `.gitignore` or installing local tooling.
- `scripts/install-skill.sh` creates opt-in global links after checking both destinations. `scripts/passage-ssh-add` and `scripts/aws-passage-credentials` are opt-in standalone helpers. No `src/`, `tests/`, `dist/`, build configuration, or test framework is present.

## Local workflow files
`.spec/steering/` holds these project-specific documents. `CLAUDE.md` and `.mcp.json` are local SDD tooling configuration; `.omp/`, `.sdd-mcp/`, and additional `.claude/` generated files are ignored by the current `.gitignore` except for the already tracked Claude skill symlink. Keep tool configuration generic; never embed host paths, tokens, or credential values.

## Change boundaries
Keep the skill's frontmatter `name`/`description` and all relative reference links valid. Keep SSH/AWS entry names restricted to one safe component; AWS emits only validated static Version-1 JSON. Change helper behavior in `scripts/`, workflow wording in the relevant reference, and user-facing usage in `README.md` together. Keep real `~/.passage`, `~/.ssh`, `~/.aws`, backups, bytecode, and decrypted material out of Git; do not introduce a credential fixture into the public checkout.
