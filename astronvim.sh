# Tree-sitter CLI
cargo install tree-sitter-cli

# Ripgrep
brew install ripgrep

# Lazygit
brew install lazygit

# Go Disk Usage (gdu)
brew install gdu

# Bottom (btm)
brew install bottom

# Make a backup of your current nvim config (if exists)
mv ~/.config/nvim ~/.config/nvim.bak

# Clean neovim folders (Optional but recommended)
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Clone the repository
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim
