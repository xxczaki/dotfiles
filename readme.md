# Dotfiles 🔮

> Backup of settings and preferences.

## Usage

The management of my dotfiles is partially automated through a custom shell script, [`dot.sh`](https://github.com/xxczaki/dotfiles/blob/main/dot.sh).

### Syncing

1. Download this script and place it somewhere where it can be easily accessed — I recommend using the home directory or creating an alias.
2. Adjust the top-level variables, specifically:
    - `REPOSITORY` — remote git repository address which will be used for syncing;
    - `TO_SYNC` — an array of file paths (relative to the user's home directory) which you want to upload to the remote.
3. (*optional*) Modify the code to add additional syncing logic, e.g. stripping private tokens to prevent them from being released to the internet.
4. Run `./dot.sh sync`:

This will first:
 - clone your repository to `$HOME/.dot` (this path can be modified) or, if it already exists:
 - fetch any changes from the remote.

It will then execute the syncing logic and put its artifacts (dotfiles) in the aforementioned directory. Finally, everything will be pushed to the remote.

### Restoring

WIP

### sync

### GnuPG

The agent configuration is fine-tuned to support Git commit signing via YubiKey.

### SSH

The config is extended to use 1Password's SSH integration.

### Visual Studio Code

> **Note**
>
> VS Code remembers these via Settings Sync.

Settings and a list of installed extensions are included.

### Neofetch

Only some small visual changes.

### Git

Small tweaks, including commit signing.

### .hushlogin

See https://kb.iu.edu/d/acdd.

### NPM

Configured so that sudo is not required during `npm install`.

### Vim

Although I don't use Vim as my editor of choice, I like to have it configured according to my needs. The config is somewhat inspired by https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim.

### Homebrew

Install Homebrew if it doesn't exist. Then, install the dependencies listed in the `Brewfile`:

```bash
if ! command -v brew &> /dev/null
then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle
```

### iTerm 2

Many visual and quality-of-life changes. Color theme: https://github.com/sindresorhus/iterm2-snazzy.

## License

MIT
