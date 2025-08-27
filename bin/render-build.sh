#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Ruby gems
bundle install

# Install JS packages with Bun
bun install

# Build CSS using the installed package directly
./node_modules/.bin/tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify

# Build JS manually with bun
bun build ./app/javascript/application.js --outdir ./app/assets/builds --target browser --minify

# Create a fake build script to fool Rails
mkdir -p tmp
echo '#!/bin/bash' > tmp/fake-build
echo 'exit 0' >> tmp/fake-build
chmod +x tmp/fake-build

# Replace the build command temporarily
sed -i 's/"build": "bun bun.config.js"/"build": ".\/tmp\/fake-build"/' package.json

# Now run asset precompilation (Rails will call yarn/npm but with our dummy script)
RAILS_ENV=production bundle exec rails assets:precompile

# Migrate database (only on Render where DATABASE_URL exists)
if [ -n "$DATABASE_URL" ]; then
  RAILS_ENV=production bundle exec rails db:migrate
  RAILS_ENV=production bundle exec rails db:seed
fi
