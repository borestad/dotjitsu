#!/bin/sh

URL="https://0x0.st"

if [ $# -eq 0 ]; then
    echo "Usage: 0x0.st FILE\n"
    exit 1
fi

FILE=$1

if [ ! -f "$FILE" ]; then
    echo "File ${FILE} not found"
    exit 1
fi

RESPONSE=$(curl -# -F "file=@${FILE}" "${URL}")

echo "${RESPONSE}" | pbcopy # to clipboard
echo "${RESPONSE}"  # to terminal