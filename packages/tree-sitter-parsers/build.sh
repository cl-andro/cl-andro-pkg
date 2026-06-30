CLANDRO_PKG_HOMEPAGE=https://github.com/termux/termux-packages
CLANDRO_PKG_DESCRIPTION="A metapackage that provides commonly used treesitter parsers"
CLANDRO_PKG_LICENSE="Public Domain"
CLANDRO_PKG_MAINTAINER="Joshua Kahn <tom@termux.dev> & @clandro"
CLANDRO_PKG_VERSION=0.26
CLANDRO_PKG_SKIP_SRC_EXTRACT=true
CLANDRO_PKG_PLATFORM_INDEPENDENT=true
CLANDRO_PKG_AUTO_UPDATE=false
CLANDRO_PKG_METAPACKAGE=true

# List of default parsers shipped with Neovim:
# https://github.com/neovim/neovim/blob/master/runtime/doc/treesitter.txt
# e.g. Neovim's `:h treesitter-parsers` help tag
CLANDRO_PKG_DEPENDS="tree-sitter-c, tree-sitter-lua, tree-sitter-markdown, tree-sitter-query, tree-sitter-vimdoc, tree-sitter-vim"

# Installed by default but considered optional to the metapackage.
CLANDRO_PKG_RECOMMENDS="tree-sitter-bash, tree-sitter-css, tree-sitter-go, tree-sitter-html, tree-sitter-latex, tree-sitter-java, tree-sitter-javascript, tree-sitter-json, tree-sitter-python, tree-sitter-regex, tree-sitter-rust, tree-sitter-sql, tree-sitter-toml, tree-sitter-xml, tree-sitter-yaml"
