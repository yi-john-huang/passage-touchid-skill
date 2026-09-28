#!/usr/bin/env bash
set -euo pipefail

skill_name=passage-touchid-credentials
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
canonical="$(cd -- "$script_dir/../.agents/skills/$skill_name" && pwd -P)"
[[ -f "$canonical/SKILL.md" ]] || { printf 'Canonical skill missing\n' >&2; exit 1; }

destinations=("$HOME/.agents/skills/$skill_name" "$HOME/.claude/skills/$skill_name")
created=()
rollback() {
    if (( $? != 0 )); then
        for link in "${created[@]}"; do
            rm -- "$link"
        done
    fi
}
trap rollback EXIT

# Preflight both destinations before creating either link.
for destination in "${destinations[@]}"; do
    if [[ -e "$destination" || -L "$destination" ]]; then
        if [[ ! -L "$destination" || "$(realpath -- "$destination")" != "$canonical" ]]; then
            printf 'Refusing to overwrite existing skill destination: %s\n' "$destination" >&2
            exit 1
        fi
    fi
done

for destination in "${destinations[@]}"; do
    if [[ ! -L "$destination" ]]; then
        mkdir -p -- "$(dirname -- "$destination")"
        ln -s -- "$canonical" "$destination"
        created+=("$destination")
    fi
done
printf 'Skill available to Codex, OMP, and Claude Code.\n'
