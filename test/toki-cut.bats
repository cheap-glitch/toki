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

	run toki help cut
	assert_success
	assert_output --partial 'timew-cut -'

	run toki-cut --help
	assert_success
	assert_output --partial 'timew-cut -'

} # }}}

@test "no interval" { # {{{

	run toki cut
	assert_failure
	assert_output 'There is no active time tracking.'

} # }}}

@test "toki-cut" { # {{{

	toki start tag 30.5minutes ago >/dev/null

	run toki cut
	assert_equal "$(timew get dom.tracked.1.duration)" PT30M
	assert_success

} # }}}

@test "toki-cut <date>" { # {{{

	toki start tag 30.5minutes ago >/dev/null

	run toki cut 2minutes ago
	assert_equal "$(timew get dom.tracked.1.duration)" PT28M
	assert_success

} # }}}
