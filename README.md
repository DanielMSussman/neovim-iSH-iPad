**Goal:** Get neovim running on the app-store version of iSH shell on an iPad (rather than relying on ssh/connecting to a different device actually running neovim). Actually, just neovim is straightforward -- all of the rough edges are in getting plugins, LSPs, nerd fonts, and whatnot up an running.

**Need:** The question of how to get an iPad/iSH/neovim setup running has been asked before, and a lot of the answers suggest that X is impossible. As far as I can tell most things -- or, at least, most of the things that I want to use -- can be made to work. The problem is that the solutions are scattered across different forums / issue threads / etc. It would be nice to have a place with all of these solutions in the same place. Related: additions, comments, and pull requests welcome!

**Personal motivation:** I've recently realized (after years of having part of my job involve coding in vim on servers) that I think editing text vim is just... Fun. I'm switching over to using neovim for not just the coding but also the large amount of markdown and LaTeX writing and editing I do, but that requires that everything works across platforms. Windows, MacOS, Linux -- all great. But what about on an iPad? Even just with the folio keyboard their pretty convenient for travel, and it would be nice to do some simple writing and coding while traveling light.

**Caveat:** The steps below are going to involve using the Alpine edge repositories (and in some cases, testing) repositories. Breaking (or in some cases, improving!) changes to the steps below almost certainly can and will happen. I also suspect that if/when iSH updates to a newer version of Alpine Linux things will get easier.

**Structure of the rest of the document:** I'll walk through the steps to get neovim 0.10.0 running on iSH shell, together with the lazy plugin manager. I'll list a handful of plugins that work out-of-the-box without much comment, and then I'll step through the process of getting some of the stickier things working. At the end, for those interested, I'll comment on installing and using nerd fonts.


# Getting Neovim v0.10 running on an iPad

**System and software tested on:**

> iPad Pro (3rd gen)
>
> iPadOS 17.5.1
>
> iSH 1.3.2 (Build 494)

After gluing together solutions to different problems from various threads, an up-to-date version of neovim working within the iSH app on an ipad seems basically functional. Some of the packages are (not surprisingly) slow, and not everything works perfectly, but it's pretty good! In addition to this readme, I've included the basic plugin config files -- all pretty vanilla -- for the plugins discussed here.

## Optional: Getting a different font on iSH

That is, perhaps you want a nerd font to play nicely with your statusline, or you just want a better font to look at than the default Menlo and Courier New provided by iSH. This is straightforward to do.

First, download and install the font for your iPad:

