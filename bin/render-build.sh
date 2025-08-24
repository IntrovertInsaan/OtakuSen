#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Bun
curl -fsSL https://bun.sh/install | bash
export PATH="$HOME/.bun/bin:$PATH"

# Install Ruby gems
bundle install

# Install JS packages with Bun
bun install

# Build assets
bun run build
rails assets:precompile

# Migrate database
rails db:migrate
