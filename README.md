# bash-tour
bash-tour is a cheat sheet, quick reference to learn bash programming  

## Code quick reference
Reference code detail in file main.sh  
```bash
#!/bin/bash
# The first line of any bash script should be: #!/bin/bash

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
# print
echo "Hello world!"

printf "Hello %s, I'm %s\n" Sven Olga
#=> "Hello Sven, I'm Olga

printf "1 + 1 = %d\n" 2
#=> "1 + 1 = 2"

printf "Print a float: %f\n" 2
#=> "Print a float: 2.000000"



##################################
# 2. Basics
##################################
name="NghiaTC"
echo ${name}                #=> NghiaTC
# slicing index=3, get 2 characters
echo ${name:3:2}            #=> ia
index=3
length=2
echo ${name:index:length}   #=> ia
# slicing from begin index=0, get 2 characters
echo ${name::2}             #=> Ng
# slicing from begin index=0, get (len-1) characters
echo ${name::-1}            #=> NghiaT
# slicing right 
echo ${name:(-2)}           #=> TC
# slicing right from index=len-2, get 1 character
echo ${name:(-2):1}         #=> T
# substitution replace first match
echo ${name/N/n}            #=> nghiaTC
# substitution replace all
user="nghiaXX"
echo ${user//X/x}           #=> nghiaxx


# substitution
STR="/path/to/foo.cpp"
# Remove suffix '.cpp'
echo ${STR%.cpp}            #=> /path/to/foo
echo ${STR%.cpp}.o          #=> /path/to/foo.o
# Remove long suffix. Get extension.
echo ${STR##*.}             #=> cpp
# Remove long prefix. Get filename.
echo ${STR##*/}             #=> foo.cpp
# Get file path.
filename=${STR##*/}         #=> foo.cpp
filedir=${STR%$filename}    #=> /path/to/
echo $filedir
# Replace prefix
echo ${STR#*/}              #=> path/to/foo.cpp
# Replace first match
echo ${STR/foo/bar}         #=> /path/to/bar.cpp


# Length of STR
echo ${#STR} #=> 16


# Default value:
# $food1, or val if not set
echo ${food1}           #=> Null value
f1=${food1:-Cake}
echo ${food1}           #=> Null value
echo ${f1}              #=> Cake
# Set $food2 to val if not set
echo ${food2:=Cake}     #=> Cake
echo ${food2}           #=> Cake
# val if $food3 is set
echo ${food3:+Cake}     #=> Null value


# Manipulation
STR="Hello World"
# lowercase 1st letter
echo ${STR,}        #=> hello World
# all lowercase
echo ${STR,,}       #=> hello world
STR="hello world"
# uppercase 1st letter
echo ${STR^}        #=> Hello world
# all uppercase
echo ${STR^^}       #=> HELLO WORLD



##################################
# 3. Loops
##################################

# Basic for loop
for i in `ls -d /usr/*`; do
  echo $i
done
# /usr/bin
# /usr/games
# /usr/include
# /usr/lib
# /usr/lib32
# /usr/local
# /usr/sbin
# /usr/share
# /usr/src

# C-like for loop
for ((i = 0; i < 5; i++)); do
  echo $i
done
# 0
# 1
# 2
# 3
# 4

# Ranges
for i in {1..5}; do
    echo "Welcome $i"
done
# Welcome 1
# Welcome 2
# Welcome 3
# Welcome 4
# Welcome 5

# Ranges with step size 5
for i in {10..30..5}; do
    echo "Welcome $i"
done
# Welcome 10
# Welcome 15
# Welcome 20
# Welcome 25
# Welcome 30

# Reading lines
cat file.txt | while read line; do
  echo $line
done
# This is line 1
# This is line 2
# This is line 3


# Switch-Case
case "$1" in
  start | up)
    echo "Start server"
    # do something...
    ;;

  *) # default
    echo "Usage: $0 {start|stop|restart|status}"
    ;;
esac
#=> Usage: ./main.sh {start|stop|restart|status}



##################################
# 4. Functions
##################################

# Defining functions
myfunc() {
    # $1	First argument
    echo "hello: $1"
    # $#	Number of arguments
    echo "Number of arguments: $#"
    # $*	All arguments
    echo "All arguments: $*"
    # $@	All arguments, starting from first
    echo "All arguments, starting from first: $@"
}
myfunc "NghiaTC" 2 true
# hello: NghiaTC
# Number of arguments: 3
# All arguments: NghiaTC 2 true
# All arguments, starting from first: NghiaTC 2 true


# Returning values
funcReturn() {
    local myresult='some value'
    echo $myresult
}
result="$(funcReturn)"
echo $result #=> some value


# function check
funcCheck() {
  return 0
}
if funcCheck; then
  echo "success"
else
  echo "failure"
fi
#=> success



##################################
# 5. Conditionals
##################################

# String
[[ -z STRING ]]	# Empty string
[[ -n STRING ]]	# Not empty string
[[ STRING == STRING ]] # Equal
[[ STRING != STRING ]] # Not Equal

if [[ -z "$string" ]]; then
  echo "String is empty"
elif [[ -n "$string" ]]; then
  echo "String is not empty"
fi
#=> String is empty

if [[ "$A" == "$B" ]]; then
  echo "A==B"
fi
#=> A==B


# Combinations
[[ ! EXPR ]]        # Not
[[ X ]] && [[ Y ]]  # And
[[ X ]] || [[ Y ]]  # Or

if [[ X ]] && [[ Y ]]; then
  echo "X&&Y=true"
fi
#=> X&&Y=true


# Comparison
[[ NUM -eq NUM ]] # Equal
[[ NUM -ne NUM ]] # Not equal
[[ NUM -lt NUM ]] # Less than
[[ NUM -le NUM ]] # Less than or equal
[[ NUM -gt NUM ]] # Greater than
[[ NUM -ge NUM ]] # Greater than or equal

if [[ "$A" -eq "$B" ]]; then
  echo "A==B"
fi
#=> A==B


# Regex
if [[ "A" =~ "B" ]]; then
    echo "A contain B"
fi


# Numeric conditions
a=1
b=2
if (( $a < $b )); then
   echo "$a is smaller than $b"
fi
#=> 1 is smaller than 2


# File conditions
[[ -e FILE ]] # Exists
[[ -r FILE ]] # Readable
[[ -h FILE ]] # Symlink
[[ -d FILE ]] # Directory
[[ -w FILE ]] # Writable
[[ -s FILE ]] # Size is > 0 bytes
[[ -f FILE ]] # File
[[ -x FILE ]] # Executable
[[ FILE1 -nt FILE2 ]] # 1 is more recent than 2
[[ FILE1 -ot FILE2 ]] # 2 is more recent than 1
[[ FILE1 -ef FILE2 ]] # Same files

if [[ -e "file.txt" ]]; then
  echo "file exists"
fi
#=> file exists



##################################
# 6. Arrays
##################################

declare -a Fruits
Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"

echo ${Fruits[0]}           # Element #0
#=> Apple
echo ${Fruits[@]}           # All elements, space-separated
#=> Apple Banana Orange
echo ${#Fruits[@]}          # Number of elements
#=> 3
echo ${#Fruits}             # String length of the 1st element
#=> 5
echo ${#Fruits[3]}          # String length of the Nth element
#=> 0
echo ${Fruits[@]:2:1}       # Range (from position 2, length 1)
#=> Orange

# Arrays Operations
Fruits=("${Fruits[@]}" "Watermelon")    # Push
#=> Apple Banana Orange Watermelon
Fruits+=('Cucumber')                    # Also Push
#=> Apple Banana Orange Watermelon Cucumber
Fruits=( ${Fruits[@]/Ap*/} )            # Remove by regex match
#=> Banana Orange Watermelon Cucumber
unset Fruits[2]                         # Remove one item
#=> Banana Orange Cucumber
FruitsDup=("${Fruits[@]}")              # Duplicate
#=> Banana Orange Cucumber
Fruits=("${Fruits[@]}" "${FruitsDup[@]}") # Concatenate
#=> Banana Orange Cucumber Banana Orange Cucumber

