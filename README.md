# Introduction
My Vim plugins and settings, intended for people who use Vim for proramming and editing. It includes:
- *Desert* color scheme. This scheme works best with terminal console such as PuTTY, which I frequently use.
- Plugins:
	- EnhancedCommentify
	- taglist
	- vimExplorer
- Uncommon syntax:
	- Pawn. This is a language I used to work with a lot.

And there're various settings I put in the vimrc file, which I found necessary.

# System requirements
This project requires:
- A Linux/Unix based OSes.
- Vim (https://www.vim.org).
- Exuberant ctags (http://ctags.sourceforge.net).
- Git (https://git-scm.com).

# Installation
## On Unix/Linux

To use this project to your Vim configuration, follow these steps:

1. Install Vim, ctags, and git if they're not already innstalled.
2. Clone this project into your home directory (~/):

`git clone https://github.com/tariusagi/vimrc.git ~/.vim`

3. Link ctags configuration file:

`ln -fs ~/.vim/ctags ~/.ctags`

4. Run Vim and execute this command in Vim `:helptags $VIMRUNTIME/doc` to generate tags for new plugins.

And done.

## On Windows

On Windows, install git and GVim, then follows these steps:

1. Clone this project somewhere in your computer:

   `git clone https://github.com/tariusagi/vimrc.git c:\vimrc`

2. Create a directory named *vimfiles* in your *%USERPROFILE%* directory (just open Explorer and enter *%USERPROFILE%* in its address bar).

3. Copy all files and directories in cloned *vimrc* directory, except *.git/*, to *%USERPROFILE%\vimfiles*.

4. Download **Exuberant ctags for Windows** from http://ctags.sourceforge.net/ and extract *ctags.exe* to *%USERPROFILE%\vimfiles\bin*

5. Move *ctags* file from *%USERPROFILE%\vimfiles* to *%USERPROFILE%* and rename it to *ctags.cnf*.

6. Run GVim and execute this command in GVim `:helptags $VIMRUNTIME/doc` to generate tags for new plugins.

And done.

# Usage
*To be updated*.
