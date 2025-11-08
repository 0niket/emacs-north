# Emacs Setup Instructions

## Configuration Complete!

Your Emacs configuration has been successfully created with support for:
- JavaScript, TypeScript, HTML, CSS
- Ruby and Ruby on Rails
- SQL and Postgres
- Salesforce Apex and LWC
- LSP support for all languages
- Git integration (Magit)
- Project management (Projectile)
- Modern completion framework (Vertico, Consult, Corfu)
- Beautiful themes and UI

## Next Steps

### 1. Install Icon Fonts (Required for proper UI display)

When you first launch Emacs, you need to install the icon fonts:

1. Open Emacs: `emacs` (or click the Emacs app)
2. Press `M-x` (Alt+x or Option+x on Mac)
3. Type: `all-the-icons-install-fonts`
4. Press Enter and follow the prompts

### 2. First Launch - Package Installation

The first time you launch Emacs, it will automatically:
- Download and install all required packages from MELPA
- This may take 2-5 minutes
- You'll see messages in the minibuffer about package installations

**Be patient during first launch!**

### 3. Install Tree-sitter Grammars

Tree-sitter grammars are needed for syntax highlighting:

1. Open Emacs
2. Press `M-x`
3. Type: `treesit-install-language-grammar`
4. Install grammars for: `typescript`, `tsx`, `javascript`, `html`, `css`, `ruby`, `sql`

Or they will be installed automatically when you open files of those types (treesit-auto will prompt you).

## Installed Language Servers

The following language servers have been installed:

- **TypeScript/JavaScript**: typescript-language-server
- **HTML/CSS/JSON**: vscode-langservers-extracted
- **Ruby**: solargraph
- **SQL**: pgformatter (for formatting)

## Useful Keybindings

### General
- `C-x g` - Open Magit (Git interface)
- `C-c p` - Projectile commands
- `C-x b` - Switch buffers (Consult)
- `M-x` - Execute command

### LSP
- `C-c l` - LSP command prefix
- `C-c l r` - Rename symbol
- `C-c l f` - Format buffer
- `C-c l a` - Code actions

### Navigation
- `C-x <arrow>` - Move between windows
- `M-g g` - Go to line
- `M-s r` - Search with ripgrep (Consult)

### Code
- `C-c ;` - Comment/uncomment region
- `TAB` - Trigger completion

## Configuration File Location

Your configuration is located at: `~/.emacs.d/init.el`

## Troubleshooting

### If packages fail to install:
1. Open Emacs
2. Run: `M-x package-refresh-contents`
3. Run: `M-x package-install-selected-packages`

### If LSP doesn't work:
1. Make sure the language server is installed (check above)
2. Restart Emacs
3. Run: `M-x lsp-install-server` and select your language

### If Tree-sitter highlighting doesn't work:
1. Run: `M-x treesit-install-language-grammar`
2. Select the language you need

## Salesforce Development (Apex/LWC)

For Salesforce development, you'll need to:
1. Install Salesforce CLI: `npm install -g @salesforce/cli`
2. Install Salesforce LSP (if available via npm or configure manually)

## Updating Configuration

To modify your configuration:
1. Edit: `~/.emacs.d/init.el`
2. Reload: `M-x eval-buffer` or restart Emacs

## Learning Resources

- Emacs tutorial: `C-h t`
- Describe key: `C-h k` then press a key
- Describe function: `C-h f`
- Which-key will show available keybindings after you press a prefix key

Enjoy your new Emacs setup!
