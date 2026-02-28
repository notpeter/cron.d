# unluac mirror automation

This folder contains automation for mirroring the upstream Mercurial repo:
- Source: `http://hg.code.sf.net/p/unluac/hgcode`
- Mirror target: `https://github.com/notpeter/unluac.git` (`main`)

## Script

Run the sync manually:

```bash
./unluac/sync-hg-git-mirror.sh
```

Optional environment overrides:
- `HG_SOURCE_URL`
- `GIT_MIRROR_URL`
- `GIT_BRANCH`
- `REPO_DIR`

## GitHub Actions secret

Set repository secret `UNLUAC_MIRROR_TOKEN` to a fine-grained GitHub token with `Contents: Read and write` for `notpeter/unluac`.
