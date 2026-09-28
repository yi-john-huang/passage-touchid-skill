# Personal SSH, agent TTL, and fallback

Get explicit approval; classify candidate keys only by filename, key type and **public** fingerprint (`ssh-keygen -lf path.pub`), not by viewing private material. Skip work or ambiguous keys. When a new key is needed, `ssh-keygen -t ed25519 -a 100 -f "$HOME/.ssh/id_ed25519_personal"` with a human-chosen passphrase. Retain the original encrypted key until a separately approved deletion; never store an unencrypted private key or copy a decrypted key to a temporary file.

After the bootstrap dummy checks pass, import an approved personal encrypted key via stdin: `passage insert -m ssh/<entry-name> < "$HOME/.ssh/id_ed25519_personal"`. Keep the protected original as a fallback. Install the bundled `scripts/passage-ssh-add` to `~/.local/bin/passage-ssh-add` mode `0700` **only if SSH integration is selected**. Run `passage-ssh-add <entry-name>` in the user's Terminal with Touch ID and (if present) the inner SSH-key passphrase; it pipes `passage show "ssh/$entry" | ssh-add -t 1h -` and never writes a decrypted key. Touch ID authorizes Passage **on agent load**, not on every SSH connection. The key's own passphrase is a separate prompt. A non-exportable, per-use Touch ID SSH key is a different design (e.g., Secretive), not this recovery-friendly Passage workflow.

In `~/.ssh/config`, scope the personal stanza **before** a broad `Host *` 1Password stanza. Example (replace placeholders privately, never copy actual host details into this repository):

```sshconfig
Host <personal-alias>
    HostName <verified-host>
    User <personal-user>
    IdentityAgent SSH_AUTH_SOCK
    IdentityFile ~/.ssh/id_ed25519_personal
    IdentitiesOnly yes

Host *
    IdentityAgent "<existing-1Password-agent-socket>"
```

Preserve unrelated host stanzas and the existing broad agent path. `IdentityFile` must name the retained **encrypted private** file, not `.pub`; when the 1-hour agent entry expires, SSH can prompt for its passphrase rather than parsing a public key as private. Verify `ssh -G <personal-alias>` and `ssh -G <unrelated-host>` for agent/key selection. With the host key independently verified, use `ssh-copy-id -i "$HOME/.ssh/id_ed25519_personal.pub" <personal-alias>` only when user-authorized password login is available; otherwise use an approved public-key enrollment route. Then in the user's Terminal prove publickey-only authentication: `ssh -o PreferredAuthentications=publickey -o PasswordAuthentication=no <personal-alias> 'printf PUBLICKEY_OK'`. Prove fallback without agent: `ssh -o IdentityAgent=none <personal-alias> 'printf PRIVATE_FALLBACK_OK'`; enter the private key passphrase personally. Do not disable remote password login as part of this workflow. `ssh-add -d <public-key-file>` removes one key from the normal agent; `ssh-add -D` removes **all** its keys (not a 1Password agent's entries).
