#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

SCRIPT_PATH="$(readlink -f $0)"

REPOSITORY="https://github.com/xxczaki/dotfiles.git"
DIRECTORY="$HOME/.dot"

TO_SYNC=(
	".gitconfig"
	".npmrc"
	".vimrc"
	".zshrc"
	".config/neofetch/config.conf"
	"Library/Application Support/Code/User/settings.json"
	".ssh/config"
	".gnupg/gpg-agent.conf"
)

DATE=$(date +"%b %e, %Y %T %Z")
COMMIT_MESSAGE="Sync $DATE"

if [ "$#" -ne 1 ]; then
    echo "Available commands: sync"
    exit 1
fi

if [[ "$1" == 'sync' ]]; then
	if [ ! -d $DIRECTORY ]; then
		git clone $REPOSITORY $DIRECTORY
	fi

	cd $DIRECTORY

	git fetch --all
	git reset --hard

	for file in ${TO_SYNC[@]}; do
		# Alternative: `gcp --parents` (requires `brew install coreutils`).
		# `cp --parents` on Linux.
  	rsync -R $HOME/$file .
	done

	cd .$HOME

	# Remove the _auth token; see https://github.com/npm/npm/issues/4905.
	sed -i '' '/_auth/d' .npmrc

	# Populate a `Brewfile`
	brew bundle dump --file Brewfile --force

	# Save VS Code extensions list
	code --list-extensions > vscode-extensions.txt

	# Add .hushlogin
	touch .hushlogin

	# Finally, copy the `dot.sh` script itself
	cp $SCRIPT_PATH $DIRECTORY/dot.sh

	cd $DIRECTORY

	git add .
	git commit -m $COMMIT_MESSAGE -n --no-gpg-sign --allow-empty
	git push

	echo "Dotfiles synced"
else
  echo "Invalid command: $1"
  exit 1
fi