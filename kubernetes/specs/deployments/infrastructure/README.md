# Forgejo

ci instructions:

- <https://forgejo.org/2023-02-27-forgejo-actions/>
- <https://code.forgejo.org/forgejo/runner>

## Runner

Enable `actions` in repo, then under site administration, `create new runner` then run following:

```bash
export FORGEJO_HOST=
export TOKEN=

wget -O forgejo-runner https://code.forgejo.org/forgejo/runner/releases/download/v3.0.0/forgejo-runner-3.0.0-linux-amd64
chmod +x forgejo-runner
./forgejo-runner register
./forgejo-runner daemon
```

## Add theme

Add css files to `gitea/public/assets/css`:

<https://codeberg.org/Codeberg-Infrastructure/forgejo/src/branch/codeberg-15/web_src/css/themes>

```bash
.
├── codeberg
│   ├── base-brand.css
│   └── dark-variables.css
├── theme-codeberg-auto.css
├── theme-codeberg-dark.css
└── theme-codeberg-light.css
```

Then add config to `gitea/conf/app.ini`:

```text
[ui]
THEMES = forgejo-auto,forgejo-light,forgejo-dark,codeberg-auto,codeberg-light,codeberg-dark
DEFAULT_THEME = codeberg-auto
```