1. Outside of ish, download the Fontcase app from the app store
2. Directly download, e.g., a .tff font file from [somewhere](https://github.com/ryanoasis/nerd-fonts). 
3. Start the Fontcase app and follow its instructions to install the font.

From here, I have observed two possible outcomes. The first is that everything works: go to the iSH settings, go to appearance, change the font to the one you installed, and you're done.

The second is that the iSH settings menu will indeed let you change to that font, *but* everything will look terrible (there will be a weird offset between the location of the cursor and the place on screen where the cursor is visualized, various lines on the screen will be shifted around, etc, related to [this issue](https://github.com/ish-app/ish/issues/1485). If this is the case, not to worry: edit the `/proc/ish/defaults/font_family` file. It will contain a single line with a font in quotation marks (probably "Menlo"). Change this to the font you installed, and things should be good.

## Basic Neovim Installation instructions

### Initial installation of stuff in iSH:

To start things off we'll follow the [advice here](https://www.reddit.com/r/neovim/comments/193yq8g/comment/l5hywg8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) and  add the edge/main and edge/community repositories to draw packages from:

    $ apk update
    $ apk upgrade
    $ echo https://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories
    $ echo https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
    $ apk update
    $ apk upgrade

This is already enough to do:

    $ apk add git openssh neovim

We already have git, the ability to generate ssh keys for github, and neovim 0.10.0. Extremely nice. In preparation for installing some packages, let's grab a few more packages:

    $ apk add build-base cmake automake autoconf libtool pkgconf coreutils curl unzip gettext-tiny-dev tree-sitter tree-sitter-lua wget gzip bash

(Some of these apk adds might not be strictly needed (depending on which plugins you want to actually use), but I haven't carefully gone through and sorted out which is needed for what.)

## Initialization, Plugin Management, and Plugins

As on other unix systems, init.lua files should be put in .config/nvim (found via an :echo stdpath("config") command

### Lazy 

The lazy package manager works quite well. The default bootloader should work fine, but be careful of the importance of capitalization -- unlike some other systems where you can be lazy about it, here require("Lazy") will fail while require("lazy") will succeed. The init.lua file in this repo worked fine for me.

### Packages that work out-of-the-box

- `rebelot/kanagawa.nvim` (and colorschemes in general)
- `nvim-lualine/lualine.nvim`
- `tpope/vim-fugitive`
- `lewis6991/gitsigns.nvim`
- `stevearc/conform.nvim` (also `mhartington/formatter.nvim`)
- `nvim-neo-tree/neo-tree.nvim`
- `folke/which-key.nvim`
- `echasnovski/mini.notify`
- `echasnovski/mini.clue`
- `epwalsh/obsidian.nvim`
- `epwalsh/pomo.nvim`
- `hrsh7th/nvim-cmp` (but see note below)

#### nvim-cmp: a performance note

One probably (?) wants completions at some level, and actually `hrsh7th/nvim-cmp` (and dependencies) work out of the box. Let's remember, though, that iSH is an emulator, and using completions is a key plugin where neovim will start to feel sluggish and painful to work with. Snippets work very well (and quickly), but if using cmp-buffer (or cmp-omni, or...) as a source, I *highly* recommend playing with the performance options (keyword_length, debounce,...) so that things stay acceptably snappy.

### Packages that (might) need some help, and how to help them

#### luasnip

We just need a few extra packages. On the iSH command line:

    $ apk add make python3 lua5.1-dev luarocks5.1
    $ luarocks-5.1 install jsregexp

 ...Afterwards, luasnip was happy. The add make and python3 are probably not needed, using lua5.1-dev and luarocks5.1 to install jsregexp is really what did the trick.

#### nvim-treesitter

Again, we just need a few extra packages (in order for treesitter to get and compile what it needs).

    $ apk add gcc libc-dev

Note: If you did a `apk add tar`, treesitter will default to grabbing things with tar and this will probably not work (perhaps related to a missing instruction on iSH). Just `apk del tar`, let treesitter fallback to a different mechanism, and things should work.


#### telescope 

Telescope may or may not be fine, depending on the version of packages you get. One should first try to see if Telescope Find Files works out of the box. If it does, great -- if not, try 

    $ apk add fd

Find files should be good to go. Next, add ripgrep:

    $ apk add ripgrep

During my testing this sometimes worked (i.e., a version of ripgrep was installed that iSH was happy with), but sometimes a version of ripgrep that would trigger an iSH illegal instruction was installed (e.g., if you run rg from the command line there is an illegal instruction error thrown). Just try to live grep something in nvim -- either you'll get results or you won't.

If ripgrep is not working, you can fall back to using grep. First get an updated version of grep by doing 

    $ apk add grep

Then, add [the following](https://www.reddit.com/r/neovim/comments/171i17o/telescope_vimgrep/) to your telescope config (see [telescope.lua](/lua/plugins/telescope.lua) for an example): 

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

(If you're curious, we downloaded an updated version of grep so that we would be able to use the bytecode `-b` flag in the list of vimgrep_arguments).

#### vimtex

You might not care, but for me LaTeX is important, and the vimtex plugin is excellent. First, install an underlying latexmk, via

    $ apk add texlive

This may or may not  go smoothly. iSH might crash every time  you  try to execute this command, typically partway through installing texmf-dist. In that case, you might have some luck doing and `apk fetch texmf-dist`, and the `apk add [fileThatShowsUp]`.

There are two additional quirks:

1. It should not surprise you that launching a pdf viewer is not going to work (or at least, not easily enough for me to want to figure it out). Make sure in your configuration of vimtex you set 

        vim.g.vimtex_view_enabled = 0

failing to do this will cause things to (indefinitely) hang whenever you open a tex file.

2. You *might* find that when you open any .tex file that you are met with a blank screen that seems to hang. This is seemingly related to https://github.com/lervag/vimtex/issues/661 and https://github.com/lervag/vimtex/blob/b344cfa968e4ee9328c79650bed12ca5afda606e/autoload/vimtex/echo.vim#L22. The solution if this happens is to press the return key; after a second everything should appear and be working as expected.


## LSPs

If you just want to do LaTeX you probably don't care *too* much about getting LSPs to work (texlab is nice, but just working with vimtex and cmp-vimtex is excellent). But if you want to do some coding it might be nice to get these going. Here's I've had... limited success. Here's what I've tried so far (with only Option 3 ever working at all... but until I understand this better I figure it's good to leave a trail of what I've actually tried.). For the record, here I'm focusing only on lua_ls, texlab, and clangd -- as we'll see below it might be worthwhile to test more LSPs.

### Option 1: Install LSPs via Mason
LSPs can, indeed, be installed by mason. Following [this clue](https://www.reddit.com/r/neovim/comments/15dr01d/running_lazyvim_starter_on_alpine_docker/), on the iSH command line:

    $ apk add gcompat

Then, in nvim, install an LSP with 

    :MasonInstall --target=linux_x64_gnu lspName

For instance, one could replace lspName with lua-language-server. This indeed allows an lsp to be installed (and it correctly appears in the ./local/share/nvim/mason/...) location, but iSH seems to be unable to actually launch any of these LSPs. For instance, when I tested these just on lua-language-server, mason installed it, but the executable would crash (cannot execute binary file: exec format error). As such, this option is discouraged.

### Option 2: build from source or use pre-existing binaries
Does downloading binaries work? Does compiling from scratch work? Let's try building lua_ls from source:

    $ apk add libstdc++
    $ git clone https://github.com/LuaLS/lua-language-server
    $ cd lua-language-server
    $ ./make.sh

So far, no luck, but I haven't extensively investigated... running the make script is extremely slow, so I didn't play around much. Perhaps with more tinkering , but using both this route and the "wget binaries and try to use them" route things fail.

### Option 3: LSPs from the package manager
There are some LSPs for which there is a package that can be grabbed, and they may or may not work. Following [this hint](https://github.com/LuaLS/lua-language-server/issues/661) I tested lua-language-server, texlab, and clangd. I couldn't even get the lua_ls package to be found, texlab was added but would fail if I tried to run it from the command line.

But clangd worked (and even then played nicely with the already-functioning `cmp-nvim-lsp`)! Here was the command:

    $ apk add --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ clang-extra-tools

As Meatloaf almost said, one out of three ain't bad.
