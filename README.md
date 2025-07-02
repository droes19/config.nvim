# Neovim Configuration

A modern, well-structured Neovim configuration built with Lua, featuring lazy loading, LSP support, and comprehensive development tools.

## ✨ Features

### Core Features
- **Modern Lua Configuration**: Built entirely in Lua for better performance and maintainability
- **Lazy Loading**: Optimized startup time with lazy.nvim plugin manager
- **LSP Integration**: Full Language Server Protocol support with auto-completion
- **Treesitter**: Advanced syntax highlighting and code understanding
- **Git Integration**: Comprehensive git workflow tools
- **File Management**: Oil.nvim for intuitive file operations

### Language Support
- **Java**: Full JDTLS integration with debugging and testing
- **TypeScript/JavaScript**: VTSLS with inlay hints and formatting
- **Lua**: Enhanced Lua development with vim API support
- **HTML/CSS**: Web development tools with auto-completion
- **And more**: Bash, Python, JSON, YAML, Markdown support

### Development Tools
- **Code Formatting**: Conform.nvim with Prettier and Stylua
- **Testing**: Neotest integration for running tests
- **Debugging**: Built-in debugging support for Java
- **Refactoring**: Advanced refactoring tools
- **Documentation**: Auto-generation with Neogen

## 📁 Project Structure

```
lua/droes/
├── init.lua                    # Main entry point
├── set.lua                     # Core Vim settings
├── keymaps.lua                 # Comprehensive keymap management
├── lazy_init.lua               # Lazy.nvim setup and configuration
├── lang/                       # Language-specific configurations
│   ├── java/
│   │   └── jdtls.lua          # Java Language Server setup
│   ├── lua/
│   │   └── lua_ls.lua         # Lua Language Server setup
│   └── typescript/
│       └── vtsls.lua          # TypeScript/JavaScript LSP setup
├── lazy/                       # Plugin configurations (lazy loading)
│   ├── core/                  # Essential plugins
│   │   ├── lsp.lua           # LSP and completion setup
│   │   ├── telescope.lua     # Fuzzy finder
│   │   └── treesitter.lua    # Syntax highlighting
│   ├── editing/              # Text editing enhancements
│   │   ├── autopairs.lua     # Auto-pairing brackets
│   │   ├── comment.lua       # Smart commenting
│   │   ├── copilot.lua       # GitHub Copilot integration
│   │   └── surround.lua      # Text objects manipulation
│   ├── git/                  # Git workflow tools
│   │   ├── gitsigns.lua      # Git signs and hunks
│   │   ├── neogit.lua        # Git interface
│   │   └── diffview.lua      # Git diff viewer
│   ├── tools/                # Development utilities
│   │   ├── oil.lua           # File manager
│   │   ├── terminal.lua      # Terminal integration
│   │   └── persistence.lua   # Session management
│   ├── ui/                   # User interface enhancements
│   │   ├── catpuccin.lua     # Color scheme
│   │   ├── noice.lua         # Enhanced UI messages
│   │   └── statusline.lua    # Status line configuration
│   └── misc/                 # Miscellaneous plugins
│       ├── harpoon.lua       # Quick file navigation
│       ├── trouble.lua       # Diagnostics viewer
│       └── which-key.lua     # Keymap hints
└── utils/                     # Utility modules
    ├── file.lua              # File operations
    ├── list.lua              # List data structure
    ├── mason.lua             # Mason package manager utilities
    └── path.lua              # Path manipulation
```

## 🚀 Installation

### Prerequisites

- **Neovim 0.10+**: Required for latest features
- **Git**: For plugin management
- **Node.js**: For some LSP servers and formatters
- **Ripgrep**: For telescope live grep functionality
- **A Nerd Font**: For icons (recommended: JetBrains Mono Nerd Font)

### Languages and Tools

#### Java Development
- **Java 8+ and Java 21**: Configure paths in `lua/droes/lang/java/jdtls.lua`
- **Maven/Gradle**: For project management

#### Web Development
- **Node.js and npm**: For TypeScript/JavaScript tooling
- **Prettier**: Auto-installed via Mason

#### General Development
- **Mason**: Auto-installs LSP servers, formatters, and linters
- **Stylua**: For Lua formatting (auto-installed)

### Setup Instructions

1. **Backup existing configuration**:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Clone this configuration**:
   ```bash
   git clone <your-repo-url> ~/.config/nvim
   ```

3. **Start Neovim**:
   ```bash
   nvim
   ```

4. **Let plugins install**: Lazy.nvim will automatically install all plugins

