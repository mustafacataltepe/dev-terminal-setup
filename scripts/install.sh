#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Installing dev terminal setup..."

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "📦 Installing packages..."
sudo apt update
sudo apt install -y \
  kitty \
  tmux \
  zsh \
  git \
  curl \
  zoxide \
  devilspie2 \
  unzip \
  wget \
  xclip \
  gawk \
  xdotool \
  wmctrl

echo "🐚 Setting zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

echo "⚙️ Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "🎨 Installing Powerlevel10k..."
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git clone https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

echo "🔌 Installing zsh plugins..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

echo "🔍 Installing fzf..."
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  "$HOME/.fzf/install" --key-bindings --completion --no-update-rc
fi

echo "🔽 Installing tdrop..."
mkdir -p "$HOME/tools"
if [ ! -d "$HOME/tools/tdrop" ]; then
  git clone https://github.com/noctuid/tdrop.git "$HOME/tools/tdrop"
fi
chmod +x "$HOME/tools/tdrop/tdrop"

echo "🧩 Installing tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo "🔤 Installing JetBrainsMono Nerd Font..."
mkdir -p "$HOME/.local/share/fonts"
if ! fc-list | grep -qi "JetBrains.*Nerd"; then
  cd "$HOME/.local/share/fonts"
  wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip -O JetBrainsMono.zip
  unzip -o JetBrainsMono.zip
  rm JetBrainsMono.zip
  fc-cache -fv
fi

echo "📁 Creating config directories..."
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/devilspie2"

echo "🔗 Linking config files..."

ln -sf "$REPO_DIR/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$REPO_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$REPO_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
ln -sf "$REPO_DIR/devilspie2/dropdown.lua" "$HOME/.config/devilspie2/dropdown.lua"

echo "✅ Installation complete."
echo
echo "Next steps:"
echo "1. Add this command to a keyboard shortcut such as F12:"
echo "   $HOME/tools/tdrop/tdrop -n dropdown -x 0 -y 0 -w 100% -h 40% -- kitty --class dropdown"
echo
echo "2. Add devilspie2 to Startup Applications."
echo
echo "3. Restart terminal or run:"
echo "   pkill kitty"
echo
echo "4. Inside tmux, install plugins with:"
echo "   Ctrl+a then Shift+I"
echo
echo "5. Log out/in once if zsh was newly set as default shell."
