#!/usr/bin/env bash

INP=README.md
OUT=TEMP.md

flush() {
    (printf "%s\n" "${lines[@]:0:2}") >> $OUT
    (printf "%s\n" "${lines[@]:2}" | sort -t \| -n -k 4) >> $OUT
    lines=()
}

while IFS= read -r line; do
    if [[ ${line:0:1} = "|" ]]; then
        lines+=("$line")
    else
        (( ${#lines[@]} > 0 )) && flush
        echo $line >> $OUT
    fi
unset IFS

done < $INP
mv $OUT $INP
