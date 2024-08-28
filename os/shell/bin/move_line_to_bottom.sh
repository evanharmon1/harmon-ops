#!/bin/sh

#==============================================================================
#                       move_line_to_bottom
#==============================================================================
# Author: Evan Harmon
# Moves a given line of text from its location in a given file to the bottom of that file.
# Looks like sed doesn't like ~/ paths so use full path - /Users/evan/.zshrc
# Can use this in a loop to move multiple lines.
# Strings need to be enclosed with single quotes.
# Uses gsed instead of sed on macOS in order to work better with symlinks
# Example (to move fig zsh code to end of .zshrc where it needs to be):
# ./move_line_to_bottom.sh '[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"' "/Users/evan/.zshrc"

function move() {
    line="$1"
    file_location="$2"
    # sed with @ delimiter so I don't need to escape the `/`s
    # I needed to \escape the delimiter in this case in order to start using it - \@
    gsed -i'.bak' --follow-symlinks -e "\@$line@d" "$file_location"
    echo "$1" >> "$2"
    echo "Moved '$line' to bottom of '$file_location'"
}

# Parse CLI input
if [ $# -eq 0 ]; then
    echo "move_line_to_bottom 'single-line string' 'path to file'"
    exit 0
elif [[ $2 == "help" || $2 == "--help" || $2 == "-h" ]]; then
    echo "move_line_to_bottom 'single-line string' 'path to file'"
    exit 0
else
    move "$1" "$2"
fi
