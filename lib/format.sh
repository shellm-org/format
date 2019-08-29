## \brief Format your output with style and color.

## \example Black background, intense-green foreground, fainted and bold:
## \example-code bash
##   format onBlack intenseGreen faint bold; echo 'SUCCESS!'; format reset
## \example Bold, black foreground, underline, intense-blue background and new line:
## \example-code bash
##   format B k U oib nl INFO

## \desc Available arguments to the 'format' function:
##
##     Foreground       │  Foreground (intense)
##     _________________│________________________________
##                      │
##     d, default       │
##     k, black         │  ik, intenseBlack
##     r, red           │  ir, intenseRed
##     g, green         │  iG, intenseGreen
##     y, yellow        │  iy, intenseYellow
##     b, blue          │  ib, intenseBlue
##     m, magenta       │  im, intenseMagenta
##     c, cyan          │  ic, intenseCyan
##     w, white         │  iw, intenseWhite
##
##     Background       │  Background (intense)
##     _________________│________________________________
##                      │
##     od, onDefault    │
##     ok, onBlack      │  oik, onIntenseBlack
##     or, onRed        │  oir, onIntenseRed
##     og, onGreen      │  oiG, onIntenseGreen
##     oy, onYellow     │  oiy, onIntenseYellow
##     ob, onBlue       │  oib, onIntenseBlue
##     om, onMagenta    │  oim, onIntenseMagenta
##     oc, onCyan       │  oic, onIntenseCyan
##     ow, onWhite      │  oiw, onIntenseWhite
##
##     Style            │  Reset style
##     _________________│________________________________
##                      │
##                      │  ra, RA, reset, resetAll
##     B, bold          │  rb, RB, resetBold
##     F, faint         │  rf, RF, resetFaint
##     I, italic        │  ri, RI, resetItalic
##     U, underlin      │  ru, RU, resetUnderline
##     K, blink         │  rk, RK, resetBlink
##     R, reverse       │  rr, RR, resetReverse
##     H, hidden        │  rh, RH, resetHidden
##     S, strike        │  rs, RS, resetStrike
##
##     Extra            │  Explanation
##     _________________│________________________________
##                      │
##     nl, newline      │  Add a newline at the end.
##     dr, dryrun       │  Don't interpret ansi codes.
##     er, stderr       │  Print on standard error.
##     nr, noreset      │  Don't reset previous sequences.
##     --               │  Stop interpretation of arguments as options.

## \note On linux terminals (tty), high intensity colors will
## be replaced by their 8-colors equivalent.
## Also underline, faint and blink will be ignored.
## Other available styles may or may not be interpreted by your terminal.


__format_print() {
  local F_empty=0

  if [ -z "$F" ]; then
    F_empty=1
  else
    # shellcheck disable=SC2086
    if [ ${NORESET} -eq 1 ]; then
      F="${F#;}"
    fi
    F="${ESC}${F}m"
  fi

  if [ ${F_empty} -eq 0 ]; then
    # shellcheck disable=SC2086
    [ ! -n "${SHELLM_NO_FORMAT}" ] && echo -n${E} "${F}"
  fi

  if [ $# -ne 0 ]; then
    # shellcheck disable=SC2086
    echo -n${E} "$@"
    # shellcheck disable=SC2086
    echo -n${E}

    if [ ${F_empty} -eq 0 ]; then
      # shellcheck disable=SC2086
      [ ! -n "${SHELLM_NO_FORMAT}" ] && echo -n${E} "${ESC}0m"
    fi
  fi

  # shellcheck disable=SC2086
  if [ ${NEWLINE} -eq 1 ]; then
    echo ''
  fi
}

## \function format [OPTIONS] [ARGS]
## \function-brief Format the output with style and color
## \function-argument OPTIONS Letters or complete names of style/colors.
## \function-argument ARGS Text to print.
## \function-stdout The formatted string.
if [ "${TERM}" = linux ]; then # 8 colors

  format() {
    local NEWLINE=0
    local REDIRECT=0
    local NORESET=0
    local E='e'
    local ESC='\033['
    local F=""
    while [ $# -ne 0 ]; do
      case "$1" in
        # Foreground
        d|default) F=$F\;39 ;;
        k|black) F=$F\;30 ;;
        r|red) F=$F\;31 ;;
        g|green) F=$F\;32 ;;
        y|yellow) F=$F\;33 ;;
        b|blue) F=$F\;34 ;;
        m|magenta) F=$F\;35 ;;
        c|cyan) F=$F\;36 ;;
        w|white) F=$F\;37 ;;

        # Foreground extended
        ik|intenseBlack) F=$F\;30 ;;  # black
        ir|intenseRed) F=$F\;31 ;;  # red
        iG|intenseGreen) F=$F\;32 ;;  # green
        iy|intenseYellow) F=$F\;33 ;;  # yellow
        ib|intenseBlue) F=$F\;34 ;;  # blue
        im|intenseMagenta) F=$F\;35 ;;  # magenta
        ic|intenseCyan) F=$F\;36 ;;  # cyan
        iw|intenseWhite) F=$F\;37 ;;  # white

        # Background
        od|onDefault) F=$F\;49 ;;
        ok|onBlack) F=$F\;40 ;;
        or|onRed) F=$F\;41 ;;
        og|onGreen) F=$F\;42 ;;
        oy|onYellow) F=$F\;43 ;;
        ob|onBlue) F=$F\;44 ;;
        om|onMagenta) F=$F\;45 ;;
        oc|onCyan) F=$F\;46 ;;
        ow|onWhite) F=$F\;47 ;;

        # Background extended
        oik|onIntenseBlack) F=$F\;40 ;;  # black
        oir|onIntenseRed) F=$F\;41 ;;  # red
        oiG|onIntenseGreen) F=$F\;42 ;;  # green
        oiy|onIntenseYellow) F=$F\;43 ;;  # yellow
        oib|onIntenseBlue) F=$F\;44 ;;  # blue
        oim|onIntenseMagenta) F=$F\;45 ;;  # magenta
        oic|onIntenseCyan) F=$F\;46 ;;  # cyan
        oiw|onIntenseWhite) F=$F\;47 ;;  # white

        # Style
        B|bold) F=$F\;1 ;;
        F|faint) ;; #F=$F\;2 ;;
        I|italic) ;; #F=$F\;3 ;;
        U|underline) ;; #F=$F\;4 ;;
        K|blink) ;; #F=$F\;5 ;;
        R|reverse) F=$F\;7 ;;
        H|hidden) F=$F\;8 ;;
        S|strike) F=$F\;9 ;;

        # Reset style
        ra|RA|reset|resetAll) F=$F\;0 ;;
        rb|RB|resetBold) F=$F\;21 ;;
        rf|RF|resetFaint) ;; #F=$F\;22 ;;
        ri|RI|resetItalic) ;; #F=$F\;23 ;;
        ru|RU|resetUnderline) ;; #F=$F\;24 ;;
        rk|RK|resetBlink) ;; #F=$F\;25 ;;
        rr|RR|resetReverse) F=$F\;27 ;;
        rh|RH|resetHidden) F=$F\;28 ;;
        rs|RS|resetStrike) F=$F\;20 ;;

        # Extra
        nl|newline) NEWLINE=1 ;;
        dr|dryrun) E='' ;;
        er|stderr) REDIRECT=1 ;;
        nr|noreset) NORESET=1 ;;

        --) shift; break ;;
        *) break ;;
      esac
      shift
    done

    if [ ${REDIRECT} -eq 1 ]; then
      __format_print "$@" >&2
    else
      __format_print "$@"
    fi

  }

