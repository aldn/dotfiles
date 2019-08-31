#!/bin/bash

function div_and_floor
{
   echo $(($1/$2))
}

# same as div_and_floor however returns 0 only if first
# operand is 0, returns 1 if first operand is less or equal to second
# and >1 if first operand is greater than second
function div_and_floor2
{
   if [ $1 -eq 0 ]
   then
      echo 0
   else
      let r=$1/$2
      echo $(($r>1?$r:1))
   fi
}

function div_and_ceil
{
   let r=($1+$2-1)/$2
   echo $r
}

function div_and_round
{
   let half_denom=$2/2
   let mod=$1%$2
   if [ $mod -lt $half_denom ]
   then
      let r=$1/$2
   else
      let r=$1/$2+1
   fi
   echo $r
}


while read line
do
   percents=$line
   if [ $percents -ge 0 ] &&  [ $percents -le 100 ]
   then
      max_bars=10
      #ceil
      #let nbars=($percents+$max_bars-1)/$max_bars
      #floor
      let nbars=$(div_and_floor $percents $max_bars)

      #echo $nbars
      #echo -n ' '
      echo -n "["
      for ((i=0; i < $nbars; ++i ))
      do
         echo -n "|"
      done
      for ((i=0; i < $max_bars - $nbars; ++i ))
      do
         echo -n "="
      done
      echo "]"
   else
      echo $line
   fi
done
#
# test
#
#n=0
#while [ $n -le 100 ]
#do
   #let r=$(div_and_floor $n 10)
   #echo $n $r
   #let n=$n+1
#done
