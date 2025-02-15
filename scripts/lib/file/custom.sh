#!/usr/bin/env sh

set -euf

_file_custom_exists() {
    _file_custom_get "$@" >/dev/null
}

_file_custom_get() {
    _tmp_file=$(_mktemp)

    if ! "${HELM_BIN}" template "${SCRIPT_DIR}/lib/file/helm-values-getter" -f "${1}" >"${_tmp_file}"; then
        exit 1
    fi

    _sed_i '/^# Source: /d' "${_tmp_file}"
    printf '%s' "${_tmp_file}"
}

_file_custom_put() {
    echo "Can't write to remote files!"
    exit 1
}
