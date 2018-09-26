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
