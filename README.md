# nvim
my nvim setup.

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
It felt like it improved the jdtls for some reasons

# Things to improve
## Code actions
I've already setup telescope as default for the select-ui. I want to add the code action preview plugin as well:
https://github.com/aznhe21/actions-preview.nvim/tree/master

## lsp errors
For whatever reason, I don't get the errors I used to have at the beginning, like Symbol not found or that kind of stuff.
I need to investigate this issue as I tend to

## Organize imports
It used to be a big issue, but actually, I can say to jdt.ls what imports to use for instance, use assertj for assertThat, or use junit5 and not junit4.
I'll have a lot to setup so that it doesn't screw up but that seems to be the path

## Rearrange files
That's a topic that I still need to get my hands on

## Java debug
I've seen the stuff to set it up in nvim.jdtls but I haven't found the time to work on it either. If needs be I can use either vscode or intellij for the time being.

## Others
This is open so I can add whenever I see something so I can track them :-)
