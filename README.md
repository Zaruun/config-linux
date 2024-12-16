# config-linux
---

## First step

```bash
curl -fsSL https://raw.githubusercontent.com/Zaruun/config-linux/refs/heads/main/configure.sh | bash
```

## Seckond step

### WSL (Ubuntu)

```bash
# Remove default .zshrc
rm ~/.zshrc
# GNU Stow 
cd ~/dotfiles && stow nvim zshrc
```

After restarting terminal install .asdf languages (NodeJS, Go lang, Pwsh)

```bash
curl -fsSL https://raw.githubusercontent.com/Zaruun/config-wsl-ubuntu/refs/heads/main/programming-languages.sh | bash
```