else # 16 colors

  format() {
    local NEWLINE=0
    local REDIRECT=0
    local NORESET=0
    local E='e'
    local ESC='\033['
    local F=""
    while [ $# -ne 0 ]; do
      case "$1" in
        # Foreground
        d|default) F=$F\;39 ;;
        k|black) F=$F\;30 ;;
        r|red) F=$F\;31 ;;
        g|green) F=$F\;32 ;;
        y|yellow) F=$F\;33 ;;
        b|blue) F=$F\;34 ;;
        m|magenta) F=$F\;35 ;;
        c|cyan) F=$F\;36 ;;
        w|white) F=$F\;37 ;;

        # Foreground extended
        ik|intenseBlack) F=$F\;90 ;;
        ir|intenseRed) F=$F\;91 ;;
        ig|intenseGreen) F=$F\;92 ;;
        iy|intenseYellow) F=$F\;93 ;;
        ib|intenseBlue) F=$F\;94 ;;
        im|intenseMagenta) F=$F\;95 ;;
        ic|intenseCyan) F=$F\;96 ;;
        iw|intenseWhite) F=$F\;97 ;;

        # Background
        od|onDefault) F=$F\;49 ;;
        ok|onBlack) F=$F\;40 ;;
        or|onRed) F=$F\;41 ;;
        og|onGreen) F=$F\;42 ;;
        oy|onYellow) F=$F\;43 ;;
        ob|onBlue) F=$F\;44 ;;
        om|onMagenta) F=$F\;45 ;;
        oc|onCyan) F=$F\;46 ;;
        ow|onWhite) F=$F\;47 ;;

        # Background extended
        oik|onIntenseBlack) F=$F\;100 ;;
        oir|onIntenseRed) F=$F\;101 ;;
        oig|onIntenseGreen) F=$F\;102 ;;
        oiy|onIntenseYellow) F=$F\;103 ;;
        oib|onIntenseBlue) F=$F\;104 ;;
        oim|onIntenseMagenta) F=$F\;105 ;;
        oic|onIntenseCyan) F=$F\;106 ;;
        oiw|onIntenseWhite) F=$F\;107 ;;

        # Style
        B|bold) F=$F\;1 ;;
        F|faint) F=$F\;2 ;;
        I|italic) F=$F\;3 ;;
        U|underline) F=$F\;4 ;;
        K|blink) F=$F\;5 ;;
        R|reverse) F=$F\;7 ;;
        H|hidden) F=$F\;8 ;;
        S|strike) F=$F\;9 ;;

        # Reset style
        ra|RA|reset|resetAll) F=$F\;0 ;;
        rb|RB|resetBold) F=$F\;21 ;;
        rf|RD|resetFaint) F=$F\;22 ;;
        ri|RI|resetItalic) F=$F\;23 ;;
        ru|RU|resetUnderline) F=$F\;24 ;;
        rk|RK|resetBlink) F=$F\;25 ;;
        rr|RR|resetReverse) F=$F\;27 ;;
        rh|RH|resetHidden) F=$F\;28 ;;
        rs|RS|resetStrike) F=$F\;20 ;;

        # Extra
        nl|newline) NEWLINE=1 ;;
        dr|dryrun) E='' ;;
        er|stderr) REDIRECT=1 ;;
        nr|noreset) NORESET=1 ;;

        --) shift; break ;;
        *) break ;;
      esac
      shift
    done

    if [ ${REDIRECT} -eq 1 ]; then
      __format_print "$@" >&2
    else
      __format_print "$@"
    fi

  }

fi
