---
summary: >-
  Before any repository work, fetch every remote, check branch, upstream,
  and worktree state, and bring the branch up to date by fast-forward or
  safe rebase; repeat before every push; stop and ask when integration is
  unsafe. AGENTS.md section 0.1 before the split.
always_read: true
---

# Git synchronization

Before beginning any user-requested repository work, fetch every configured remote with `git fetch --all --prune`. Check the current branch, its configured upstream, and the worktree state. Preserve all existing staged, unstaged, and untracked user changes.

Bring the current branch up to date with its configured upstream before editing:

* If the branch is only behind, use `git merge --ff-only @{upstream}`.
* If the branch has diverged and its local commits have not been pushed, rebase those commits onto the upstream branch to keep history linear.
* Do not create a merge commit solely to synchronize the branch.
* If there is no configured upstream, local changes prevent safe integration, conflicts occur, or rebasing would rewrite shared commits, stop and ask the user how to proceed.

Immediately before every push, repeat the fetch and synchronization check. Push only when the local branch contains the latest upstream state. Prefer a fast-forward update or a safe rebase of unpushed commits so routine agent work does not introduce avoidable conflicts or nonlinear history.