# Iteration
Fruits=('Apple' 'Banana' 'Orange')
for i in "${Fruits[@]}"; do
  echo $i
done
# Apple
# Banana
# Orange



##################################
# 7. Dictionaries
##################################

# Defining
declare -A sounds
sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"

echo ${sounds[dog]} # Dog's sound
#=> bark
echo ${sounds[@]}   # All values
#=> bark howl moo tweet
echo ${!sounds[@]}  # All keys
#=> dog wolf cow bird
echo ${#sounds[@]}  # Number of elements
#=> 4
unset sounds[dog]   # Delete dog
#=> wolf cow bird

# Iteration
for val in "${sounds[@]}"; do
  echo $val
done
# howl
# moo
# tweet

for key in "${!sounds[@]}"; do
  echo "Key=$key, Value=${sounds[$key]}"
done
# Key=wolf, Value=howl
# Key=cow, Value=moo
# Key=bird, Value=tweet



##################################
# 8. Miscellaneous
##################################

# Numeric calculations
num=1
echo $((num + 200))     # Add 200 to $num
#=> 201
echo $((RANDOM%=200))   # Random number 0..200

echo "I'm now in $PWD"  # Get current path work directory


## Redirection
: '
python hello.py > output.txt   # stdout to (file)
python hello.py >> output.txt  # stdout to (file), append
python hello.py 2> error.log   # stderr to (file)
python hello.py 2>&1           # stderr to stdout
python hello.py 2>/dev/null    # stderr to (null)
python hello.py &>/dev/null    # stdout and stderr to (null)
python hello.py < foo.txt      # feed foo.txt to stdin for python
'


# Getting options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -V | --version )
    echo $version
    exit
    ;;
  -s | --string )
    shift; string=$1
    ;;
  -f | --flag )
    flag=1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi


# Reading input
: '
echo -n "Proceed? [y/n]: "
read ans
# read -n 1 ans    # Just one character
echo $ans
'



##################################
# 9. History
##################################
: '
# Show history commands
history
# Show 5 history commands
history	5

# Execute last command again
!!
'

```
