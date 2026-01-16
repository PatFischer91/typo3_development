#!/bin/bash
# Run TYPO3 Docs MCP Server using uv for dependency management

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use uv to run with dependencies
exec uv run --with mcp --with httpx python "$SCRIPT_DIR/server.py"
