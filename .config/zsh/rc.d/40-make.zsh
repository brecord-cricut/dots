if [[ $OSTYPE == darwin* ]]; then
  export MAKEFLAGS="-j$(sysctl -n hw.ncpu)"
  export CMAKE_BUILD_PARALLEL_LEVEL=$(sysctl -n hw.ncpu)
fi

if [[ $OSTYPE == linux* ]]; then
  export MAKEFLAGS="-j$(nproc)"
  export CMAKE_BUILD_PARALLEL_LEVEL=$(nproc)
fi
