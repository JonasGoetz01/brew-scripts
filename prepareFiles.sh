#!/bin/bash

for file in $(find . -name '*.c'); do
    name=$(basename "$file" .c)
    gcc -o "${name}" "$file"
	target="$(dirname "${BASH_SOURCE[0]}")/${name}"
    if [[ "$file" != "$target" ]]; then
        mv -f "${name}" "$target"
    fi
done

for file in $(find . -name '*.rb'); do
    name=$(basename "$file" .rb)
    cp -f "$file" "$(dirname "${BASH_SOURCE[0]}")/${name}"
done
