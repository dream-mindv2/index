# The Dream package index

Names for [Dream](https://github.com/dream-mindv2) packages: which release of
which name is at which source, and what its files hash to. `mind` reads it
by default.

```
mind search json
mind add json            # the newest release, held to its author's key
mind add json@^1.2
```

## Publishing

Sign the release in the package, push the tag, and publish:

```
mind sign v1.4 && git add mind.sig && git commit -m "Sign v1.4" && git tag v1.4
git push && git push --tags
mind publish --source https://github.com/you/json
```

`mind publish` opens an issue here holding the signed entry -- with `gh`
when it is installed, otherwise it prints a link to open. The
[Append](.github/workflows/append.yml) workflow checks it and appends it to
[`index.log`](index.log). A name new to the index is listed once a keeper
admits it to your key; later releases need nothing from anyone.

## Why it can be trusted

Nothing here has to be: `mind` checks all of it, every time it reads the log.

- Every entry is signed by whoever may say it: a release by the name's
  owner; an admission, a transfer or a change of keepers by the keepers.
- Each line carries the hash of the line before it, so the log can only grow.
  Every machine remembers the last head it read and refuses a copy that
  rewrote or dropped entries, and the first line is built into `mind`.
- A timekeeper key, which can sign nothing else, checkpoints the log daily
  ([Checkpoint](.github/workflows/checkpoint.yml)), and `mind` refuses a log
  whose newest checkpoint is over 7 days old: nobody can be held on an old
  copy.

The format, and `mind index` for keepers, are in
[mind's README](https://github.com/dream-mindv2/mind#the-index).

## Keepers

- `ed25519:bde9a3d8455de52a05c45e788e71d7ebc6038101d046790fee5a8b7ffdb978ab`

Timekeeper: `ed25519:5b929ae440a46d7e63a84ff227c4fd9c388b24f9c4aa919b9aace4a3731d3469`
