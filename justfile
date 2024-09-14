# Example Justfile

alias b := build

# New Project (Cookiecutter)
newProject:
    cookiecutter dev/newProjectTemplate --output-dir ~/git

# print host
phost:
    uname -a

# build main
build:
    cc *.c -o main

# test everything
test-all: build
    ./test --all

# run a specific test
test TEST: build
    ./test --test someVar
