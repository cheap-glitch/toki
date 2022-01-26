#!/usr/bin/env bats

TEST_DIR="$(dirname "${BATS_TEST_FILENAME:-}")"

setup() {
	load ./node_modules/bats-support/load.bash
	load ./node_modules/bats-assert/load.bash

	PATH="${TEST_DIR}:${PATH}:${TEST_DIR}/../src"
}

@test "stub" { # {{{

	run toki foo bar baz
	assert_success
	assert_output 'foo bar baz'

	run toki stop
	assert_success
	assert_line 'Recorded tag'

} # }}}

@test "help" { # {{{

	run toki help
	assert_success
	assert_line 'Aliases:'
	assert_line 'Additional commands:'

	run toki help cut
	assert_success
	assert_output --partial 'timew-cut -'

	run toki help switch
	assert_success
	assert_output --partial 'timew-switch -'

	run toki-cut --help
	assert_success
	assert_output --partial 'timew-cut -'

	run toki-switch --help
	assert_success
	assert_output --partial 'timew-switch -'

} # }}}

@test "aliases" { # {{{

	run toki extend @1 10mins
	assert_success
	assert_output 'lengthen @1 10mins'

	run toki + @1 10mins
	assert_success
	assert_output 'lengthen @1 10mins'

	run toki merge @1 @2
	assert_success
	assert_output 'join @1 @2'

	run toki record tag 12:00 - 12:30
	assert_success
	assert_output 'track tag 12:00 - 12:30'

	run toki reduce @1 10mins
	assert_success
	assert_output 'shorten @1 10mins'

	run toki - @1 10mins
	assert_success
	assert_output 'shorten @1 10mins'

	run toki t tag 10mins
	assert_success
	assert_output 'track tag 10mins'

	run toki add tag 10mins
	assert_success
	assert_output 'track tag 10mins'

	run toki a tag 10mins
	assert_success
	assert_output 'track tag 10mins'

	run toki remove @1
	assert_success
	assert_output 'delete @1'

	run toki d @1
	assert_success
	assert_output 'delete @1'

} # }}}

@test "default interval" { # {{{

	run toki delete
	assert_success
	assert_output 'delete @1'

	run toki lengthen 10mins
	assert_success
	assert_output 'lengthen 10mins @1'

	run toki shorten 10mins
	assert_success
	assert_output 'shorten 10mins @1'

} # }}}

@test "extended time notation" { # {{{

	run toki track tag 45m
	assert_success
	assert_output 'track tag 45minutes'

	run toki track tag 45M
	assert_success
	assert_output 'track tag 45minutes'

	run toki track tag 45months
	assert_success
	assert_output 'track tag 45months'

	run toki track tag 3h45m
	assert_success
	assert_output 'track tag PT3H45M'

	run toki track tag 3H45M
	assert_success
	assert_output 'track tag PT3H45M'

	run toki track tag 3h45
	assert_success
	assert_output 'track tag PT3H45M'

	run toki track tag 45m26s
	assert_success
	assert_output 'track tag PT45M26S'

	run toki track tag 45M26S
	assert_success
	assert_output 'track tag PT45M26S'

	run toki track tag 45M26s
	assert_success
	assert_output 'track tag PT45M26S'

	run toki track tag 3h45m26s
	assert_success
	assert_output 'track tag PT3H45M26S'

	run toki track tag 3h45m26
	assert_success
	assert_output 'track tag PT3H45M26S'

} # }}}

@test "toki-cut" { # {{{

	run toki cut
	assert_success
	assert_output 'shorten @1 15seconds'

	run toki cut 2m ago
	assert_success
	assert_output 'shorten @1 15seconds'

} # }}}

@test "toki-switch" { # {{{

	run toki switch new_tag
	assert_success
	assert_output - <<- END
		cut
		start new_tag
	END

} # }}}
