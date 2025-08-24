#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Ruby gems
bundle install

# Install JS packages with Bun (it's already installed by Render)
bun install

# Build CSS with your exact command
bun run build:css

# Build JS (your bun.config.js)
bun run build

# Tell Rails to use bun instead of yarn
export PATH="/opt/render/project/src/node_modules/.bin:$PATH"

# Precompile assets
RAILS_ENV=production bundle exec rails assets:precompile

# Migrate database (only on Render where DATABASE_URL exists)
if [ -n "$DATABASE_URL" ]; then
  RAILS_ENV=production bundle exec rails db:migrate
fi
