# git-clean

### What It Does
`git-clean` strips Claude and Anthropic `Co-Authored-By` lines and everything below them from your unpushed Git commits before pushing to remote.

### How to Setup
Run `.\install.ps1` in PowerShell (or `./install.sh` in Bash) to install the `git-clean` command directly to your PATH.

---

### How to Use
Run this in any git repository before pushing:
```sh
git-clean .
```

#### Quick Flags
- `git-clean -y .` &nbsp;&mdash;&nbsp; Clean immediately without confirmation prompt.
- `git-clean -d .` &nbsp;&mdash;&nbsp; Dry run preview without making changes.
- `git-clean --all .` &nbsp;&mdash;&nbsp; Clean all branch history instead of only unpushed commits.
