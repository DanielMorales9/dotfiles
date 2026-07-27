# dotfiles
```
Stop wasting hours setting up terminals on all your machines!
```

Useful dotfiles for terminal configuration on OSX and ~~Linux~~ machines.

Both `bash` and `zsh` are supported. `bootstrap.sh` sets `zsh` as the login shell,
but the config works in either.

## Installation instructions
 Clone the repository in your `$HOME` folder and run the following instructions:

```bash
cd dotfiles
./bootstrap.sh
```

Bootstrap symlinks your shell's rc file (`~/.zshrc`, or `~/.bash_profile` for bash)
to `init.sh`. If that rc file already exists and is not managed by this repo, it is
left alone and the `source` line to add is printed instead — that matters when the
file holds ordering-sensitive blocks, since sdkman requires being last.

## Layout

`init.sh` is the only entrypoint. It detects the *running* shell — not `$SHELL` — and
loads `shared/` followed by the matching `bash/` or `zsh/` directory, so the same
symlink target works for both.

| Path | Loaded by | Purpose |
| --- | --- | --- |
| `init.sh` | both | entrypoint; dispatches on the running shell |
| `shared/functions.sh` | both | shell-agnostic functions |
| `shared/aliases.sh` | both | shell-agnostic aliases |
| `bash/*.sh` | bash | `envs`, `aliases`, `completion`, `tools`, `prompt` |
| `zsh/*.zsh` | zsh | the same five files, in zsh |
| `utils.sh`, `bootstrap.sh` | install time | not sourced by shells |

Each shell directory holds the same five filenames, loaded in this order: `envs`,
`aliases`, `completion`, `tools`, `prompt`. Prompt is last because bash's `PS1`
depends on `__git_ps1`, which `completion.sh` provides. Adding a file to one shell
means adding its counterpart to the other.

Bootstrap installs sdkman with `rcupdate=false`, so its installer does not append an
init block to the rc files, which are symlinks into this repo. Nothing here sources
sdkman — if you want the `sdk` command, source `$SDKMAN_DIR/bin/sdkman-init.sh`
yourself, last, from a file outside this repo.

`shellcheck` and `shfmt` cannot parse zsh, so `zsh/*.zsh` is excluded from those
pre-commit hooks; everything else is linted.
