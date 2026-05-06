# Dev Terminal Setup (Kitty + tmux + zsh + fzf + zoxide)

A modern Guake-style dropdown terminal built on GPU-accelerated Kitty, persistent tmux sessions, and a smart zsh shell. Started as a Guake replacement on Linux Mint — ended up significantly more capable.

**Terminal flow:**
```
F12 → Kitty (GPU) → tmux (sessions) → zsh (smart shell)
```

---

## Why not just keep Guake?

| Feature            | Guake | This setup         |
| ------------------ | ----- | ------------------ |
| Dropdown (F12)     | ✅    | ✅ via tdrop        |
| Tabs               | ✅    | ✅ via tmux         |
| GPU rendering      | ✗     | ✅                  |
| Persistent sessions| ✗     | ✅ tmux-continuum   |
| SSH resilience     | ✗     | ✅                  |
| Large log handling | OK    | Fast               |
| Setup effort       | Low   | Medium             |

The session persistence is the killer feature — close the terminal, reopen it, everything is exactly where you left it.

---

# PART 1 — Installation & Setup

## Quick install (recommended)

```bash
git clone https://github.com/mcataltepe/dev-terminal-setup.git
cd dev-terminal-setup
./scripts/install.sh
```

The script handles everything below automatically. Follow the post-install steps it prints at the end.

---

## Manual steps (reference)

### 1. Install core packages

```bash
sudo apt update
sudo apt install kitty tmux zsh git curl zoxide devilspie2 \
  unzip wget xclip gawk xdotool wmctrl
```

> `gawk`, `xdotool`, and `wmctrl` are required by tdrop for window geometry calculations.
> Linux Mint ships `mawk` (lighter) by default — tdrop specifically needs GNU awk (`gawk`).

---

### 2. Set zsh as default shell

```bash
chsh -s $(which zsh)
```

Log out and log back in (or run `zsh` once).

---

### 3. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

---

### 4. Install Powerlevel10k

```bash
git clone https://github.com/romkatv/powerlevel10k.git \
  ~/.oh-my-zsh/custom/themes/powerlevel10k
```

---

### 5. Install zsh plugins

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

---

### 6. Install fzf

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

Enable all options (keybindings + completion).

---

### 7. Install tdrop (dropdown wrapper)

> `tdrop` is **not** in Ubuntu/Linux Mint default repos — `sudo apt install tdrop` will fail. Install manually:

```bash
mkdir -p ~/tools
git clone https://github.com/noctuid/tdrop.git ~/tools/tdrop
chmod +x ~/tools/tdrop/tdrop
```

Bind this command to F12 in your desktop settings (System Settings → Keyboard → Shortcuts → Custom):

```bash
/home/<user>/tools/tdrop/tdrop -n dropdown -x 0 -y 0 -w 100% -h 40% -- kitty --class dropdown
```

---

### 8. Always-on-top behavior (devilspie2)

The `devilspie2/dropdown.lua` rule is already in this repo and symlinked by the install script. To start devilspie2 automatically, add it to Startup Applications:

```bash
devilspie2 &
```

---

### 9. Install Nerd Font

The install script downloads and installs JetBrainsMono Nerd Font automatically. To install manually:

```bash
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip && rm JetBrainsMono.zip
fc-cache -fv
```

---

### 10. Symlink configuration files

```bash
ln -sf <repo>/zsh/.zshrc           ~/.zshrc
ln -sf <repo>/zsh/.p10k.zsh        ~/.p10k.zsh
ln -sf <repo>/tmux/.tmux.conf      ~/.tmux.conf
ln -sf <repo>/kitty/kitty.conf     ~/.config/kitty/kitty.conf
ln -sf <repo>/devilspie2/dropdown.lua ~/.config/devilspie2/dropdown.lua
```

---

### 11. Install tmux plugins (TPM)

tmux uses [TPM](https://github.com/tmux-plugins/tpm) with two plugins:

* `tmux-resurrect` — manually save (`Ctrl+a S`) and restore (`Ctrl+a R`) sessions
* `tmux-continuum` — auto-saves every 15 minutes, auto-restores on tmux start

The install script installs TPM automatically. After symlinking `.tmux.conf`, open a tmux session and install plugins:

```
Ctrl+a then Shift+I
```

---

### 12. Validate setup

* F12 opens and hides the dropdown terminal
* tmux starts automatically inside Kitty
* `Ctrl+R` opens fuzzy history search
* `z <dir>` navigates to a directory
* No startup warnings or errors

---

# PART 2 — Usage, Shortcuts & Capabilities

---

## tmux Shortcuts

| Action           | Shortcut            |
| ---------------- | ------------------- |
| New window       | `Ctrl+a` → `c`      |
| Next window      | `Ctrl+a` → `n`      |
| Previous window  | `Ctrl+a` → `p`      |
| Split horizontal | `Ctrl+a` → `-`      |
| Split vertical   | `Ctrl+a` → `\|`     |
| Reload config    | `Ctrl+a` → `r`      |
| Save session     | `Ctrl+a` → `S`      |
| Restore session  | `Ctrl+a` → `R`      |

---

## fzf (Fuzzy Search)

| Action         | Shortcut   |
| -------------- | ---------- |
| History search | `Ctrl+R`   |
| File search    | `Ctrl+T`   |
| Directory jump | `Alt+C`    |

---

## Smart Navigation (zoxide)

```bash
z proj     # jump to ~/dev/projects/...
z back     # jump to backend folder
```

`cd` and `j` are both aliased to `z`. zoxide learns from your navigation patterns over time.

---

## Docker Shortcuts

```bash
dps        # docker ps
dlog       # docker logs -f <container>
dexec      # docker exec -it <container> bash
dstop      # stop all running containers
```

---

## Git Shortcuts

```bash
gs         # git status
ga         # git add .
gc         # git commit
gp         # git push
gl         # git log --oneline --graph --decorate
```

---

## Fuzzy Workflows

### History search

```
Ctrl+R → type → Enter
```

### Open file in editor

```bash
vim $(fzf)
```

### Switch git branch

```bash
git checkout $(git branch | fzf)
```

---

## What this setup enables

* No more retyping commands (history + fzf)
* Fast navigation across projects (zoxide)
* Sessions survive reboots and SSH drops (tmux-continuum)
* GPU-smooth large log output — Docker logs, Java stacktraces
* Instant feedback prompt with git status (powerlevel10k)
* Clean, modern terminal UI

---

## How to extend

### Add aliases

Edit `zsh/.zshrc`:

```bash
alias mycmd="some-command"
```

### Add tmux keybindings

Edit `tmux/.tmux.conf`:

```conf
bind x kill-pane
```

### Add new tools

Place binaries in `~/tools/` and add to PATH in `.zshrc` if needed.

---

## Optional: Java development (SDKMAN)

If you use Java/Kotlin, SDKMAN is already wired into `.zshrc`. Install it once:

```bash
curl -s "https://get.sdkman.io" | bash
```

Then manage JDK versions:

```bash
sdk install java 21-tem
sdk use java 21-tem
sdk current java
```

---

# Future improvements

* Project-specific tmux sessions (auto-layout per project)
* Docker-compose workflow shortcuts
* SSH + remote server session management
* LLM/Ollama CLI integration
* Per-profile kitty themes (dev / ssh / logs)
