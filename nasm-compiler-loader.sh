#!/bin/bash

if [$# -ne 1]
then
    echo "Invalid paramters specified"
    echo "Usage: ./nasm-compiler-loader FILENAME (with extension)"
else
    filename=$1 | cut -f 1 -d '.'
    nasm -f elf $1
    if [$? -eq 0]
    then
        ld -m elf_i386 -s -o $filename $filename.o
        chmod +x $filename
        echo "Do you want to delete the object file? (Y/N)"
        read answer
        if [$answer == Y || $answer == y || $answer == Yes || $answer == yes]
        then
            rm -f $filename.o
            echo "Object file deleted"
            ./$filename
        elif [$answer == N || $answer == n || $answer == No || $answer == no]
        then
            ./$filename
        else
            echo "Wrong option"
            echo "Exit Status: $?"
        echo "Do you want to delete the executable file? (Y/N)"
        read reply
        if [$answer == Y || $answer == y || $answer == Yes || $answer == yes]
        then
            rm -f $filename
            echo "Executable deleted"
        elif [$answer == N || $answer == n || $answer == No || $answer == no]
            echo "Executable not deleted"
        else
            echo "Invalid option specified" 
            echo "Exit Status: $?"
