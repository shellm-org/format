<p align="center">
  <img src="https://gl.githack.com/shellm/format/raw/master/logo.png">
</p>

<h1 align="center">Style and Colors</h1>

<p align="center">Format your messages with style and colors.</p>

<p align="center">
  <a href="https://gitlab.com/shellm/format/commits/master">
    <img alt="pipeline status" src="https://gitlab.com/shellm/format/badges/master/pipeline.svg" />
  </a>
  <!--<a href="https://gitlab.com/shellm/format/commits/master">
    <img alt="coverage report" src="https://gitlab.com/shellm/format/badges/master/coverage.svg" />
  </a>-->
  <a href="https://gitter.im/shellm/format">
    <img alt="gitter chat" src="https://badges.gitter.im/shellm/format.svg" />
  </a>
</p>

`format` is a function designed to help you add style and colors
in your terminal messages.

<h2 align="center">Demo</h2>
<p align="center"><img src="https://gl.githack.com/shellm/format/raw/master/demo/demo.svg"></p>
<p align="center"><em>Demo generated with <a href="https://github.com/nbedos/termtosvg">termtosvg</a>.</p>

## Installation
Installation is done with [basher](https://github.com/basherpm/basher):

```bash
basher install gitlab.com/shellm/format
```

## Usage
`format` can be used several ways:

1. by directly giving the string to print:

  ```bash
  format bold blue onWhite -- " info "
  ```

2. by first printing the style and colors, then multiple strings:

  ```bash
  format bold red
  echo "error: this is not supposed to do that,"
  echo "please turn off your computer."
  format reset
  ```

3. with subprocesses, to use different styles and colors in the same string:

  ```bash
  echo "$(format strike)easy$(format bold) very easy$(format reset) to use!"
  ```

4. with `printf`:

  ```bash
  printf "%s warning %s your computer will leave the room in 3...2...1...\n" \
    "$(format bold black onIntenseYellow)" \
    "$(format reset)"
  ```
