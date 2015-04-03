#!/bin/bash
declare -a flist

if [ $# -eq 0 ]; then
  echo "usage: $0 <foto>"
  exit 1
fi

i=0

# slurp all the images file
for fn in "$@"
do
  # echo ${fn}
  flist[${#flist[@]}]=${fn}
done

# read the xy value
stringValue=$(cat ./x_val.txt |tr "\n" " ")
yval=($stringValue)
stringValue=$(cat ./y_val.txt |tr "\n" " ")
xval=($stringValue)

# start the job...
convert \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none  -rotate $((RANDOM%40+1)) -repage ${xval[0]}${yval[0]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate -$((RANDOM%40+1)) -repage ${xval[1]}${yval[1]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[2]}${yval[2]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[3]}${yval[3]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate -$((RANDOM%40+1)) -repage ${xval[4]}${yval[4]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none  -rotate $((RANDOM%40+1)) -repage ${xval[5]}${yval[5]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate -$((RANDOM%40+1)) -repage ${xval[6]}${yval[6]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[7]}${yval[7]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[8]}${yval[8]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[9]}${yval[9]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none  -rotate $((RANDOM%40+1)) -repage ${xval[10]}${yval[10]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate -$((RANDOM%40+1)) -repage ${xval[11]}${yval[11]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[12]}${yval[12]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[13]}${yval[13]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate -$((RANDOM%40+1)) -repage ${xval[14]}${yval[14]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none  -rotate $((RANDOM%40+1)) -repage ${xval[15]}${yval[15]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate -$((RANDOM%40+1)) -repage ${xval[16]}${yval[16]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[17]}${yval[17]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[18]}${yval[18]} \) \
    \( ${flist[$((RANDOM%${#flist[@]}+1))]} -resize x240 -frame 10x10+3+3 \
          -background none -rotate $((RANDOM%40+1)) -repage ${xval[19]}${yval[19]} \) \
    \
    \( -clone 0--1 \
       -set page '+%[fx:page.x-4*t]+%[fx:page.y-7*t]' -layers merge \) \
    -layers trim-bounds +delete \
    \
    \( -clone 0--1 \
       -set page '+%[fx:page.x-4*t]+%[fx:page.y-7*t]' \
            -dispose None -coalesce \
       -set page '+%[fx:page.x+4*t]+%[fx:page.y+7*t]' \
            -background black -shadow 70x2+4+7 \
       xc:none +insert null: +insert +insert xc:none \) \
    -layers trim-bounds -compose Atop -layers composite \
    \
    -fuzz 10% -trim \
    -reverse -background none -compose Over -layers merge +repage \
    /tmp/images/foto_intro.png

# first resize to set the heigh at 768
mogrify -resize 1366x768 /tmp/images/foto_intro.png
# then the montage on a gray frame
mogrify  -background "#cccccc" -gravity center -extent 1366x768 /tmp/images/foto_intro.png

