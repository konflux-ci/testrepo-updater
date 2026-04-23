#!/usr/bin/env bash
# Konflux names PipelineRuns testrepo-updater-pull-request.yaml; public konflux-ci/testrepo uses
# testrepo-pull-request.yaml / testrepo-push.yaml. Rename so the mirror matches the sample repo.
# Usage: rename-pipelines-for-public-testrepo.sh <repo_root>
set -euo pipefail

ROOT="${1:?repo root required}"
PIPES="${ROOT}/pipelines"

if [[ ! -d "$PIPES" ]]; then
  exit 0
fi

pr_src="${PIPES}/testrepo-updater-pull-request.yaml"
push_src="${PIPES}/testrepo-updater-push.yaml"

if [[ ! -f "$pr_src" ]] || [[ ! -f "$push_src" ]]; then
  echo "rename-pipelines-for-public-testrepo: expected Konflux files missing; skipping rename"
  exit 0
fi

mv -f "$pr_src" "${PIPES}/testrepo-pull-request.yaml"
mv -f "$push_src" "${PIPES}/testrepo-push.yaml"
echo "rename-pipelines-for-public-testrepo: Konflux pipelines -> testrepo-pull-request.yaml, testrepo-push.yaml"
