# container-image-upgrade-test

This project tests the package upgrade process for various container images,
with a focus on Chainguard images.

## How it Works

The core of this project is a generic `Dockerfile`. This Dockerfile is
designed to be built on top of different base container images
(e.g., `chainguard/nginx`, `chainguard/python`).

When a new image is built using this `Dockerfile`:

1. It takes a specified base image.
2. If the base image runs as the root user, it attempts to update all system
   packages using the appropriate package manager (apt-get, apk, or dnf).
3. It creates a non-root user `appuser` and switches to this user.

The primary goal is to verify that the package upgrade process completes
successfully on these base images. The GitHub Actions workflow in
`.github/workflows/container-image-upgrade-test.yml` likely orchestrates the
building and testing of these images.

## Usage

To trigger the test workflow, you can use the following `gh` command:

```bash
gh workflow run \
  --repo ruzickap/container-image-upgrade-test \
  container-image-upgrade-test
```

## Chainguard Images Tested

This project is used to test upgrades for Chainguard images. You can find
more details about the specific images here:

* [nginx](https://images.chainguard.dev/directory/image/nginx/compare)
* [node](https://images.chainguard.dev/directory/image/node/compare)
* [php](https://images.chainguard.dev/directory/image/php/compare)
* [python](https://images.chainguard.dev/directory/image/python/compare)
* [ruby](https://images.chainguard.dev/directory/image/ruby/compare)
