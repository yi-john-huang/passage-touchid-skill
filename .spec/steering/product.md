# Product Overview

## Purpose and users
This public Agent Skills repository guides people setting up **personal** macOS 14+ Passage and age-plugin-se secrets with Secure Enclave/Touch ID. Claude Code, Codex, and OMP load one canonical skill; the human approves configuration changes and handles all biometric and passphrase prompts.

## Capabilities
- Read-only prerequisite checks before setup; independent passphrase recovery identity alongside the device-bound Secure Enclave identity.
- Dummy-entry verification of both decryption routes before importing real credentials.
- Optional personal SSH-key import and one-hour agent loading; retain the encrypted private file for passphrase fallback.
- Optional **legacy personal static** AWS `credential_process` helper; prefer IAM Identity Center or temporary credentials.
- Local encrypted-store backup guidance, including independent recovery checks.

## Boundaries and success
Never process work-owned or ambiguously owned credentials; never overwrite an unknown Passage store, display secrets, or publish identities, keys, host configuration, credential values, or encrypted-store history. The public repository contains only generic guidance and vetted helpers. A successful setup has user-approved real imports only after both dummy checks; live Touch ID, SSH, and AWS checks require the user's own interaction. No product metrics or adoption targets are defined here.
