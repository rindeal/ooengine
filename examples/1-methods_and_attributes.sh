#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../ooengine" || exit 1

# Example 1: Simple methods and attributes.

@class:SomeOtherClass() {
  $this # Within a class there's always the $this global available.
        # It points to the current object itsself.
        # Syntax: $this [method] [parameters ...]
}

# A simple base class named 'TestClass'.
@class:TestClass() {

  # Public attribute, 'get' and 'set'-able.
  @public attributePublic "optional default value"

  # Private attribute, only internal 'get' and 'set'-able.
  @private attributePrivate "optional default value"

  # Public method, reachable with any reference.
  @method:publicTestMethod() {
    echo "Do something here."
    # Call private method.
    $this internalTestMethod msg="hello world" payload:=var
    @out ret=1
  }

  # Public getter method for private attribute 'attributePrivate'.
  @method:getAttributePrivate() {
    $this get attributePrivate
  }

  # Public setter method for private attribute 'attributePrivate'.
  @method:setAttributePrivate() {
    $this set attributePrivate "$1"
  }

  # Private method, only internal reachable with $this reference.
  @__method:internalTestMethod() {
    echo "Or do something here."
  }
}

# Create an object of the class.
#testObject=$(@new TestClass)
@new TestClass testObject


# Call a method.

# no arguments, echo output
$testObject publicTestMethod []
# no arguments, set output to var
$testObject publicTestMethod [] -: var
$testObject publicTestMethod [ "hello world" new_value:=second 3="third" ] -: out1,out2
# set value directly
$testObject attributePublic = "New value"
# set value from var
$testObject attributePublic := var
# echo value
$testObject attributePublic
# set value to var
$testObject attributePublic -: var

# Get a public attribute.
value=$($testObject get attributePublic)
echo $value

# Set a public attribute.
$testObject set attributePublic "New value"
$testObject get attributePublic


# Get a private attribute.
# echo $($testObject get attributePrivate) # This would fail.
value=$($testObject getAttributePrivate)
echo $value

# Set a private attribute.
# $testObject set attributePrivate # This would fail.
$testObject setAttributePrivate "New value"
