# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "Objconv"
version = v"2.54.0"

# Collection of sources required to build objconv
sources = [
    GitSource("https://github.com/staticfloat/objconv",
              "c68e441d2b93074b01ea193cb17e944ed751750f")
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/objconv*/

mkdir -p "${bindir}"
${CXX} ${CPPFLAGS} ${CXXFLAGS} ${LDFLAGS} -O2 -o "${bindir}/objconv${exeext}" src/*.cpp

install_license /usr/share/licenses/GPL-3.0+
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products = [
    ExecutableProduct("objconv", :objconv),
]

# Dependencies that must be installed before this package can be built
dependencies = Dependency[
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; julia_compat="1.6")
