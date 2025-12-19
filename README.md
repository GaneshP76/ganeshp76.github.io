# portfolio

## Deployment (GitHub Pages)

This repository contains a static portfolio site (`scifi_portfolio.html`). You can deploy it to GitHub Pages using the included GitHub Actions workflow.

How it works
- A GitHub Actions workflow is added at `.github/workflows/deploy.yml`.
- On every push to `main`, the workflow will run and publish the repository root to the `gh-pages` branch.
- GitHub Pages can then serve the site from the `gh-pages` branch. The site URL will be:

	`https://<your-github-username>.github.io/<repository-name>/`

Steps to deploy from your machine
1. Commit and push your changes to the `main` branch:

```pwsh
git add -A
git commit -m "Prepare site for deployment"
git push origin main
```

2. Wait for the GitHub Actions workflow to run (check the Actions tab in the repo). The workflow will create or update the `gh-pages` branch.

3. Open the Pages URL above (replace placeholders) or go to the repository Settings → Pages to see the published site. If Pages isn't immediately enabled, you can enable it in Settings -> Pages and choose the `gh-pages` branch as the source.

Notes
- If you want to publish from a subfolder or build step in the future, update `folder` in the workflow to point to the build output directory (for example `build/` or `dist/`).
- If you use a custom domain, add a `CNAME` file to the repository root or configure it in GitHub Pages settings.
