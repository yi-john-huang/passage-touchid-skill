# Optional legacy personal AWS static credentials

Prefer IAM Identity Center or temporary credentials; do not place SSO, assumed-role, temporary, work-owned, or ambiguously owned credentials in Passage. Only after explicit approval for a **personal legacy static** profile, preserve the original source and import via stdin an exact JSON object with `Version: 1`, nonempty string `AccessKeyId`, and nonempty string `SecretAccessKey` at `aws/<name>`. Do not print credential values, send them to logs, use shell arguments containing them, or create decrypted temporary files. Do not reuse an existing profile name.

Install `scripts/aws-passage-credentials` to `~/.local/bin/aws-passage-credentials` mode `0700` only when this integration is selected; Python 3 required (`brew install python` only when absent). The helper accepts exactly one safe entry name and validates an exact three-field static Version-1 JSON object in memory. Invalid retrieval/schema produces one generic value-free stderr message and no stdout. Do **not** run the real helper directly with stdout visible. For a newly named, approved personal profile in `~/.aws/config` use an **absolute** path (replace placeholder locally, do not use `~` or `$HOME`):

```ini
[profile <new-personal-static-profile>]
credential_process = /absolute/path/to/.local/bin/aws-passage-credentials <entry-name>
```

The helper output intentionally has no `Expiration`: it represents long-lived static credentials. Generic process credentials are not cached by AWS; repeated calls can prompt for Touch ID. Test only with `aws sts get-caller-identity --profile <new-personal-static-profile>` and display account/identity metadata only, never credentials. If identity/ownership is uncertain, skip. Keep original credential sources until separately approved removal. Other explicitly personal API secrets belong under `api/` and miscellaneous values under `misc/`, entered via stdin.
