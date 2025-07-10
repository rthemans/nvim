# nvim
my nvim setup.

# Tasks list
- [x] push the current setup in here
- [x] setup colorful-menu for blink.cmp: (colorful-menu)[https://github.com/xzbdmw/colorful-menu.nvim]
- [x] setup (lsp_signature)[https://github.com/ray-x/lsp_signature.nvim]
- [ ] setup extended capabilities for the jdtls server through nvim.jdtls
- [ ] setup codeLens and figure out what it does exactly
- [ ] setup surround support with (nvim-surround)[https://github.com/kylechui/nvim-surround]
- [ ] check more stuff from (awesome-neovim)[https://github.com/rockerBOO/awesome-neovim]

# Decisions
## No plugin manager
We don't want to use plugin managers so we don't need an internet connection and we get the knowledge of understanding what is happening
In this repo, I'll setup git submodules but you can do it manually as well.

## Highlights - Treesitter
This seems an obvious choice, it is again a bit of a default as I'm not really aware of alternatives but that just works.
Still, I had a bit to work things out as TSUpdate won't work on the workstation. So I had to build the parser "manually".

## nvim-jdtls
I tried lspconfig and the builtin lsp from nvim 0.10 but both fail a bit short compare to nvim-jdtls.
If/When I use nvim 0.11, I'll give another try to the builtin as it seems to have been improved.

## Completion - Blink.cmp
I'm using Blink.cmp. I've tried nvim.cmp but it was a bit too slow. I still need to properly get my hands on blink but it seems to be a better alternative.
Improvements:
- use the rust implementation -> download the prebuilt and set it up
- add the colorful-menu so treesitter can be used

## Telescope
I went a bit on Default there but I'll have a look at alternatives. Still a good idea to test things out.
I really appreciate the select-ui extension so it is a bit better. But something feels off with it.
Either there is something I should do to enhance or alternatives are better for me.

## Spider
I've been so use to move by camelCase that it was a must have for me. I'll have to find a way to move to the end of "vim words" as it is quite usefull in a lot of situations (deletion, copy, etc.).

## ufo
It felt like it improved the jdtls for some reasons. It works quite well out of the box but I still need to setup the keymaps so it does what I want

# Things to improve
## Code actions
I've already setup telescope as default for the select-ui. I want to add the code action preview plugin as well:
https://github.com/aznhe21/actions-preview.nvim/tree/master

## lsp errors
This is now fixed, the issue came from a project using preview-features in an older version than the one running jdtls.
~~For whatever reason, I don't get the errors I used to have at the beginning, like Symbol not found or that kind of stuff.
I need to investigate this issue as I tend to.
Current status: They work for java 8 projects but not for Java 17. the jdtls logs shows that it doesn't find any errors in the file.
It would seems more like there is some parsing issue going on. Probably better to open an issue ticket on the jdtls repository as the neovim setup seems properly done.~~

## Organize imports
It used to be a big issue, but actually, I can say to jdt.ls what imports to use for instance, use assertj for assertThat, or use junit5 and not junit4.
I'll have a lot to setup so that it doesn't screw up but that seems to be the path.

## Rearrange files
That's a topic that I still need to get my hands on.
There is a built in vim.lsp.buf.format that seems to already be doing some stuff. But I don't think it moves the methods.

## Java debug
I've seen the stuff to set it up in nvim.jdtls but I haven't found the time to work on it either. If needs be I can use either vscode or intellij for the time being.

## Others
This is open so I can add whenever I see something so I can track them :-)
