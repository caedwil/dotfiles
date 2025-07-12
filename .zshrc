export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# fpath+=($HOME/.zsh/pure)
# autoload -U promptinit; promptinit
# prompt pure

export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"
export QML_IMPORT_PATH="/usr/lib/qt6/qml"

source "$HOME/.aliases"

eval "$(starship init zsh)"
