Bash Wordsplit
--------------
This repo provides a bash library called `wordsplit.bash` which splits a string into words, similar to how bash splits args. This is useful because:

> Bash really doesn't have a good way to parse a string into substrings, while respecting quotes.
>
> -- <cite>[superuser](https://superuser.com/a/1529316/303009)</cite>

Wordsplit defines a single function called `wordsplit` which takes a string argument and splits it into the `WORDS` array. It uses the same rules as Bash does to splits args, except that it does not recognize ANSI-C [escape sequences](https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html) (`$'STRING'`).

If wordsplit detects an unterminated quote, it will return 1 and save the error message to `WORDERR`. Otherwise it returns 0.

Here's `example/parse-stdin.bash`:

    #!/bin/bash
    source wordsplit.bash
    while IFS= read -r;do
      wordsplit "$REPLY"
      printf "%s\n" "${WORDS[@]}"
    done

It reads a stream of input calling `wordsplit` for each line,  printing each word on a new line.

    echo ' foo bar\ baz      "a b\"c" \d' | example/parse-stdin.bash
    foo
    bar baz
    a b"c
    d

This output shows the behavior of some common cases. Space and horizontal tab are treated as whitespace. Leading, trailing and consecutive whitespace is ignored. Backslash escape behavior depends on the string:

1. Unquoted - a backslash escapes any special effect of the next character, such as whitespace or a quote.
2. Single quoted - backslash has no effect, is treated as a literal character.
3. Double quoted - a backslash escapes a double quote, backtick, backslash or dollar sign. Otherwise it is treated as a literal character.
