#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Ruby gems
bundle install

# Install JS packages with Bun
bun install

# Precompile Rails assets (this will call `npm/yarn run build`)
RAILS_ENV=production bundle exec rails assets:precompile

# Run migrations + seeds if database exists
if [ -n "$DATABASE_URL" ]; then
  RAILS_ENV=production bundle exec rails db:migrate
  RAILS_ENV=production bundle exec rails db:seed
fi
