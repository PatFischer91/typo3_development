# Installation Guide

## Quick Installation (2 Steps)

### Step 1: Clone the Repository

```bash
# Clone from GitHub
git clone https://github.com/PatFischer91/claude-typo3-dev.git

# Navigate into the directory
cd claude-typo3-dev
```

### Step 2: Install the Plugin

**Option A: Global Installation (Recommended)**
```bash
# Install from local directory
claude plugin install ./typo3-dev
```

The plugin will be installed to `~/.claude/plugins/typo3-dev/` and available in all your projects.

**Option B: Project-Specific Installation**
```bash
# From your project directory
claude plugin install /path/to/claude-typo3-dev/typo3-dev --scope project
```

The plugin will only be available in the current project.

## Requirements

### For MCP Servers (Optional)

The plugin includes MCP servers for enhanced functionality:

```bash
# TYPO3 Documentation Server
pip install mcp httpx

# Chrome DevTools (for browser testing)
npm install -g @anthropic-ai/mcp-devtools-server
```

### Chrome DevTools Setup

To use browser testing features, start Chrome with remote debugging:

```bash
# macOS
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/chrome-debug

# Linux
google-chrome \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/chrome-debug

# Windows
"C:\Program Files\Google\Chrome\Application\chrome.exe" ^
  --remote-debugging-port=9222 ^
  --user-data-dir=C:\temp\chrome-debug
```

## Verification

After installation, verify the plugin is active:

```bash
# List installed plugins
/plugin installed

# Test a command
/typo3:init
```

## Uninstallation

```bash
# Via CLI
claude plugin uninstall typo3-dev

# Or via plugin manager in Claude Code
/plugin uninstall typo3-dev
```

## Updating

```bash
# Navigate to the cloned repository
cd claude-typo3-dev
git pull origin main

# Reinstall the plugin
claude plugin uninstall typo3-dev
claude plugin install ./typo3-dev
```

## Troubleshooting

### "Plugin not found" error

**Problem:** You're trying to install without cloning first.

**Solution:**
```bash
# Step 1: Clone the repository
git clone https://github.com/PatFischer91/claude-typo3-dev.git
cd claude-typo3-dev

# Step 2: Install from the local directory
claude plugin install ./typo3-dev
```

### "Marketplace not found" error

**Problem:** You're trying to install from a marketplace that doesn't exist.

**Solution:** Don't use marketplace syntax. Install directly from the local directory:
```bash
# Wrong (needs marketplace):
claude plugin install typo3-dev

# Correct (local install):
claude plugin install ./typo3-dev
```

### MCP Server errors

Check Python dependencies:
```bash
pip install --upgrade mcp httpx
```

### Commands not working

Verify plugin is installed:
```bash
/plugin installed
```

## Project vs Global Installation

| Scope | Location | Use Case |
|-------|----------|----------|
| Global | `~/.claude/plugins/` | Available in all projects |
| Project | `.claude/plugins/` | Only for specific project |

For TYPO3 development, **global installation** is recommended since you'll use it across multiple projects.
