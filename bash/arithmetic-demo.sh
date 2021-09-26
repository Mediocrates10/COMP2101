#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

read firstnum
read secondnum
sum=$((firstnum + secondnum))
product=$((firstnum * secondnum))
fproduct=$(awk "BEGIN{printf \"%.2f\", $firstnum*$secondnum}")

cat <<EOF
Sum:  $sum
Product: $product

EOF
