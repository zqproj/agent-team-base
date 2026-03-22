#!/bin/bash
set -e

# Copy Claude credentials from host mount into writable sandbox home.
# Each container gets its own isolated copy — no shared write conflicts.
if [ -f /mnt/claude-config/.claude.json ]; then
    cp /mnt/claude-config/.claude.json /home/sandbox/.claude.json
    chmod 644 /home/sandbox/.claude.json
fi

if [ -d /mnt/claude-config/.claude ]; then
    cp -r /mnt/claude-config/.claude /home/sandbox/.claude
    chmod -R 755 /home/sandbox/.claude
fi

# Launch Claude Code — trust prompt is bypassed because:
#   - /home/sandbox is pre-trusted in the copied ~/.claude.json
#   - --dangerously-skip-permissions skips per-tool confirmations
exec claude --dangerously-skip-permissions
