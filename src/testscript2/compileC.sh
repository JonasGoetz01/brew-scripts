#!/bin/bash

for file in $(find . -name '*.c'); do
    name=$(basename "$file" .c)
    gcc -o "${name}" "$file"
    mv "${name}" "$(dirname "${BASH_SOURCE[0]}")"
done

for file in **/*.rb; do
	name=$(basename "$file" .rb)
	cp **/*.rb $name
done
