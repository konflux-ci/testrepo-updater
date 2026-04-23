#!/usr/bin/env bash
# Public-sample cleanup for konflux-ci/testrepo pipelines/:
# 1. Leave build.appstudio.openshift.io/repo blank (empty string) for PAC/forks.
# 2. Set metadata.namespace to user-ns2 (Kind demo user workspace) so users can copy YAML
#    into a fork without the updater's Konflux tenant namespace.
# 3. Replace remaining testrepo-updater with testrepo (labels, names, SA strings, etc.).
#
# Usage: sanitize-testrepo-pipeline-metadata.sh <pipelines_dir>
# Requires: mikefarah yq
set -euo pipefail

PIPES="${1:?pipelines directory required}"

shopt -s nullglob
for f in "$PIPES"/*.yaml "$PIPES"/*.yml; do
  [[ -e "$f" ]] || continue
  kind="$(yq -r '.kind // ""' "$f" 2>/dev/null || true)"
  [[ "$kind" == "PipelineRun" ]] || continue

  yq -i '.metadata.annotations = (.metadata.annotations // {})' "$f"
  yq -i '.metadata.annotations["build.appstudio.openshift.io/repo"] = ""' "$f"
  yq -i '.metadata.namespace = "user-ns2"' "$f"

  # Replace Konflux component/org string (repo URL was cleared above so it is not rewritten here).
  sed -i 's/testrepo-updater/testrepo/g' "$f"
done

echo "sanitize-testrepo-pipeline-metadata: done"
