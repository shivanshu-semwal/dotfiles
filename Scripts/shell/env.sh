# for cuda
export LD_LIBRARY_PATH=/usr/local/cuda-11.5/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda

# ruby gems
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem
export PATH=$PATH:$HOME/.gem/bin

# nvm
export NVM_DIR="$HOME/.nvm"

# sdman
export SDKMAN_DIR="$HOME/.sdkman"

# gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# java
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# go
export PATH=$PATH:/usr/local/go/bin