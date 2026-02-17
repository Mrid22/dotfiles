#!/bin/sh
TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")
SCOPE=$(/usr/bin/ls | gum choose)
DESCRIPTION=$(gum input)

git add .
git commit -a -m "$TYPE($SCOPE): $DESCRIPTION"
