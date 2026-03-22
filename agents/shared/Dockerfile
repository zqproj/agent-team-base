FROM node:20-slim

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @anthropic-ai/claude-code

# Create sandbox user — matches host sandbox user UID for bind mount compatibility
ARG SANDBOX_UID=1001
ARG SANDBOX_GID=1001
RUN groupadd -g $SANDBOX_GID sandbox && \
    useradd -u $SANDBOX_UID -g $SANDBOX_GID -m sandbox

RUN git config --global credential.helper store && \
    git config --global init.defaultBranch main

WORKDIR /home/sandbox

# Each agent dir must contain CLAUDE.md and entrypoint.sh at build time
# setup.sh copies these from agent-team-base before running docker compose build
COPY CLAUDE.md /home/sandbox/CLAUDE.md
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R sandbox:sandbox /home/sandbox

USER sandbox

ENTRYPOINT ["/entrypoint.sh"]
