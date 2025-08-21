# A collection of useful shortcuts for the OtakuSen project

# --- Development ---
dev:
    bin/dev
db:
    bin/rails db:console
c:
    bin/rails c

# --- Testing ---
coverage: test
    @echo "Opening coverage report..."
    xdg-open coverage/index.html
test:
    bin/rails test
test_models:
    bin/rails test test/models
test_controllers:
    bin/rails test test/controllers
test_system:
    bin/rails test:system

# --- Code Quality & Stats ---
format:
    bin/rubocop -A
stats:
    bin/rails stats

# --- Cleanup ---
clean:
    bin/rails tmp:clear
    bin/rails assets:clobber
    rm -rf tmp/cache/*