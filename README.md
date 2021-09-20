# Introduction
My Vim plugins and settings, intended for people who use Vim for programming and editing. It includes:
- The *desert* color scheme. This scheme works best with terminal console such as PuTTY, which I frequently use.
- Plugins:
	- [EnhancedCommentify](https://www.vim.org/scripts/script.php?script_id=23)
	- [taglist](https://www.vim.org/scripts/script.php?script_id=273)
	- [vimExplorer](https://www.vim.org/scripts/script.php?script_id=1950)
- Language syntax:
	- [Pawn](https://www.compuphase.com/pawn/pawn.htm). This is a language I used to work with a lot.
- Code beautifier:
  - [Astyle](http://astyle.sourceforge.net/).

And various customizations that I found useful while working with Vim.

# System requirements
This project requires:
- A Linux/Unix based OSes or Windows.
- [Git](https://git-scm.com).
- [Vim](https://www.vim.org).
- [Exuberant  ctags](http://ctags.sourceforge.net).
- [Astyle](http://astyle.sourceforge.net/).

# Installation
## On Unix/Linux

Follow these steps:

1. Install git, vim, ctags, and astyle if they're not already installed.
2. Clone this project into your home directory (~/):

`git clone https://github.com/tariusagi/vimrc.git ~/.vim`

3. Link ctags configuration file:

`ln -fs ~/.vim/ctags ~/.ctags`

4. Run Vim and execute this command in Vim `:helptags $VIMRUNTIME/doc` to generate tags for new plugins.

And done.

## On Windows

On Windows, install git and GVim (GUI implementation of Vim, from Vim official site), then follows these steps:

1. Install git, GVim if they're not already installed.

2. Clone this project somewhere in your computer:

   `git clone https://github.com/tariusagi/vimrc.git c:\vimrc`

3. Create a directory named *vimfiles* in your *%USERPROFILE%* directory (just open Explorer and enter *%USERPROFILE%* in its address bar).

4. Copy all files and directories in cloned *vimrc* directory, except *.git/*, to *%USERPROFILE%\vimfiles*.

5. Download **[Exuberant ctags for Windows](http://ctags.sourceforge.net/)** and extract *ctags.exe* to *%USERPROFILE%\vimfiles\bin*

6. Download **[AStyle for Windows](http://astyle.sourceforge.net/)** and extract *Astyle.exe* to *%USERPROFILE%\vimfiles\bin*

7. Move *ctags* file from *%USERPROFILE%\vimfiles* to *%USERPROFILE%* and rename it to *ctags.cnf*.

8. Run GVim and execute this command in GVim `:helptags $VIMRUNTIME/doc` to generate tags for new plugins.

And done.

# Usage
Plugins' usages can be found from their respective web (use the links above).

In this section I only show some common usages that I frequently use:

## Function header

Type your function name, press Esc to escape to Normal mode, quickly press `\fh` or type `:Fh`, Vim will insert a standard function header from your cursor down, and start insert mode at the function's description, ready for you to type in. Example:

```c
/* -----------------------------------------------------------------------------
NAME: my_func
AUTHOR: Phuong Vu (tariusagi@gmail.com)
INPUT: 
OUTPUT: 
DESCRIPTION:

----------------------------------------------------------------------------- */
```

After that, you can add more content to that header, such as function name, input and out parameters, changes history.

You can customize this function header in `~/.vimrc` (Linux/Unix) or `%USERPROFILE%\vimfiles\vimrc` (Windows), look for line with `UziAddFunctionHeader`.

## Substitute words

This feature is super convenient! I usually have to change the name of my functions, class name, variables... and this helps a lot.

To substitute all occurrences of the word under the cursor as source for current buffer, run this command:
`:Sw new_word`

To substitute all occurrences of the old word with the new one for current buffer, run this command:
`:Sw old_word new_word`

If you type `*` as the last argument, then this function will affect all opening buffers, example:
`:Sw new_word *`
`:Sw old_word new_word *`

## Format current source code using AStyle

Run this command:

`:fs`

And the current buffer will be formatted by astyle. Vim will inform you of this action with this message:

`INFO: current buffer has just been formatted with AStyle`

Note that this command modify the current buffer but not saving it yet. To keep the modification, you must save the buffer yourself.

## Quickly insert current date and time

Press `<Leader>t` in Insert mode to insert current date and time in "YYYY-MM-DD hh:mm" format, for example:

```
2021-09-20 12:53
```

*To be continued*.
