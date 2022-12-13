# Dotfiles 🔮

> Backup of settings and preferences

---

## GnuPG

The agent configuration is fine-tuned to support Git commit signing via YubiKey.

## SSH

The config is extended to use 1Password's SSH integration.

## Visual Studio Code

> **Note**
>
> This can be handled automatically by using Settings Sync.

List of installed extensions:

```bash
$ code --list-extensions

1Password.op-vscode
aaron-bond.better-comments
atomiks.moonlight
bradlc.vscode-tailwindcss
BriteSnow.vscode-toggle-quotes
dbaeumer.vscode-eslint
GraphQL.vscode-graphql
GraphQL.vscode-graphql-syntax
kisstkondoros.vscode-gutter-preview
mikestead.dotenv
ms-vsliveshare.vsliveshare
natqe.reload
PKief.material-icon-theme
Prisma.prisma
ritwickdey.LiveServer
styled-components.vscode-styled-components
waderyan.gitblame
XadillaX.viml
```

## Neofetch

Only small visual changes.

## .hushlogin

See https://kb.iu.edu/d/acdd.

## NPM

Configured so that sudo is not required during `npm install`.

## Homebrew

Install Homebrew if it doesn't exist. Then, install the dependencies listed in the `Brewfile`:

```bash
if ! command -v brew &> /dev/null
then
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle
```

### License

MIT
