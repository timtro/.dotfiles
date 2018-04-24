
# Colors for GNU commandline tools

## ls 
#-------------------------------------------------------------------------------

export LS_COLORS='di=1;94:fi=0:ln=3;96:or=1;3;91:mi=1;101:ex=92:*.pdf=31:*.tgz=34:*.zip=34'

# Items separated by `:` and properties separated by `;`.
# di : directory
# fi : file
# ln : symbolic link
# pi : fifo file
# so : socket file
# bd : block (buffered) special file
# cd : character (unbuffered) special file
# or : symbolic link pointing to a non-existent file (orphan)
# mi : non-existent file pointed to by a symbolic link (visible when you type ls -l)
# ex : file which is executable (ie. has 'x' set in permissions).
#
# Run `terminal-colors -o` to see available properties. To install
# terminal-colors, run `pip3 install terminal-colors`.
