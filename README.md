# Secureblue Custom Image Template &nbsp; [![bluebuild build badge](https://github.com/blue-build/template/actions/workflows/build.yml/badge.svg)](https://github.com/blue-build/template/actions/workflows/build.yml)

# 🚧🚧UNDER CONTSTRUCTION🚧🚧
_This repo is a WIP template for how to create a cusotm image based on Secureblue with BlueBuild. I maintain an image for myself, but there are some hurdles with using Secureblue as a base image that I'd like to document in a less cluttered space._

See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

After setup, it is recommended you update this README to describe your custom image.

## TODO:
- [ ] Update build scripts
- [ ] Add provenance generation
  - [ ] Add badge to README
- [ ] Add provenance verification script
- [ ] Update README

## Features required as a Secureblue downstream image
- Image name starts with `silverblue` for audit script compatibility
- Provenance verification. See build scripts and `/usr/libexec/secureblue/verify-provenance.sh`

## Installation
_TODO_: update
To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/blue-build/template:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/blue-build/template:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag ... update with upstream

## Verification
_TODO_: Add mention of SLSA Provenance
These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/blue-build/template
```
