# format
Format your output with style and color.

- Authors: https://github.com/shellm-org/format/AUTHORS.md
- Changelog: https://github.com/shellm-org/format/CHANGELOG.md
- Contributing: https://github.com/shellm-org/format/CONTRIBUTING.md
- Documentation: https://github.com/shellm-org/format/wiki
- License: ISC - https://github.com/shellm-org/format/LICENSE

## Installation
Installation with [basher](https://github.com/basherpm/basher):
```bash
basher install shellm-org/format
```

Installation from source:
```bash
git clone https://github.com/shellm-org/format
cd format
sudo ./install.sh
```

## Usage
Command-line:
```
man format.sh
```

As a library:
```bash
# with basher's include
include shellm-org/format lib/format.sh
# with shellm's include
shellm-include shellm-org/format lib/format.sh

# both are equivalent
format bold black underline onIntenseBlue newLine -- INFO
format B b U oib nl -- INFO

# dry-run to see what would be written
format g oy dryRun  # \033[;32;43m

# redirect to STDERR
format bold white onRed redirectErr CRITICAL

# with subprocesses
echo "$(format bold black onIntenseYellow) WARNING $(format resetAll) message" >&2
```
