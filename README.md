# ⏳ toki

![License](https://badgen.net/github/license/cheap-glitch/toki?color=green)
![Latest release](https://badgen.net/github/release/cheap-glitch/toki?color=green)
[![Coverage status](https://coveralls.io/repos/github/cheap-glitch/toki/badge.svg?branch=main)](https://coveralls.io/github/cheap-glitch/toki?branch=main)

**toki**  ([時](https://jisho.org/search/%E6%99%82)) is  a  Bash wrapper  around
`timew`, the [Timewarrior](https://timewarrior.net) CLI.

## Features

 * Extra commands
 * Convenient aliases for built-in commands
 * Extended duration syntax (e.g. `timew track tag for 1h35m20s`)
 * Use `m` as suffix for minutes instead of months
 * Act on the latest interval by default
 * Get notified of errors when running `timew` outside of a terminal

## Installation

Make sure you have [installed Timewarrior](https://timewarrior.net/docs/install) first.

> Note: `toki` is only compatible with the 1.4.x version of `timew`

Clone the repo or download the scripts from [the latest release](https://github.com/cheap-glitch/toki/releases/latest),
and make sure they're executable (`chmod +x <scripts>`).

The `toki` script can be use in  place of `timew` (one character less to type!).
Or, if you don't  want to retrain your fingers, you can  alias `timew` to `toki`
and get all of its benefits transparently.

Source `_completion.bash` in your `bashrc` to enable better completion.

## Usage

`toki` is used  exactly like `timew`, with a few  additions and differences that
are listed below.

Commands that expect  an ID (`delete`, `tag`, `lengthen`, etc.)  will default to
`@1` if none is provided.

### Extra commands

 * `toki-cut`: stop tracking and truncate the stopped interval to the closest minute
 * `toki-switch`: cut the current interval and starts another

See `toki help <command>` for more info.

### Aliases

 * `lengthen`: `+`, `extend`
 * `shorten`: `-`, `reduce`
 * `join`: `merge`
 * `track`: `t`, `a`, `add`, `record`
 * `continue`: `restart`
 * `delete`: `d`, `remove`

### Extended duration syntax

`toki` adds support for the following duration syntaxes:
 * `<minutes>m` (the `m` suffix is treated as minutes instead of months)
 * `<hours>h<minutes>`
 * `<hours>h<minutes>m`
 * `<hours>h<minutes>m<seconds>`
 * `<hours>h<minutes>m<seconds>s`

## Contributing

Contributions are welcomed! Please open an issue before submitting substantial changes.

## Related

 * [https://timewarrior.net/docs](https://timewarrior.net/docs) - The official Timewarrior manual

## License

ISC
