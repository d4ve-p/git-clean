# git-clean

A fast, lightweight shell tool to strip Claude / Anthropic co-author trailers (`Co-Authored-By: Claude ...`) from Git commits before pushing to origin.

## Features

- **Pre-Push Focused**: Targets only unpushed local commits against upstream (`@{u}..HEAD` or `origin/<branch>..HEAD`) by default, preserving remote history.
- **Selective Cleaning**: Strips `Co-Authored-By` lines matching Claude / Anthropic while preserving human co-authors and the rest of the commit body.
- **Trailing Whitespace Cleanup**: Automatically trims unnecessary trailing blank lines left after removing trailers.
- **Fast & Zero-Impact**: Immediately exits if no matching commits are detected without rewriting Git history.
- **Interactive & Non-Interactive Modes**: Prompts for confirmation with affected commits preview, or run non-interactively with `-y`.
- **Dry-Run Preview**: Preview affected commits without modifying history (`-d`).
- **Cross-Platform**: Built in POSIX `sh` for Git Bash, Linux, and macOS, with a `.cmd` wrapper for Windows PowerShell / Command Prompt.
- **Pre-Push Hook Guard**: Optional pre-push hook (`--install-hook`) to prevent pushing uncleaned commits.

---

## Installation

### Option 1: Install to `~/.local/bin` (Recommended)

In PowerShell:
```powershell
.\install.ps1
```

In Git Bash / sh:
```sh
./install.sh
```

### Option 2: Run directly
You can also run it directly in your repository:
```sh
# Git Bash
./git-clean .

# PowerShell / CMD
.\git-clean.cmd .
```

---

## Usage

```sh
git-clean [OPTIONS] [PATH]
```

### Common Commands

Clean unpushed commits in the current directory before pushing:
```sh
git-clean .
```

Preview commits that would be cleaned without modifying history (dry-run):
```sh
git-clean -d .
```

Clean unpushed commits non-interactively (skip confirmation prompt):
```sh
git-clean -y .
```

Clean all commits across the entire branch history (from root commit):
```sh
git-clean --all .
```

Clean a specific commit range:
```sh
git-clean -r origin/main..HEAD .
```

Match only the exact string `Claude Opus 5.5 noreply@anthropic.com`:
```sh
git-clean --exact .
```

Install a pre-push guard hook into the current repository:
```sh
git-clean --install-hook .
```

---

## CLI Options

| Option | Short | Description |
|---|---|---|
| `[PATH]` | | Target git repository path (default: `.`) |
| `--dry-run` | `-d` | Preview matching commits without modifying git history |
| `--yes` | `-y` | Proceed with rewrite without interactive confirmation prompt |
| `--all` | `-a` | Clean all commits on current branch (default: only unpushed) |
| `--range <RANGE>` | `-r` | Specify custom git commit range (e.g. `HEAD~3..HEAD`) |
| `--exact` | | Match only exact `Claude Opus 5.5 noreply@anthropic.com` |
| `--install-hook` | | Install a Git `pre-push` safety hook in `.git/hooks/pre-push` |
| `--help` | `-h` | Display help and usage instructions |
| `--version` | `-v` | Display version information |

---

## How It Works

1. **Safety Check**: Ensures the working tree is clean before modifying history to prevent data loss.
2. **Scope Detection**: Resolves the unpushed commit range against `@\{u\}`, `origin/<branch>`, or the base branch on `origin`.
3. **Commit Inspection**: Scans commit messages in the target range for `Co-Authored-By` trailers referencing Claude or Anthropic.
4. **History Rewrite**: Uses Git plumbing with an `awk` stream filter to strip the trailer and normalize trailing newlines.
5. **Backup Cleanup**: Cleans up internal `refs/original/` references created during rewriting.
