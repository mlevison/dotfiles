# 1️⃣ HOMEBREW & PATH MANAGEMENT (Fastest, no eval needed)
# fish_user_paths automatically merges into $PATH and deduplicates entries
set -gx fish_user_paths \
    "/opt/homebrew/bin" \
    "/Users/marklevison/.cache/lm-studio/bin" \
    "/usr/local/opt/ruby/bin" \
    "/opt/homebrew/opt/ruby/bin" \
    "/opt/homebrew/lib/ruby/gems/3.4.0/bin/" \
    "/Users/marklevison/Library/pnpm"

# Manually set Homebrew environment variables (replaces the eval shellenv error)
set -x HOMEBREW_PREFIX "/opt/homebrew"
set -x HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set -x HOMEBREW_REPOSITORY "/opt/homebrew"

# 2️⃣ GOOGLE CLOUD SDK (Fish-native path handling)
fish_add_path '/Users/marklevison/google-cloud-sdk/bin'
if [ -f '/Users/marklevison/google-cloud-sdk/path.fish.inc' ]
    source '/Users/marklevison/google-cloud-sdk/path.fish.inc'
end
# Note: Your original .zsh.inc works in Fish, but fish_add_path is cleaner.

# 3️⃣ DENO
fish_add_path "$HOME/.deno/bin"

# 4️⃣ LOCAL BIN (Standard user path)
fish_add_path "$HOME/.local/bin"
