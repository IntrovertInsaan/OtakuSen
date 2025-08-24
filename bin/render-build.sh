#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Ruby gems
bundle install

# Make sure Bun is in PATH after Render installs it
export PATH="/opt/render/project/src/.bun/bin:$PATH"

# Install JS packages with Bun
bun install

# Build CSS directly with bun (not bunx)
bun @tailwindcss/cli -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify

# Build JS (your bun.config.js)
bun bun.config.js

# Precompile assets
RAILS_ENV=production bundle exec rails assets:precompile

# Migrate database (only on Render where DATABASE_URL exists)
if [ -n "$DATABASE_URL" ]; then
  RAILS_ENV=production bundle exec rails db:migrate
fi
