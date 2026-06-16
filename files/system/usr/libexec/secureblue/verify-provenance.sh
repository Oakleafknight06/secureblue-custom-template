#!/usr/bin/bash

# SPDX-FileCopyrightText: Copyright 2025 The Secureblue Authors
#
# SPDX-License-Identifier: Apache-2.0

# To use with your own image, edit lines 17 and 18 to reflect your GitHub account and image repo URL

set -euo pipefail

# Ensure $HOME is set.
export HOME=${HOME:-~}

image_ref=$(rpm-ostree status --booted --json | jq -cr '.deployments[0]."container-image-reference"')
image_ref=${image_ref#*:docker://}
case "${image_ref}" in
    ghcr.io/oakleafknight06/*)
        source_uri='github.com/Oakleafknight06/secureblue-custom-template'
        ;;
    *)
        echo "WARNING: Unknown image reference '${image_ref}'; unable to check provenance."
        exit 1
        ;;
esac
echo "Verifying build provenance for ${image_ref}..."

image_tag="${image_ref##*:}"
case "${image_tag}" in
    latest)
        branch='main'
        ;;
    br-*)
        branch="${image_tag#br-}"
        branch="${branch%-*}"
        ;;
    *)
        echo "WARNING: Unknown image tag '${image_tag}'; unable to check provenance."
        exit 1
        ;;
esac
echo "Source: ${source_uri}:${branch}"

full_ref=$(crane digest --full-ref "${image_ref}")
echo "Image reference: ${full_ref}"

slsa-verifier verify-image --source-uri "${source_uri}" --source-branch "${branch}" "${full_ref}"
