# 🚀 Dev Terminal Setup (Kitty + tmux + zsh + fzf + zoxide)

This repository contains a fully configured modern terminal environment with:

* Dropdown terminal (Guake-like)
* Persistent sessions (tmux)
* Smart shell (zsh + powerlevel10k)
* Fuzzy search (fzf)
* Intelligent navigation (zoxide)

---

# 🧱 PART 1 — Installation & Setup

## 📦 1. Install core packages

```bash
sudo apt update
sudo apt install kitty tmux zsh git curl zoxide devilspie2
```

---

## 🐚 2. Set zsh as default shell

```bash
chsh -s $(which zsh)
```

Log out and log back in (or run `zsh` once).

---

## ⚙️ 3. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

## 🎨 4. Install Powerlevel10k

```bash
git clone https://github.com/romkatv/powerlevel10k.git \
  ~/.oh-my-zsh/custom/themes/powerlevel10k
```

---

## 🔌 5. Install zsh plugins

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

---

## 🔍 6. Install fzf (full version)

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

Enable all options (keybindings + completion).

---

## 🔽 7. Install dropdown terminal (tdrop)

```bash
git clone https://github.com/noctuid/tdrop.git ~/tools/tdrop
chmod +x ~/tools/tdrop/tdrop
```

Example command:

```bash
~/tools/tdrop/tdrop -n dropdown -x 0 -y 0 -w 100% -h 40% -- kitty --class dropdown
```

Bind this to a hotkey (e.g. F12).

---

## 📌 8. Always-on-top behavior

```bash
mkdir -p ~/.config/devilspie2
nano ~/.config/devilspie2/dropdown.lua
```

```lua
if (get_window_class() == "dropdown") then
    set_window_above(true)
    set_skip_tasklist(true)
    set_skip_pager(true)
end
```

Run:

```bash
devilspie2 &
```

---

## 🔤 9. Install Nerd Font

Install JetBrainsMono Nerd Font and configure in Kitty:

```conf
font_family JetBrainsMono Nerd Font
```

---

## 🔁 10. Restore configuration files

Copy these files:

```text
~/.zshrc
~/.p10k.zsh
~/.tmux.conf
~/.config/kitty/kitty.conf
~/.config/devilspie2/dropdown.lua
```

---

## 🧪 11. Validate setup

* F12 opens dropdown terminal
* tmux starts automatically
* Ctrl+R → fuzzy search
* `z <dir>` works
* no startup warnings

---

# ⚡ PART 2 — Usage, Shortcuts & Capabilities

---

# 🧠 Core Concepts

### Terminal flow

```text
F12 → Kitty → tmux → zsh → tools
```

* Kitty = terminal window
* tmux = session manager
* zsh = smart shell

---

# ⌨️ Key Shortcuts

## tmux

| Action           | Shortcut         |   |
| ---------------- | ---------------- | - |
| New tab          | `Ctrl + a` → `c` |   |
| Next tab         | `Ctrl + a` → `n` |   |
| Split horizontal | `Ctrl + a` → `-` |   |
| Split vertical   | `Ctrl + a` → `   | ` |
| Reload config    | `Ctrl + a` → `r` |   |

---

## fzf (Fuzzy Search)

| Action         | Shortcut   |
| -------------- | ---------- |
| History search | `Ctrl + R` |
| File search    | `Ctrl + T` |
| Directory jump | `Alt + C`  |

---

# 🧠 Smart Navigation (zoxide)

```bash
z proj     # jump to project
z back     # jump to backend folder
```

Replaces traditional `cd`.

---

# 🐳 Docker Shortcuts

```bash
dps        # docker ps
dlog       # docker logs -f
dexec      # docker exec -it
```

---

# 🔁 Git Shortcuts

```bash
gs         # git status
ga         # git add .
gc         # git commit
gp         # git push
gl         # git log
```

---

# 🔍 Fuzzy Workflows

### History

```text
Ctrl + R → search → Enter
```

### Files

```bash
vim $(fzf)
```

### Git branches

```bash
git checkout $(git branch | fzf)
```

---

# ⚡ What this setup enables

* No more retyping commands
* Fast navigation across projects
* Persistent terminal sessions
* Instant feedback (prompt colors)
* Clean, modern UI

---

# 🧠 How to extend

## Add new aliases

Edit `~/.zshrc`:

```bash
alias mycmd="some-command"
```

---

## Add new tmux bindings

Edit `~/.tmux.conf`:

```conf
bind x kill-pane
```

---

## Add new tools

Place binaries in:

```text
~/dev/tools/
```

Add to PATH if needed.

---

# 🏁 Summary

This setup turns the terminal into:

* a workspace manager
* a search-driven interface
* a persistent development environment

---

# 🔮 Future improvements

* Project-specific tmux sessions
* Docker-compose workflows
* SSH + remote server workflows
* LLM/Ollama CLI integration

---

## Optional: automated install

```bash
./scripts/install.sh
