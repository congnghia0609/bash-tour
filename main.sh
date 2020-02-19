#!/bin/bash
# The first line of any script should be: #!/bin/bash

# You must make bash scripts executable: sudo chmod +x main.sh


##################################
# 1. Comments
##################################
# Single line comment
: '
This is a
multi line
comment
'

##################################
# 2. Basics
##################################
name="NghiaTC"
echo ${name} #=> NghiaTC
# substitution replace first match
echo ${name/N/n} #=> nghiaTC
# substitution replace all
user="nghiaXX"
echo ${user//X/x} #=> nghiaxx
# slicing index=3, get 2 characters
echo ${name:3:2} #=> ia
index=3
length=2
echo ${name:index:length} #=> ia
# slicing from begin index=0, get 2 characters
echo ${name::2} #=> Ng
# slicing from begin index=0, get (len-1) characters
echo ${name::-1} #=> NghiaT
# slicing right 
echo ${name:(-2)} #=> TC
# slicing right from index=len-2, get 1 character
echo ${name:(-2):1} #=> T


# substitution
STR="/path/to/foo.cpp"
# Remove suffix '.cpp'
echo ${STR%.cpp} #=> /path/to/foo
echo ${STR%.cpp}.o #=> /path/to/foo.o
# Remove long suffix. Get extension.
echo ${STR##*.} #=> cpp
# Remove long prefix. Get filename.
echo ${STR##*/} #=> foo.cpp
# Get file path.
filename=${STR##*/} #=> foo.cpp
filepath=${STR%$filename} #=> /path/to/
echo $filepath
# Replace prefix
echo ${STR#*/} #=> path/to/foo.cpp
# Replace first match
echo ${STR/foo/bar} #=> /path/to/bar.cpp


# Length of STR
echo ${#STR} #=> 16


# Default value:
# $food1, or val if not set
echo ${food1} #=> Null value
f1=${food1:-Cake}
echo ${food1} #=> Null value
echo ${f1} #=> Cake
# Set $food2 to val if not set
echo ${food2:=Cake} #=> Cake
echo ${food2} #=> Cake
# val if $food3 is set
echo ${food3:+Cake} #=> Null value


# Manipulation
STR="Hello World"
# lowercase 1st letter
echo ${STR,} #=> hello World
# all lowercase
echo ${STR,,} #=> hello world
STR="hello world"
# uppercase 1st letter
echo ${STR^} #=> Hello world
# all uppercase
echo ${STR^^} #=> HELLO WORLD


