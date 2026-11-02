# Organizing Local Files

A local-only Codex/AI skill and PowerShell toolkit for inventorying, planning, safely reorganizing, monitoring, verifying, and rolling back folders or drives.

## One-click install on Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Then invoke `$local-file-organizer` in Codex/ChatGPT-compatible skill environments.

Requirements: PowerShell 7+ for the organizer scripts. The installer itself can also run in Windows PowerShell 5.1. File execution is local; no network or AI service is used after installation.

The default workflow does not move files until a CSV mapping has been reviewed, validated, and explicitly approved. Existing targets are never overwritten, exact duplicates are isolated rather than deleted, and every applied plan can be rolled back while its state directory is retained.

See [`local-file-organizer/SKILL.md`](local-file-organizer/SKILL.md) for the agent workflow and commands.
