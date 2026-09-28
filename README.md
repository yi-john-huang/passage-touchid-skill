# Passage Touch ID credentials skill

A portable [Agent Skills](https://agentskills.io/specification) workflow for **personal** macOS 14+ secrets: Passage + age-plugin-se (Secure Enclave/Touch ID), independent passphrase recovery, SSH agent loading, and an optional explicitly approved legacy static AWS profile. MIT licensed. No credential store, personal host configuration, identity, or private key belongs in this repository.

## Start

Requires a Mac with enrolled Touch ID, FileVault, Homebrew, and a human available for prompts. The skill checks prerequisites before installing `age`, `age-plugin-se`, `gnu-getopt`, `tree`, or the maintained [FiloSottile/passage](https://github.com/FiloSottile/passage). Python 3 is needed only for optional AWS integration. Work credentials are out of scope; uncertain ownership means skip.

From this checkout, Codex and OMP discover `.agents/skills/passage-touchid-credentials/SKILL.md`; Claude Code discovers `.claude/skills/passage-touchid-credentials`, a relative symlink to that **same** canonical skill. For global discovery run `scripts/install-skill.sh`: it preflights both destinations, installs symlinks to `~/.agents/skills/` and `~/.claude/skills/`, never overwrites another skill, and rolls back links made by a failed invocation. Global symlinks point to this checkout; keep it in place. No global installation is required when running inside this project.

Ask the agent: “Use the passage-touchid-credentials skill to walk me through a personal Passage + Touch ID setup; preflight only first, no imports until I approve.” In Claude Code invoke `/passage-touchid-credentials`; in Codex select or mention `$passage-touchid-credentials`; in OMP request `skill://passage-touchid-credentials/SKILL.md` or ask for the skill by name. Approve each real import/configuration change separately; all Touch ID and passphrase prompts belong to you.

## Security boundaries

The primary Secure Enclave identity stays device-bound. A second age identity is passphrase-encrypted for independent recovery; both public recipients protect every entry. First verify a dummy entry with Touch ID **and** the recovery passphrase. The recovery backup needs encrypted store Git history, `identities.backup.age`, and independently held passphrase. Store filenames/Git history reveal metadata. Never publish or sync the private store without separate approval.

SSH integration is opt-in: install `scripts/passage-ssh-add` to `~/.local/bin/passage-ssh-add` mode `0700` only then. Loading prompts for Touch ID; subsequent SSH connections use a one-hour agent entry. Retain an encrypted private key for passphrase fallback; a `.pub` file cannot serve as private-key fallback. Per-connection Touch ID requires another agent design such as Secretive. `scripts/aws-passage-credentials` is likewise opt-in for a **new personal static** AWS profile, installed to `~/.local/bin/aws-passage-credentials` mode `0700`. Prefer IAM Identity Center/temporary credentials. Never display the real helper's stdout; use `aws sts get-caller-identity --profile <new-personal-profile>` to inspect metadata only.

## Troubleshooting

- Existing unknown `~/.passage`: stop, investigate provenance without overwriting it.
- Passage insert fails on macOS: check `gnu-getopt` PATH with `brew info gnu-getopt`; listings require `tree`.
- `age-plugin-se` recipient fails: use matching `--recipient-type tag` for age >=1.3 in both keygen and recipients; otherwise consistently use `se`.
- SSH says `.pub: invalid format` after agent expiration: the personal stanza must select the encrypted **private** file; check `ssh -G <personal-alias>` and leave the other hosts' agent alone.
- Recovery fails: stop imports; verify both recipients and the independently held passphrase before any real migration.
- AWS process repeats Touch ID: generic credential processes are not cached by AWS; switch to Identity Center where possible.

See the skill's relative `references/` files for detailed setup, SSH, AWS, and backup procedures. Helpers operate only on approved personal entries and never print secrets on validation failure.
