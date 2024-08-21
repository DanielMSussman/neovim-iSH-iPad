I've been switching over to using Neovim 

# Getting neovim v0.10 up and running on an ipad


After gluing together solutions to different problems from various threads, an up-to-date version of neovim working within the iSH app on an ipad seems basically functional. Some of the packages are (not surprisingly) slow, and not everything works perfectly, but it's pretty good!

System and software:

> iPad Pro (3rd gen)
> iPadOS 17.5.1
> iSH 1.3.2 (Build 494)

## Basic Neovim Installation instructions

### initial installation of stuff in ish:

    $ apk update
    $ apk upgrade
    $ echo https://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories
    $ echo https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
    $ apk update
    $ apk upgrade
    $ apk add git openssh neovim
    $ apk add build-base cmake automake autoconf libtool pkgconf coreutils curl unzip gettext-tiny-dev tree-sitter tree-sitter-lua wget gzip bash

Some of these last apk adds might not be needed, and the git clone is almost certainly not (see comment on lazy below)

## Initialization, package management, and packages

As on other unix systems, init.lua files should be put in .config/nvim (found via an :echo stdpath("config") command

### Lazy 

The lazy package manager seems to work quite well. The default bootloader should work fine, but be careful of the importance of capitalization -- unlike some other systems, require("Lazy") will fail while require("lazy") will succeed. While discovering all of this I used the above git clone from the command line, but this probably isn't necessary.

I've tested a small number of the plugins that I use the most. Here are some notes:


## transfer keymaps,  etc

### packages that work out-of-the-box

- colorschemes in general
- lualine
- conform
- nvim-cmp (and dependencies...having the buffer (or cmp-omni, or probably any source!) as a source definitely slows down nvim noticeably, though!)
- neo-tree
- which-key 
- mini clue & notify
- obsidian
- pomodoro

### packages that need some help?

#### luasnip

On the ish command line:

    $ apk add make python3 lua5.1-dev luarocks5.1

    $ luarocks-5.1 install jsregexp

 ...Afterwards, luasnip was happy. The add make and python3 are probably not needed, using lua5.1-dev and luarocks5.1 to install jsregexp is really what did the trick.

#### nvim-treesitter

On the ish command line, one needs to do this for nvim-treesitter to do its thing:

    $ apk add gcc libc-dev


#### telescope 

Telescopes Find Files works out of the box, but live grep does not.

An attempt at 

    $ apk add ripgrep
    $ apk add fd

doesn't work: both ripgrep and fd are found, but the problem is that ripgrep doesn't seem to work in iSH (e.g., if you run rg from the command line there is an illegal instruction error thrown). Thus, if you try to live grep in nvim, no results are displayed). 

    local telescope=require("telescope")
        --set up telescope to use grep instead of ripgrep
        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                        "grep",
                        "-n", "-R", "-E", "-i", "-s","-b","-I",
                        },
            },
        })

#### vimtex

Install an underlying latexmk, via

    $ apk add texlive

There are two additional quirks:

1. It should not surprise you that launching a pdf viewer is not going to work (or at least, not easily enough for me to want to figure it out). Make sure in your configuration of vimtex you set 

        vim.g.vimtex_view_enabled = 0

2. When you open any file with a .tex ending it will seem like iSH is frozen, and nothing will appear. Press the ENTER key, and after a second everything will work as expected. (Or not?)


### packages that seem not to work

#### LSPs 

Option 1:
mason, mason-lspconfig, and nvim-lspconfig... not sure how to get this running yet. LSPs can, indeed, be installed by mason. First, on the iSH command line:

    $ apk add gcompat

Then, in nvim, install an LSP with 

    :MasonInstall --target=linux_x64_gnu lspName

For instance, one could replace lspName with lua-language-server. This allows an lsp to be installed (and it correctly appears in the ./local/share/nvim/mason/...) location, but iSH seems to be unable to actually launch any of these LSPs. As such, this option is discouraged

Option 2:
Does downloading binaries work? Does compiling from scratch work? For instance, when I tested the above with lua-language-server, mason installed it, but the executable would crash (cannot execute binary file: exec format error). Let's try building lua_ls from source:

    $ apk add libstdc++
    $ git clone https://github.com/LuaLS/lua-language-server
    $ cd lua-language-server
    $ ./make.sh

So far, no luck... perhaps with more tinkering, but using both this route and the "wget binaries and try to use them" route things fail.

Option 3:
There are some LSPs for which there is a package that can be grabbed, and they may or may not work. I tested lua-language-server, texlab, and clangd -- of those clangd functioned! Here was the command:

    $ apk add --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ clang-extra-tools

With this method, texlab and lua_ls failed. As Meatloaf almost said, one out of three ain't bad.

## Getting a different font on iSH, (e.g., to get a nerd font working)

Perhaps you want your a different (nerd) font rather than the defaults of Menlo and Courier New provided by iSH. It's slightly fussier than normal, but not too hard. The following was tested with JetBrainsMonoNL Nerd Font Mono

- Outside of ish, download the Fontcase app from the app store
- Directly download, e.g., a .tff font file from somewhere (I think it must be a mono font). Start the Fontcase app and follow its instructions to install the font.

The following is for old versions of iSH:
- The ish settings menu will now let you change to that font. BUT: if you do everything will look terrible! There will be a weird offset between the location of your cursor and the place the cursor is visualized, lines will seem shifted, etc. So, instead:
- In ish, edit the /proc/ish/defaults/font_family file. It will contain a single line with a font in quotation marks (probably "Menlo"). Change this to the font you installed. If you don't do this there will be a cursor offset (https://github.com/ish-app/ish/issues/1485), and everything will look terrible. 

