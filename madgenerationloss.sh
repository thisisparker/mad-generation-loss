#!/bin/bash

# licensed GPLv3

bitrate=64

function pass_clip()  # input_path, output_path, clip_path
# faster but choppy
# also gets quieter with each pass, can't really norm it either
{
    sox "$1" "$3" trim 0 1
    sox "$1" -C $bitrate "$2" trim 1
}

function pass()  # input_path, output_path
{
    sox --norm "$1" -C $bitrate "$2"
}

function fast_encode()
{
    pass_clip "$1" "1-tmp.mp3" "1-tmp.wav"
    
    for i in $(seq 2 $duration); do
        echo -n "."
        pass_clip "$((i-1))-tmp.mp3" "$i-tmp.mp3" "$i-tmp.wav"
    done
    
    echo -e "\nmixing..."
}

function quality_encode()
{
    pass "$1" "1-tmp.mp3"
    
    for i in $(seq 2 $duration); do
        echo -n "."
        pass "$((i-1))-tmp.mp3" "$i-tmp.mp3"
    done
    
    echo -e "\nmixing..."
    for i in $(seq 1 $duration); do
        sox "$i-tmp.mp3" "$i-tmp.wav" trim $((i-1)) 1
    done
}

function fast_mix()
{
    sox $(ls *-tmp.wav | sort -n) final.wav
}

function quality_mix()
{
    floor=$(printf '%.f' $duration)
    floor=$((floor-1))
    cp "$floor-tmp.wav" final.wav
    for i in $(seq $((floor-1)) -1 1); do
        sox --combine concatenate "$i-tmp.wav" final.wav final-tmp.wav splice 1
        mv final-tmp.wav final.wav
    done
}

duration=$(soxi -D "$1")
echo -n "multilating"
#fast_encode "$1"
quality_encode "$1"
#fast_mix
quality_mix

echo "cleanup"
rm *-tmp.mp3
rm *-tmp.wav

