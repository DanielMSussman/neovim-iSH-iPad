# LazyVim

If you just want to get running with LazyVim, this is for you:

## Initial installation of stuff in iSH:

To start things off we'll follow the [advice here](https://www.reddit.com/r/neovim/comments/193yq8g/comment/l5hywg8/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button) and  add the edge/main and edge/community repositories to draw packages from:

    $ apk update
    $ apk upgrade
    $ echo https://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories
    $ echo https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories
    $ apk update
    $ apk upgrade

This is already enough to do:

    $ apk add git openssh neovim

## Preparation for cloning LazyVim

Let's preemptively add packages that the default LazyVim distribution needs:

    $ apk add curl gzip wget bash gcc libc-dev fd ripgrep unzip grep

## LazyVim

Following the [instructions]():

    $ git clone https://github.com/LazyVim/starter ~/.config/nvim
    $ rm -rf ~/.config/nvim/.git
    $ nvim

Then, sit back and wait. It will take a bit of time for all of the plugins to be downloaded and installed, and treesitter will take a while installing all of the parsers that LazyVim sets up by default.

Telescope seems a bit touchy, so you'll have to work with the LazyVim configuration to get (in particular) the find files functionality working. I also suggest getting rid of the items in the mason / `ensure_installed` section; these probably won't work and every time you open neovim you'll get an error that Mason can't install stuff properly.

Other than that, though, you're good to go. The main caveats are (1) do not expect LSPs to just work out of the box (see the main [Readme](/README.md)), and (2) expect performance to be fairly laggy. You'll almost certainly want to turn off some of the plugins / features to make nvim a bit snappier.
