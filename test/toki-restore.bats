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

@test "existing interval" { # {{{

	timew start tag >/dev/null

	run toki-restore
	assert_failure
	assert_output 'There is already active tracking.'

} # }}}

@test "toki-restore" { # {{{

	timew track foo bar 10minutes >/dev/null
	timew shorten @1 5minutes >/dev/null

	run toki-restore
	assert_success
	assert_equal "$(timew get dom.active.duration)" PT10M
	assert_equal "$(timew get dom.active.tag.1)" bar
	assert_equal "$(timew get dom.active.tag.2)" foo
	assert_line 'Tracking bar foo'

} # }}}