5. **Install LSP servers**: Use `:Mason` to install additional language servers

## ⌨️ Key Mappings

### Leader Keys
- **Leader**: `,` (comma)
- **Local Leader**: `\` (backslash)

### Core Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<space><space>` | Normal | Reload configuration |
| `<Esc>` | Normal | Clear search highlights |
| `<space>b` / `-` | Normal | Open file browser (Oil) |

### File Operations
| Key | Mode | Action |
|-----|------|--------|
| `<space>ff` | Normal | Find files |
| `<space>fl` | Normal | Live grep |
| `<space>fh` | Normal | Help tags |
| `<space>fgf` | Normal | Git files |

### Git Operations
| Key | Mode | Action |
|-----|------|--------|
| `<leader>g` | Normal | Open Neogit |
| `<leader>hs` | Normal | Stage hunk |
| `<leader>hr` | Normal | Reset hunk |
| `<leader>hp` | Normal | Preview hunk |
| `]c` / `[c` | Normal | Navigate git hunks |

### LSP Operations
| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gr` | Normal | Go to references |
| `gi` | Normal | Go to implementation |
| `K` | Normal | Hover documentation |
| `<leader>rn` | Normal | Rename symbol |
| `ga` | Normal | Code actions |

### Harpoon Navigation
| Key | Mode | Action |
|-----|------|--------|
| `<space>a` | Normal | Add file to harpoon |
| `<space>e` | Normal | Toggle harpoon menu |
| `<space>1-5` | Normal | Go to harpoon file 1-5 |

### Window Management
| Key | Mode | Action |
|-----|------|--------|
| `<M-h/j/k/l>` | Normal | Navigate windows |
| `<C-d>` / `<C-u>` | Normal | Half page scroll (centered) |

## 🛠️ Configuration

### Language Server Configuration

#### Java (JDTLS)
Edit `lua/droes/lang/java/jdtls.lua` to configure Java runtimes:

```lua
runtimes = {
  { name = "JavaSE-1.8", path = "/path/to/java8" },
  { name = "JavaSE-21", path = "/path/to/java21" },
}
```

#### TypeScript/JavaScript (VTSLS)
Configuration in `lua/droes/lang/typescript/vtsls.lua` includes:
- Inlay hints for parameters and types
- Enhanced IntelliSense features

### Adding New Languages

1. Create a new file in `lua/droes/lang/<language>/`
2. Add LSP configuration following the existing pattern
3. Register the server in `lua/droes/lazy/core/lsp.lua`

### Custom Keymaps

Keymaps are centralized in `lua/droes/keymaps.lua`. The file is organized into:
- **Core keymaps**: Always active
- **Plugin keymaps**: Lazy-loaded with plugins
- **Buffer-specific**: Set up when LSP attaches

### Theme Customization

The configuration uses Catppuccin theme by default. To change:

1. Edit `lua/droes/lazy/ui/catpuccin.lua`
2. Or uncomment TokyoNight in `lua/droes/lazy/ui/tokyonight.lua`

## 🔧 Customization

### Adding Plugins

1. Create a new file in the appropriate `lua/droes/lazy/` subdirectory
2. Follow the lazy.nvim plugin spec format
3. Add keymaps to `lua/droes/keymaps.lua` if needed

### Performance Tuning

The configuration includes several performance optimizations:
- Disabled unused built-in plugins
- Lazy loading for most plugins
- Efficient keymap management
- Optimized LSP settings

### Troubleshooting

#### Slow Startup
- Use `:Lazy profile` to identify slow plugins
- Check `:StartupTime` for detailed timing

#### LSP Issues
- Run `:LspInfo` to check server status
- Use `:Mason` to reinstall problematic servers
- Check `:checkhealth` for system issues

#### Plugin Issues
- Use `:Lazy health` to check plugin health
- Try `:Lazy clean` and `:Lazy sync` to refresh plugins

## 📚 Learning Resources

### Neovim
- [Neovim Documentation](https://neovim.io/doc/)
- [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/)

### Lua
- [Programming in Lua](https://www.lua.org/pil/)
- [Neovim Lua Guide](https://github.com/nanotee/nvim-lua-guide)

### Plugin Ecosystem
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

## 🤝 Contributing

Feel free to submit issues and pull requests. When contributing:

1. Follow the existing code style (Stylua formatting)
2. Test your changes thoroughly
3. Update documentation as needed
4. Keep commits focused and descriptive

## 📄 License

This configuration is provided as-is for educational and personal use. Feel free to adapt and modify for your needs.

---

**Happy coding with Neovim! 🎉**
