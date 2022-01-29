#!/usr/bin/env bats
# shellcheck disable=SC2312

TEST_DIR="$(dirname "${BATS_TEST_FILENAME:-}")"

setup() {
	load ./node_modules/bats-support/load.bash
	load ./node_modules/bats-assert/load.bash

	PATH="${PATH}:${TEST_DIR}/../src"

	export TIMEWARRIORDB="${BATS_TEST_TMPDIR:-}/.timewarriordb"
	mkdir "${TIMEWARRIORDB}"
}

@test "help" { # {{{

	run toki help switch
	assert_success
	assert_output --partial 'timew-switch -'

	run toki-switch --help
	assert_success
	assert_output --partial 'timew-switch -'

} # }}}

@test "toki-switch" { # {{{

	toki start tag 5minutes ago

	run toki switch new_tag
	assert_success
	assert_equal "$(timew get dom.active.tag.1)" new_tag

} # }}}
