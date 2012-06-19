# MassRename

Use `mass-rename` to quickly rename a glob of files using numbering and 
optionally a file containing one name on each line.

It is also just me playing around trying to get used to TDD.

## Installation

You probably only want to use this as a CLI utility. Get it via

    $ gem install mass-rename

## Usage

Run

    $ mass-rename --help

for a list of all options.

A naming file (for `--names`) is expected to have one name on each line with
no exceptions. If there are more names than files to rename, the extraneous
names are ignored.



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
