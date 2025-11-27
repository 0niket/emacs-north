# Emacs Configuration for Full-Stack Development

A comprehensive Emacs configuration optimized for full-stack development with JavaScript, TypeScript, HTML, CSS, Ruby, Rails, SQL, Postgres, Apex, and LWC.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Packages Overview](#packages-overview)
- [Configuration Features](#configuration-features)
- [Keyboard Shortcuts](#keyboard-shortcuts)

## Prerequisites

Before using this configuration, ensure you have the following installed:

### System Requirements

- **Emacs 29+** (with tree-sitter support)
- **Git**
- **CMake** (**REQUIRED** for vterm terminal emulator)
  ```bash
  brew install cmake
  ```

  **Important:** CMake is essential for compiling vterm, which provides a fully-featured terminal emulator in Emacs. This is especially important for Claude Code integration, as it allows you to run the Claude CLI directly within Emacs while editing files side-by-side.

### Language Servers & Tools

#### Ruby Development
```bash
# rbenv for Ruby version management
brew install rbenv

# Initialize rbenv
rbenv init

# Install Ruby (adjust version as needed)
rbenv install 3.3.6
rbenv global 3.3.6

# Ruby tools
gem install solargraph      # Ruby language server
gem install rubocop         # Ruby linter
gem install bundler         # Dependency management
```

#### JavaScript/TypeScript Development
```bash
# Node.js and npm
brew install node

# Language servers
npm install -g typescript typescript-language-server
npm install -g vscode-langservers-extracted  # HTML, CSS, JSON
```

#### Other Tools
```bash
# Ripgrep for fast searching
brew install ripgrep

# SQL formatter for Postgres
brew install pgformatter

# Prettier for JS/TS formatting
npm install -g prettier
```

## Installation

1. Clone or copy this configuration to `~/.emacs.d/`:
   ```bash
   cd ~/.emacs.d
   ```

2. Start Emacs - it will automatically:
   - Install `use-package` if not present
   - Download and install all configured packages from MELPA
   - Set up tree-sitter grammars

3. On first run, you may need to:
   - Install tree-sitter grammars when prompted
   - Wait for packages to download and compile
   - Restart Emacs after initial setup

## Packages Overview

### Core Packages

#### UI & Theme
- **doom-themes** - Modern, beautiful color schemes (using doom-one theme)
- **doom-modeline** - Clean and informative modeline
- **all-the-icons** - Icon support (run `M-x all-the-icons-install-fonts` once)
- **rainbow-delimiters** - Color-coded parentheses for better readability
- **highlight-indent-guides** - Visual indent guides for Ruby blocks

#### Completion Framework
- **vertico** - Vertical completion UI for minibuffer
- **consult** - Consulting completing-read (enhanced search/navigation)
- **orderless** - Flexible matching style for completion
- **marginalia** - Rich annotations in minibuffer completions
- **corfu** - In-buffer completion overlay (auto-completion)

#### Help & Discovery
- **which-key** - Display available keybindings in popup (shows after 0.3s delay)
- **helpful** - Better help buffers with more context

### Project Management
- **projectile** - Project interaction and management
  - Auto-discovers git projects
  - Fast file finding within projects
  - Project-wide operations
- **projectile-rails** - Rails-specific project commands

### Version Control
- **magit** - Best-in-class Git interface
  - Full Git workflow from Emacs
  - Stage hunks, manage branches, rebase interactively
- **diff-hl** - Show git diff in fringe (gutter)

### Language Support

#### Tree-sitter
- **treesit-auto** - Automatic tree-sitter grammar management
  - Provides fast, accurate syntax highlighting
  - Better code navigation and folding

#### LSP (Language Server Protocol)
- **lsp-mode** - LSP client for Emacs
  - Provides IDE-like features: completion, diagnostics, refactoring
  - Configured with breadcrumb navigation in headerline
- **lsp-ui** - UI improvements for lsp-mode
  - Documentation popups
  - Sideline information
- **lsp-treemacs** - Treemacs integration for LSP

#### Ruby & Rails
- **ruby-ts-mode** (built-in) - Ruby major mode with tree-sitter
- **rbenv** - Ruby version management integration
  - Ensures Emacs uses correct Ruby version from rbenv
  - Adds rbenv shims to PATH
- **inf-ruby** - Interactive Ruby REPL
- **rspec-mode** - RSpec test runner integration
  - Configured to use bundler
  - Run specs from Emacs with keybindings
- **ruby-end** - Auto-insert 'end' keyword and show matching blocks
- **rubocop** - Ruby linting and style checking

#### JavaScript & TypeScript
- **typescript-ts-mode** (built-in) - TypeScript with tree-sitter
- **js-ts-mode** (built-in) - JavaScript with tree-sitter
- **prettier-js** - Code formatting with Prettier

#### HTML & CSS
- **web-mode** - Major mode for HTML/CSS
- **emmet-mode** - Fast HTML/CSS expansion (e.g., `div>p*3` → expand)

#### SQL
- **sql-mode** (built-in) - SQL editing
- **sqlformat** - SQL formatting with pgformatter

### Code Navigation
- **dumb-jump** - Go-to-definition fallback using ripgrep
  - Works when LSP is unavailable
  - Supports multiple languages

### Syntax Checking
- **flycheck** - On-the-fly syntax checking
  - Real-time error/warning highlighting
  - Works with multiple linters

### Snippets
- **yasnippet** - Template system for Emacs
- **yasnippet-snippets** - Collection of snippet templates

### Terminal
- **vterm** - Fully-featured terminal emulator (**ESSENTIAL for Claude Code**)
  - **Requires CMake** - Must run `brew install cmake` before use
  - Provides true terminal emulation with full color support
  - Perfect for running Claude CLI alongside your code editor
  - Supports complex terminal applications (vim, htop, etc.)
  - Configured with 10,000 lines of scrollback
  - **Recommended workflow:** `M-x vterm` → run `claude` → split window with code

## Configuration Features

### Basic Settings
- Clean UI (no scrollbar, toolbar, menubar)
- Line numbers enabled globally (except in terminal/shell modes)
- Monaco font at size 140 (14pt)
- Command key mapped to Meta (⌘ = M-)
- Option key mapped to Super (⌥ = s-)

### Editor Behavior
- 2-space indentation (no tabs)
- Auto-revert files when changed externally
- Remember cursor position across sessions
- Persistent minibuffer history
- Smart completion (case-insensitive)

### Backup & Auto-save
- Backups stored in `~/.emacs.d/backups`
- Auto-saves in `~/.emacs.d/auto-save-list`
- Version control for backups (keeps last 6 versions)

### Performance Tuning
- Increased garbage collection threshold (100MB)
- Increased process output max (1MB)
- LSP file watcher threshold set to 2000 files

### Emacs Server
- Server mode enabled for external editor integration
- Use `emacsclient` to open files in running Emacs instance

## Keyboard Shortcuts

### Basic Emacs
| Key | Action |
|-----|--------|
| `C-x C-f` | Find file |
| `C-x C-s` | Save file |
| `C-x C-c` | Quit Emacs |
| `C-x b` | Switch buffer (enhanced with consult) |
| `C-x k` | Kill buffer |
| `C-g` | Cancel/quit command |
| `C-/` or `C-_` | Undo |
| `C-x u` | Undo tree |
| `C-s` | Search forward |
| `C-r` | Search backward |

### Window Management
| Key | Action |
|-----|--------|
| `C-x 2` | Split window horizontally |
| `C-x 3` | Split window vertically |
| `C-x 0` | Close current window |
| `C-x 1` | Close other windows |
| `C-x o` | Switch to other window |
| `C-x <up>` | Move to window above |
| `C-x <down>` | Move to window below |
| `C-x <left>` | Move to window left |
| `C-x <right>` | Move to window right |

### Completion (Vertico/Consult)
| Key | Action |
|-----|--------|
| `C-x b` | Switch buffer with preview |
| `M-s d` | Find file in directory tree |
| `M-s g` | Grep in directory |
| `M-s G` | Git grep |
| `M-s r` | Ripgrep search |
| `M-s l` | Search current buffer lines |
| `M-g i` | Jump to symbol (imenu) |
| `M-g g` | Go to line |

### Projectile (Project Management)
| Key | Action |
|-----|--------|
| `C-c p f` | Find file in project |
| `C-c p p` | Switch project |
| `C-c p s g` | Grep in project |
| `C-c p P` | Run project tests |
| `C-c p r` | Replace in project |
| `C-c p k` | Kill all project buffers |
| `C-c p !` | Run shell command in project root |

### Magit (Git)
| Key | Action |
|-----|--------|
| `C-x g` | Open Magit status |
| **In Magit buffer:** | |
| `s` | Stage file/hunk |
| `u` | Unstage file/hunk |
| `c c` | Commit (write message, `C-c C-c` to finish) |
| `P p` | Push to remote |
| `F p` | Pull from remote |
| `b b` | Checkout branch |
| `b c` | Create branch |
| `l l` | Log current branch |
| `d d` | Diff |
| `q` | Quit Magit buffer |

### LSP Mode
| Key | Action |
|-----|--------|
| `M-.` | Go to definition |
| `M-,` | Go back |
| `C-c l g g` | LSP go to definition |
| `C-c l g r` | Find references |
| `C-c l g i` | Go to implementation |
| `C-c l r r` | Rename symbol |
| `C-c l a a` | Code actions |
| `C-c l =` | Format buffer |
| `C-c l F` | Format region |

### Dumb-jump (Code Navigation Fallback)
| Key | Action |
|-----|--------|
| `M-.` | Jump to definition (tries LSP first, then dumb-jump) |
| `M-,` | Jump back |
| `C-M-g` | Dumb-jump go (direct) |
| `C-M-p` | Dumb-jump back |
| `C-M-q` | Dumb-jump quick look (peek) |

### Ruby & RSpec
| Key | Action |
|-----|--------|
| `C-c , v` | Run RSpec example at point |
| `C-c , s` | Run current spec file |
| `C-c , a` | Run all specs |
| `C-c , r` | Re-run last spec |
| `C-c , t` | Toggle between implementation and spec |
| `C-c , e` | Toggle example pending |

### Code Editing
| Key | Action |
|-----|--------|
| `C-c ;` | Comment/uncomment region |
| `C-M-\` | Indent region |
| `M-;` | Comment dwim (do what I mean) |
| `C-M-f` | Forward expression |
| `C-M-b` | Backward expression |
| `C-M-u` | Up expression (to beginning of block) |
| `C-M-d` | Down into expression |
| `C-M-n` | Next expression at same level |
| `C-M-p` | Previous expression at same level |

### Flycheck (Syntax Checking)
| Key | Action |
|-----|--------|
| `C-c ! n` | Next error |
| `C-c ! p` | Previous error |
| `C-c ! l` | List errors |
| `C-c ! c` | Clear errors |

### Terminal
| Key | Action |
|-----|--------|
| `M-x vterm` | Open vterm terminal |
| `M-x eshell` | Open eshell |
| `M-x shell` | Open shell |

### Help System
| Key | Action |
|-----|--------|
| `C-h k` | Describe key |
| `C-h f` | Describe function (enhanced with helpful) |
| `C-h v` | Describe variable (enhanced with helpful) |
| `C-h m` | Describe current modes |
| `C-h a` | Apropos (search help) |

### Which-key
- Wait 0.3 seconds after typing a prefix key (like `C-x` or `C-c`) to see available completions

### Emmet (HTML/CSS)
| Key | Action |
|-----|--------|
| `C-j` | Expand emmet expression |
| Example: `div>p*3` then `C-j` |

## Claude Code Integration

This Emacs configuration is optimized for use with Claude Code CLI. Here's how to integrate them:

### Prerequisites for Claude Code
1. **CMake must be installed** (for vterm):
   ```bash
   brew install cmake
   ```

2. **Restart Emacs** after installing CMake to compile vterm

### Recommended Workflow

1. **Open Emacs** with your project
2. **Start vterm**: `M-x vterm` (or bind to a key)
3. **Run Claude**: Type `claude` in the vterm terminal
4. **Split windows** for side-by-side editing:
   - `C-x 3` - Split vertically (Claude | Code)
   - `C-x 2` - Split horizontally (Claude / Code)
5. **Navigate between windows**: `C-x o` or `C-x <arrow>`

### Emacs Server Integration

This configuration enables Emacs server mode, allowing external tools to open files in your running Emacs instance:

```bash
# Set Emacs as your editor
export EDITOR="emacsclient -t"

# Or for GUI Emacs
export EDITOR="emacsclient -c"
```

Add this to your shell configuration (`~/.zshrc` or `~/.bashrc`).

### Window Management Tips

When using Claude Code with Emacs:

- **`C-x 1`** - Maximize current window (hide Claude temporarily)
- **`C-x 0`** - Close current window
- **`C-x 3`** - Split vertically (recommended for Claude + code)
- **`C-x 2`** - Split horizontally
- **`C-x o`** - Switch between windows
- **`C-x <left/right/up/down>`** - Navigate to specific window

### vterm Tips

- **Copy mode**: `C-c C-t` to enter copy mode, navigate with normal Emacs keys
- **Paste**: `C-c C-y` or standard `C-y`
- **Clear**: `C-c C-l` to clear the terminal
- **Exit vterm**: `exit` or `C-d`

## Customization

### Changing Theme
Edit `init.el` line ~131:
```elisp
(load-theme 'doom-one t)  ; Change 'doom-one to another doom theme
```

Available themes: `doom-dracula`, `doom-nord`, `doom-gruvbox`, `doom-monokai-pro`, etc.

### Changing Font
Edit `init.el` line ~57:
```elisp
(set-face-attribute 'default nil :font "Monaco" :height 140)
```

### Adding Custom Keybindings
Add to the "CUSTOM KEYBINDINGS" section (around line 447):
```elisp
(global-set-key (kbd "C-c m") 'your-function)
```

## Troubleshooting

### vterm not working (CRITICAL for Claude Code)

**vterm is essential for running Claude Code CLI within Emacs.**

If you see errors like "Vterm needs CMake to be compiled":

1. **Install CMake**:
   ```bash
   brew install cmake
   ```

2. **Restart Emacs** (it will auto-compile vterm on next startup)

3. **Or manually compile**:
   ```
   M-x vterm-module-compile
   ```

4. **If still having issues**, reinstall vterm:
   ```
   M-x package-delete RET vterm RET
   M-x package-install RET vterm RET
   ```

5. **Verify installation**: `M-x vterm` should open a working terminal

### LSP not starting
Check if language server is installed:
- Ruby: `gem install solargraph`
- TypeScript: `npm install -g typescript-language-server`

### Icons not showing
Install icon fonts:
```
M-x all-the-icons-install-fonts
```

### Packages not installing
Refresh package contents:
```
M-x package-refresh-contents
```

## Resources

- [Emacs Manual](https://www.gnu.org/software/emacs/manual/)
- [Magit Manual](https://magit.vc/manual/)
- [Projectile Documentation](https://docs.projectile.mx/)
- [LSP Mode Documentation](https://emacs-lsp.github.io/lsp-mode/)
- [Doom Themes Gallery](https://github.com/doomemacs/themes)

## License

This configuration is free to use and modify as needed.
