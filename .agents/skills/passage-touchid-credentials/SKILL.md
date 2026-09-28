---
name: passage-touchid-credentials
description: Set up personal macOS Passage and age-plugin-se Secure Enclave Touch ID secrets, SSH agent keys, independent recovery, and optional legacy AWS credential_process. Use for safe personal credential setup or migration; never process work credentials.
---

# Personal Passage + Touch ID

Use this workflow only for credentials confirmed personal. Never inspect or migrate work-owned or ambiguous sources. Do not display, log, commit, or send private keys, identities, decrypted secrets, hostnames, fingerprints, or credentials. Never bypass human Touch ID/passphrase prompts; never materialize decrypted temporary files. Ask approval before importing any real credential or changing SSH/AWS configuration. Stop on a failed Touch ID or recovery verification.

1. Read [bootstrap](references/bootstrap.md) for read-only prerequisites, installation, independent recovery, recipient consistency, and dummy-entry verification. Never overwrite an unknown `~/.passage`.
2. If SSH is requested, read [SSH](references/ssh.md). Use the bundled `scripts/passage-ssh-add` only with user approval.
3. If an explicitly personal legacy static AWS profile is requested, read [AWS](references/aws.md). Prefer IAM Identity Center/temporary credentials; otherwise skip AWS. Other personal API/misc secrets can use Passage via stdin.
4. Read [recovery](references/recovery.md) before backup, migration, restore, or deletion.

Proceed in small, reversible steps; demonstrate dummy-data behavior before importing real secrets. Keep the private store and its Git history out of this public project.
