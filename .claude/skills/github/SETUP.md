# GitHub Authentication Setup

This guide covers one-time setup for GitHub access in the blog devcontainer.

## GitHub App

The container uses a GitHub App for authentication. The app has its own identity, allowing the human owner to approve PRs created by the AI.

## Quick Start

Authenticate using the `gh-setup` command:

```bash
gh-setup
```

The script prompts for:
- **App ID** — from your app's settings page
- **Installation ID** — from the URL after installing the app
- **Private key** — the .pem file downloaded when creating the app

Credentials are stored in `.devcontainer/.gh-app/` (gitignored).

## App Permissions

The GitHub App should have these permissions:

| Permission | Access | Purpose |
|------------|--------|---------|
| Contents | Read/Write | Push/pull code, create branches |
| Issues | Read/Write | Create, comment, close issues |
| Pull requests | Read/Write | Create PRs, comment, review |
| Metadata | Read-only | Required base permission |

Permissions explicitly **omitted** for security:
- Administration (no repo settings changes)
- Actions/Workflows (no CI/CD modifications)

For the full security model, see [GITHUB.md](../../../.devcontainer/GITHUB.md#security-model).

## Credential Management

### Token Refresh

GitHub App tokens expire after 1 hour. To refresh:

```bash
.claude/skills/github/scripts/gh-app-token.sh | gh auth login --with-token
```

### Clear Credentials

```bash
# Inside container
gh auth logout

# Or from host, delete the volume
docker volume rm blog-gh-config
```

## Troubleshooting

### "Permission denied" on push
- Check `gh auth status` — token may need refresh
- Verify app has Contents write permission
- If pushing to main, you must use a PR (branch protection)

### "Repository not found"
- App may not be installed on this repository
- Check installation at https://github.com/settings/installations

### Authentication errors
Run `gh-setup` again to refresh credentials.
