# 🚧🚧UNDER CONTSTRUCTION🚧🚧
_This repo is a WIP template for how to create a cusotm image based on Secureblue with BlueBuild. I maintain an image for myself, but there are some hurdles with using Secureblue as a base image that I'd like to document in a less cluttered space._

# Secureblue Custom Image Template &nbsp; [![build](https://github.com/Oakleafknight06/secureblue-custom-template/actions/workflows/build.yml/badge.svg)](https://github.com/Oakleafknight06/secureblue-custom-template/actions/workflows/build.yml) [![verify-provenance](https://github.com/Oakleafknight06/secureblue-custom-template/actions/workflows/provenance.yml/badge.svg)](https://github.com/Oakleafknight06/secureblue-custom-template/actions/workflows/provenance.yml)
See the [BlueBuild docs](https://blue-build.org/how-to/setup/) for quick setup instructions for setting up your own repository based on this template.

After setup, it is recommended you update this README to describe your custom image.

## Features required as a Secureblue downstream image
- Image name starts with `silverblue` (or a number of other things) for audit script compatibility
    - TODO: link audit script and explain why this is
- Provenance verification. See build scripts and `/usr/libexec/secureblue/verify-provenance.sh`
- `secureblue.pub` public key to verify base image

## Things you need to change to use this image template
*TODO: Add the why behind some of these*
- Follow BlueBuild custom image instructions to generate your own cosign keys
- Edit the `source-uri` on line 18 in `verify-provenance.sh`
- Edit `FULL_IMAGE_REF` in `build.yml` to point to your image
- Edit `github.triggering_actor` on line 21 of `verify-provenance.yml` to point to your own GitHub user
- Edits in "Verify Provenance" section of `verify-provenance.yml` as specified in the comment on line 41

## Installation
_TODO_: update with tested reproduction of steps from vanilla secureblue to this image
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
_TODO_: Add mention of provenance verification 
These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/blue-build/template
```
