#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Ruby gems
bundle install

# Install JS packages with Bun
bun install

# Build CSS using the installed package directly
./node_modules/.bin/tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify

# Build JS (your bun.config.js)
bun bun.config.js

# Precompile assets
RAILS_ENV=production bundle exec rails assets:precompile

# Migrate database (only on Render where DATABASE_URL exists)
if [ -n "$DATABASE_URL" ]; then
  RAILS_ENV=production bundle exec rails db:migrate
fi
