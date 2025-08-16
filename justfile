# A collection of useful shortcuts for the OtakuSen project

# --- Development ---
# Starts the Rails server, JS bundler, and CSS watcher
dev:
    bin/dev

# Opens the Rails database console
db:
    bin/rails db:console

# Opens the interactive Rails console
c:
    bin/rails c

# --- Testing ---
# Run all tests and then open the coverage report
coverage: test
    @echo "Opening coverage report..."
    xdg-open coverage/index.html

# Run all tests (models, controllers, system, etc.)
test:
    bin/rails test

# Run only the fast model tests
test_models:
    bin/rails test test/models

# Run only the controller tests
test_controllers:
    bin/rails test test/controllers

# Run only the system tests (browser tests)
test_system:
    bin/rails test:system

# --- Code Quality & Stats ---
# Automatically fix code style issues with RuboCop
format:
    bin/rubocop -A

# Show a statistical breakdown of your code (Models, Controllers, etc.)
stats:
    bin/rails stats

# --- Cleanup ---
# Remove temporary files and clear caches
clean:
    bin/rails tmp:clear
    bin/rails assets:clobber
    rm -rf tmp/cache/*