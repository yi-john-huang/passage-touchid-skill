# Passage Touch ID credentials skill

A portable [Agent Skills](https://agentskills.io/specification) workflow for **personal** macOS 14+ secrets: Passage + age-plugin-se (Secure Enclave/Touch ID), independent passphrase recovery, SSH agent loading, and an optional explicitly approved legacy static AWS profile. MIT licensed. No credential store, personal host configuration, identity, or private key belongs in this repository.

## Quickstart

1. On a Mac with enrolled Touch ID, FileVault, and Homebrew, clone this **public skill repository** (not a credential store):

   ```sh
   git clone https://github.com/yi-john-huang/passage-touchid-skill.git
   cd passage-touchid-skill
   ```

2. Open your agent in this directory. Codex and OMP discover `.agents/skills/passage-touchid-credentials/SKILL.md`; Claude Code discovers `.claude/skills/passage-touchid-credentials`, a relative symlink to the same canonical skill. To use the skill from **other projects**, run `./scripts/install-skill.sh` from this checkout once; it preflights and creates global links under `~/.agents/skills/` and `~/.claude/skills/` without replacing existing skills. Keep this checkout in place for those links to work.
3. In your agent, request a **read-only preflight** before any setup:
   - **Claude Code:** `/passage-touchid-credentials` followed by “Help me set up personal Passage + Touch ID; preflight only, no imports until I approve.”
   - **Codex:** “Use `$passage-touchid-credentials` to help me set up personal Passage + Touch ID; preflight only, no imports until I approve.”
   - **OMP:** “Read `skill://passage-touchid-credentials/SKILL.md` and help me set up personal Passage + Touch ID; preflight only, no imports until I approve.”
4. Review each proposed change and approve any real import or SSH/AWS configuration separately. Enter Touch ID and recovery/key passphrases yourself; verify both dummy-entry decryption paths before importing real secrets. SSH and legacy static AWS integrations are optional. Skip work or ambiguously owned credentials.

The workflow checks prerequisites before installing `age`, `age-plugin-se`, `gnu-getopt`, `tree`, or maintained [FiloSottile/passage](https://github.com/FiloSottile/passage). Python 3 is needed only for optional AWS integration. A project-local skill needs no global installation.

## Security boundaries

The primary Secure Enclave identity stays device-bound. A second age identity is passphrase-encrypted for independent recovery; both public recipients protect every entry. First verify a dummy entry with Touch ID **and** the recovery passphrase. The recovery backup needs encrypted store Git history, `identities.backup.age`, and independently held passphrase. Store filenames/Git history reveal metadata. Never publish or sync the private store without separate approval.

SSH integration is opt-in: install `scripts/passage-ssh-add` to `~/.local/bin/passage-ssh-add` mode `0700` only then. Loading prompts for Touch ID; subsequent SSH connections use a one-hour agent entry. A `Match originalhost <alias> exec "passage-ssh-add --if-missing <key> <entry>"` stanza reloads the key with Touch ID whenever it is missing from the agent; storing the key passphrase as `ssh/<entry>-passphrase` makes that a single Touch ID with no passphrase typing. Retain an encrypted private key for passphrase fallback; a `.pub` file cannot serve as private-key fallback. Per-connection Touch ID requires another agent design such as Secretive. `scripts/aws-passage-credentials` is likewise opt-in for a **new personal static** AWS profile, installed to `~/.local/bin/aws-passage-credentials` mode `0700`. Prefer IAM Identity Center/temporary credentials. Never display the real helper's stdout; use `aws sts get-caller-identity --profile <new-personal-profile>` to inspect metadata only.

## Troubleshooting

- Existing unknown `~/.passage`: stop, investigate provenance without overwriting it.
- Passage insert fails on macOS: check `gnu-getopt` PATH with `brew info gnu-getopt`; listings require `tree`.
- `age-plugin-se` recipient fails: use matching `--recipient-type tag` for age >=1.3 in both keygen and recipients; otherwise consistently use `se`.
- SSH says `.pub: invalid format` after agent expiration: the personal stanza must select the encrypted **private** file; check `ssh -G <personal-alias>` and leave the other hosts' agent alone.
- SSH asks `Enter passphrase for key` instead of Touch ID: the agent is empty (`ssh-add -l`). Add the `Match originalhost … exec "passage-ssh-add --if-missing …"` stanza and the `ssh/<entry>-passphrase` entry described in `references/ssh.md`.
- Recovery fails: stop imports; verify both recipients and the independently held passphrase before any real migration.
- AWS process repeats Touch ID: generic credential processes are not cached by AWS; switch to Identity Center where possible.

See the skill's relative `references/` files for detailed setup, SSH, AWS, and backup procedures. Helpers operate only on approved personal entries and never print secrets on validation failure.
