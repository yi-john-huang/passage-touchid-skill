# Technology Stack

## Architecture
This is an Agent Skills documentation repository, not an application or service. `.agents/skills/passage-touchid-credentials/SKILL.md` is canonical; its relative references carry the detailed workflow. The project-local `.claude/skills/passage-touchid-credentials` symlink resolves to that same directory. The three standalone helpers in `scripts/` have no build step or package manifest.

## Runtimes and dependencies
- `scripts/install-skill.sh` and `scripts/passage-ssh-add`: Bash; installation requires `realpath`, `mkdir`, and `ln`; the SSH loader calls `passage` and `ssh-add`.
- `scripts/aws-passage-credentials`: Python 3 standard library (`json`, `re`, `subprocess`, `sys`) and `passage`; only for an approved personal static AWS profile.
- The **user's** macOS 14+ setup needs Homebrew, Touch ID, FileVault, `age`, `age-plugin-se`, `gnu-getopt`, `tree`, and maintained `FiloSottile/passage`. For tagged recipients, age >= 1.3; older supported age must consistently use `se`. Python 3 is only required for the optional AWS path.
- No pinned Bash or Python minor version, package manager lockfile, framework, or CI configuration exists in this checkout.

## Verified repository commands
```sh
bash -n scripts/passage-ssh-add scripts/install-skill.sh
PYTHONPYCACHEPREFIX=/tmp/passage-touchid-pycache python3 -m py_compile scripts/aws-passage-credentials
```
The project skill was also discovered through `omp -p --cwd \"$PWD\" --no-session 'Read skill://passage-touchid-credentials/SKILL.md and report its frontmatter name only; do not run setup commands'` from this checkout. Run `scripts/install-skill.sh` only when global links are wanted; verify both destinations before invoking it. Do not run real credential helpers with stdout exposed or treat syntax checks as proof of live Touch ID/recovery.
