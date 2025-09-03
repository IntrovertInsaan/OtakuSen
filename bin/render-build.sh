#!/usr/bin/env bash
set -o errexit

# Install Ruby gems
bundle install

# Install JS packages with Bun
bun install

# Run production builds
bun run build

# Precompile Rails assets
RAILS_ENV=production bundle exec rails assets:precompile

# Run migrations + seeds (if DB available)
if [ -n "$DATABASE_URL" ]; then
  RAILS_ENV=production bundle exec rails db:migrate
  RAILS_ENV=production bundle exec rails db:seed
fi
