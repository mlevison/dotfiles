# Snapshot file
# Unset all aliases to avoid conflicts with functions
unalias -a 2>/dev/null || true
# Functions
# Shell Options
setopt nohashdirs
setopt login
# Aliases
alias -- dockflow=/Applications/DockFlow.app/Contents/MacOS/DockFlowCLI
alias -- run-help=man
alias -- which-command=whence
# Check for rg availability
if ! command -v rg >/dev/null 2>&1; then
  alias rg='/Users/marklevison/.local/share/claude/versions/2.0.49 --ripgrep'
fi
export PATH=/usr/bin\:/bin\:/usr/sbin\:/sbin
