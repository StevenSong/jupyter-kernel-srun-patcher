#!/bin/bash
set -euo pipefail

usage() {
  echo "usage: $0 --node NODE --name NAME [--display-name DISPNAME]" >&2
  exit 1
}

NODE=
NAME=
DISPNAME=

while [[ $# -gt 0 ]]; do
  case "$1" in
    --node)
      NODE="$2"
      shift 2
      ;;
    --name)
      NAME="$2"
      shift 2
      ;;
    --display-name)
      DISPNAME="$2"
      shift 2
      ;;
    -h|--help)
      usage
      ;;
    *)
      echo "unknown option: $1" >&2
      usage
      ;;
  esac
done

[[ -n "$NODE" ]] || { echo "error: --node is required" >&2; usage; }
[[ -n "$NAME" ]] || { echo "error: --name is required" >&2; usage; }
DISPNAME=${DISPNAME:-$NAME}

KERNEL_STR=$(python -m ipykernel install --user --name $NAME --display-name $DISPNAME)

KERNEL_DIR=$(echo "$KERNEL_STR" | awk '{print $NF}')

CONFIG_FILE="$KERNEL_DIR/kernel.json"

prefix=$(jq -nc --arg node "$NODE" \
  '["srun","-w",$node,"--gres=gpu:1","--cpus-per-task=8","--mem=32G","--job-name=jupyter-kernel"]')

jq --argjson prefix "$prefix" '.argv = $prefix + .argv' \
  "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

echo $KERNEL_STR
