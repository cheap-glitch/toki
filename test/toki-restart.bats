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

@test "no interval" { # {{{

	run toki-restart
	assert_failure
	assert_output 'There is no active time tracking.'
	assert_equal "$(timew get dom.active)" 0

} # }}}

@test "toki-restart" { # {{{

	toki start foo bar 10minutes ago &>/dev/null

	run toki-restart
	assert_success
	assert_equal "$(timew get dom.active.duration)" PT0S
	assert_line 'Canceled active time tracking.'
	assert_line 'Tracking bar foo'
	assert_equal "$(timew get dom.active.tag.1)" bar
	assert_equal "$(timew get dom.active.tag.2)" foo

} # }}}

@test "toki-restart <date>" { # {{{

	toki start foo bar 10minutes ago &>/dev/null

	run toki-restart 30minutes ago
	assert_success
	assert_equal "$(timew get dom.active.duration)" PT30M
	assert_line 'Canceled active time tracking.'
	assert_line 'Tracking bar foo'
	assert_equal "$(timew get dom.active.tag.1)" bar
	assert_equal "$(timew get dom.active.tag.2)" foo

} # }}}
