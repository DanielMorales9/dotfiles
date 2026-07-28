#!/bin/zsh

# Print a random zsh tip at the start of each interactive session.

_zsh_tips=(
# --- keybindings ---
"Ctrl-X Ctrl-E — edit the current command line in \$EDITOR"
"Ctrl-R — incremental reverse search through history"
"Alt-. — insert the last argument of the previous command"
"Alt-d — delete the word after the cursor"
"Ctrl-W — delete the word before the cursor"
"Ctrl-U — delete everything before the cursor"
"Ctrl-K — delete everything after the cursor"
"Ctrl-Y — yank back the last killed text"
"Ctrl-A / Ctrl-E — jump to start / end of the line"
"Ctrl-Left / Ctrl-Right — jump by word"
"Ctrl-Backspace — delete the previous word"
"Shift-Tab — cycle completions in reverse"
"Tab Tab — list all completions, then use arrows to navigate"
"Ctrl-Z — suspend the current foreground job, then use bg to resume in background"
"Ctrl-_ — undo the last edit on the command line"
"Alt-q — push the current line aside and execute another command first"
"Alt-h — show the man page for the command before the cursor"

# --- history expansion ---
"!! — repeat the last command (sudo !! is a classic)"
"!cmd — repeat the last command starting with 'cmd'"
"!cmd:p — print the last command starting with 'cmd' without running it"
"!\$ — reuse the last argument of the previous command"
"!^ — reuse the first argument of the previous command"
"!* — reuse all arguments of the previous command"
"!N — repeat the Nth command from history (use history to find N)"
"!!:gs/old/new/ — repeat last command substituting old with new"

# --- job control ---
"\$! — the PID of the last backgrounded command"
"fg — bring the last background job back to the foreground"
"bg — resume a suspended job in the background"
"jobs -l — list background jobs with PIDs"
"Ctrl-Z then bg — suspend a job and resume it in the background"
"disown — remove a job from the job table (keeps it running after shell exit)"

# --- directory navigation ---
"~N — expand to the Nth directory in the dir stack (use dh to list)"
"dirs -v — show the directory stack with indices"
"pushd / popd — navigate the directory stack"
"dh — show the directory stack (alias)"
"d1 / d2 / d3 — go back 1 / 2 / 3 dirs in the stack"
".. — go up one directory (... for two, .4 for four)"
"cd - — go back to the previous directory"
"AUTO_CD is on — just type a directory name to cd into it"

# --- globbing ---
"*(.) — glob only regular files, *(/) only dirs, *(m-1) modified in last day"
"**/* — recursive glob (like find), e.g. **/*.py"
"^pattern — glob everything NOT matching pattern (extended_glob)"
"pattern~negpattern — glob matching pattern but not negpattern"
"*(Lk+100) — files larger than 100KB (L for size, k for kilobytes)"
"*(.m-1) — files modified in the last 1 day"
"*(.om[1,5]) — 5 most recently modified files"
"*.(py|sh) — glob files matching either extension"

# --- history settings ---
"HIST_VERIFY is on — !! and !cmd show the expansion before executing"
"SHARE_HISTORY is on — history syncs across concurrent terminal sessions"
"HISTSIZE is 50000 — 50k commands kept in memory"
"hs <pattern> — search history inline (alias)"

# --- completion ---
"zstyle -L ':completion:*' — list all completion styles"
"compdef k=kubectl — k alias uses kubectl completions"
"Completion is case-insensitive — type DC to match docker-compose"
"Completions are cached in ~/.zcompcache for speed"
"Completions are grouped by category with colored labels"

# --- suffix aliases ---
"alias -s txt=open — suffix alias: type file.txt to open it"
"Suffix aliases are on: file.md → bat, file.py → PyCharm, file.java → IntelliJ"
"file.zip → extract, file.pdf → Preview, file.html → browser"

# --- useful tools ---
"tldr <cmd> — community-maintained cheat sheets for commands"
"bat <file> — cat replacement with syntax highlighting"
"extract <archive> — extract most archive formats in one command"
"jump <mark> — jump to a frequently used directory (if jump is installed)"
"direnv allow — enable .envrc for project-local environment vars"
"k — kubectl alias"
"git_branch_cleanup --dry-run — list stale branches older than 3 weeks"
"pinit — init a project with git commit prefix + direnv setup"
"trash <file> — move a file to the macOS Trash instead of deleting"
"ql <file> — quicklook preview any file"

# --- zsh features ---
"autoload -Uz zmv — batch rename files: zmv '(*).old' '\$1.new'"
"whence -v cmd — show what a command resolves to (alias, function, binary)"
"typeset -f func — print the body of a shell function"
"print -P \$PROMPT — preview your prompt string with expansions"
"setopt CORRECT — zsh offers to fix misspelled commands"
"setopt AUTO_CD — type a bare directory name to cd into it"
"setopt EXTENDED_GLOB — enables ^pattern and pattern~negpattern globbing"
"INTERACTIVE_COMMENTS is on — use # for inline comments in the shell"
"r — repeat the last command (shorthand for !!)"
"echo \$? — check the exit code of the last command"
"foo=(a b c) — create an array; \${foo[1]} is first element (1-indexed)"
"\${(j:, :)array} — join array elements with ', '"
"\${name:-default} — use 'default' if name is unset or empty"
"2>&1 — redirect stderr to stdout"
"cmd1 && cmd2 — run cmd2 only if cmd1 succeeds"
"cmd1 || cmd2 — run cmd2 only if cmd1 fails"
"=(cmd) — process substitution: use command output as a temporary file"
"<(<cmd) — process substitution: pipe command output as input file"
"\$(cmd) — command substitution: use command output inline"
"autoload -Uz edit-command-line — edit the buffer in \$EDITOR (Ctrl-X Ctrl-E)"
"zmodload zsh/datetime — gives \$EPOCHREALTIME for sub-second timing"
"zstyle ':completion:*' menu select — arrow-key navigable completion menu"
)

if (( ${#_zsh_tips} > 0 )); then
	local _tip_index=$(( RANDOM % ${#_zsh_tips} + 1 ))
	print -P "%F{cyan}zsh tip:%f ${_zsh_tips[$_tip_index]}"
fi

unset _zsh_tips