FROM texlive/texlive:latest AS base

# Install basic build tools and git
RUN apt-get update && apt-get install -y \
    git sudo make \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=texlive
ARG USER_UID=1000
ARG USER_GID=$USER_UID

USER $USERNAME
