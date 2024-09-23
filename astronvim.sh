# Tree-sitter CLI
if ! command -v tree-sitter &> /dev/null; then
    cargo install tree-sitter-cli
else
    echo "tree-sitter-cli is already installed"
fi

# Ripgrep
if ! command -v rg &> /dev/null; then
    brew install ripgrep
else
    echo "ripgrep is already installed"
fi

# Lazygit
if ! command -v lazygit &> /dev/null; then
    brew install lazygit
else
    echo "lazygit is already installed"
fi

# Go Disk Usage (gdu)
if ! command -v gdu &> /dev/null; then
    brew install gdu
else
    echo "gdu is already installed"
fi

# Bottom (btm)
if ! command -v btm &> /dev/null; then
    brew install bottom
else
    echo "bottom is already installed"
fi
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
