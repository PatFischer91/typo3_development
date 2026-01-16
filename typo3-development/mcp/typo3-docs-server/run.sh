#!/bin/bash
# Auto-install dependencies and run TYPO3 Docs MCP Server

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check and install missing Python packages
python3 -c "import mcp" 2>/dev/null || pip3 install --user mcp >/dev/null 2>&1
python3 -c "import httpx" 2>/dev/null || pip3 install --user httpx >/dev/null 2>&1

# Run the server
exec python3 "$SCRIPT_DIR/server.py"
