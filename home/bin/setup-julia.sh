#!/bin/bash
# setup the Language Server Protocol for Julia
# and init the current working directory
# Usage: setup-julia.sh
echo "Installing and updating Julia Language Server"
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'
echo "Initializing the current working directory"
julia --project=. -e 'using Pkg; Pkg.instantiate()'
julia --project=. -e 'using Pkg; Pkg.precompile()'
