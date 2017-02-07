#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../ooengine" || exit 1

# Example 0: Classes and objects.

# This is the most possible simplistic "class".
@class:YourClassName() {
  : # With classes you define how an object of it looks like.
}

# Create a new object based on the defined class.
declare -g yourObject
@new YourClassName yourObject

# $yourObject now contains a reference to the new object.
# This variable can be passed around however you like.

# You can destruct an object and its contents by calling the "destruct" method.
# Syntax: $yourObject [method] [parameters ...]
$yourObject __destruct
