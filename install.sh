#!/usr/bin/env bash
set -e

PREFIX="${1:-/usr/local}"
APP_ROOT="$(dirname "$(readlink -f "$0")")"
NAMESPACE="shellm-org"
PACKAGE="format"
INSTALL_PATH="packages/${NAMESPACE}/${PACKAGE}"

_link() {
  local s t
  t="$1"
  shift
  if [ $# -eq 1 ] && [ ! -f "$1" ]; then
    return 1
  fi
  for s in "$@"; do
    [ -e "$t/${s##*/}" ] && echo "  warning: overwriting $t/${s##*/}" >&2
    ln -fs "$s" "$t"
  done
}

echo "Create directories... "
mkdir -vp "${PREFIX}"/{bin,completions/{bash,zsh},${INSTALL_PATH},man/man{1,3}}

echo "Install package... "
cp -vRT "${APP_ROOT}" "${PREFIX}/${INSTALL_PATH}"

echo "Link binaries... "
_link "${PREFIX}"/bin "${PREFIX}/${INSTALL_PATH}"/bin/*

echo "Link man pages... "
_link "${PREFIX}"/man/man1 "${PREFIX}/${INSTALL_PATH}"/man/*.1
_link "${PREFIX}"/man/man3 "${PREFIX}/${INSTALL_PATH}"/man/*.3

echo "Link completions... "
_link "${PREFIX}"/completions/bash "${PREFIX}/${INSTALL_PATH}"/cmp/*.bash
_link "${PREFIX}"/completions/zsh "${PREFIX}/${INSTALL_PATH}"/cmp/*.zsh
