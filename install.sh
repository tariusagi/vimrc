#!/bin/bash
SCRIPT_FULLPATH=$(readlink -f $0)
SCRIPT_DIR="$(dirname $SCRIPT_FULLPATH)"
SCRIPT_NAME=$(basename $SCRIPT_FULLPATH)

# Check dependencies first.
DEP="vim ctags astyle"
for d in $DEP; do
	if [ -z "$(which ${d})" ]; then
		echo $d command not found. Please install it first.
		dep_failed=yes
	fi
done
test -n "$dep_failed" && exit 1

# Process command line options.
while getopts "fhn" opt; do
	case ${opt} in
		f)
			force=yes
			;;
		h)
			echo "Install a Vim\'s configuration for current user."
			echo "Syntax: $SCRIPT_NAME [options]"
			echo "Options:"
			echo "-f      Force installation. A backup will be created."
			echo "-h      Print this usage."
			echo "-n      Don't create backup of existing configuration."
			;;
		n)
			no_bak=yes
			;;
		\?)
			echo "Invalid option \"$OPTARG\""
			exit
			;;
		:) 
			echo "Option \"$OPTARG\" requires an argument."
			exit
			;;
	esac
done

if [ -z "$force" ]; then
	if [ -d ~/.vim ] || [ -L ~/.astylerc ] || [ -L ~/.ctags ]; then
		echo ERROR: Configuration existed. Use \"-f\" to force installing.
		exit 2
	fi
fi

# Create backups if needed.
if [ -z "$no_bak" ]; then
	vim_bak=~/.vimbak
	astylerc_bak=~/.astylerc.bak
	ctags_bak=~/.ctags.bak

	if [ -d ~/.vim ]; then
		if [ -d "$vim_bak" ]; then
			echo $vim_bak exist. Please move it somewhere first.
			exit 3
		else
			echo Backing up existing ~/.vim to ~/.vimbak ...
			mv ~/.vim $vim_bak
		fi
	fi

	if [ -L ~/.astylerc ]; then
		if [ -L "$astylerc_bak" ]; then
			echo $astylerc_bak exist. Please move it somewhere first.
			exit 1
		else	
			echo Backing up existing ~/.astylerc to $astylerc_bak ...
			mv ~/.astylerc $astylerc_bak
		fi
	fi

	if [ -L ~/.ctags ]; then
		if [ -L "$ctags_bak" ]; then
			echo $ctags_bak exist. Please move it somewhere first.
			exit 1
		else
			echo Backing up existing ~/.ctags to $ctags_bak ...
			mv ~/.ctags $ctags_bak
		fi
	fi
fi

# Now install.
echo Installing...
test -d ~/.vim || mkdir ~/.vim
cd $SCRIPT_DIR
cp -fr astylerc bin colors compiler ctags doc plugin syntax vimrc ~/.vim/
ln -fs ~/.vim/astylerc ~/.astylerc
ln -fs ~/.vim/ctags ~/.ctags
echo Vim settings were installed at ~/.vim. Please open Vim and run this command to update Vim\'s tags:
echo :helptags ~/.vim/doc
echo Done.
