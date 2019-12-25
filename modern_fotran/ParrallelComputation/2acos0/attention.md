### Present situation
```sh
$ brew install opencoarrays
Updating Homebrew...
Warning: opencoarrays 2.3.1_1 is already installed and up-to-date
To reinstall 2.3.1_1, run `brew reinstall opencoarrays`
$ make
gfortran -o serial serial.f90 -Wall -O3
gfortran -o omp omp.f90 -fopenmp -Wall -O3
mpifort -o mpi mpi.f90 -Wall -O3
mpifort -o coarray coarray.f90 -lcaf_mpi -fcoarray=lib -Wall -O3
coarray.f90:9:12:

         use opencoarrays, only: co_sum
            1
Fatal Error: Can't open module file 'opencoarrays.mod' for reading at (1): No such file or directory
compilation terminated.
make: *** [all] Error 1
```

> Users must make sure that openmpi is correctly installed and configured on their system. After confirming that openmpi is correctly installed and configures, make sure that the shell's PATH environment variable includes the path to your openmpi installation before compiling.


`error stop` was introduced in Fortran 2008 together with coarrays and is useful for stopping all running images (processes) while `stop` just stops execution of the current image.

Use `caf` (OpenCoarrays Coarray Fortran Compiler Wrapper) to replace `gfortran`, problem solved on MacOS on which `opencoarray` is installed via `homebrew`.

## Fix the problem
### Preparation
* Docker image of Debian

```sh
2019-04-16 09:26:55 ⌚  b473564baa16 in /home/Playground/Fortran_Takeoff/2acos0
± |master ✓| → cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
NAME="Debian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"

2019-04-16 09:31:27 ⌚  b473564baa16 in /home/Playground/Fortran_Takeoff/2acos0
± |master ✓| → gfortran -v
Using built-in specs.
COLLECT_GCC=gfortran
COLLECT_LTO_WRAPPER=/usr/local/libexec/gcc/x86_64-linux-gnu/8.2.0/lto-wrapper
Target: x86_64-linux-gnu
Configured with: /usr/src/gcc/configure --build=x86_64-linux-gnu --disable-multilib --enable-languages=c,c++,fortran,go
Thread model: posix
gcc version 8.2.0 (GCC)
```

* MacOS

```sh
$ ls /usr/local/Cellar
adwaita-icon-theme/        gdb/                       gtkmm3/                    libevent/                  mpfr/                      pixman/
atk/                       gdbm/                      harfbuzz/                  libffi/                    node/                      pkg-config/
atkmm/                     gdk-pixbuf/                heroku/                    libheif/                   nspr/                      poppler/
boost/                     gettext/                   heroku-node/               libidn2/                   nss/                       postgresql/
cadabra2/                  ghostscript/               hicolor-icon-theme/        libmpc/                    open-mpi/                  python/
cairo/                     git/                       icu4c/                     libomp/                    opencoarrays/              qt/
cairomm/                   glib/                      ilmbase/                   libpng/                    openexr/                   readline/
cmake/                     glibmm/                    imagemagick/               librsvg/                   openjpeg/                  sqlite/
fontconfig/                gmp/                       isl/                       libsigc++/                 openssl/                   webp/
freetype/                  graphite2/                 jpeg/                      libtiff/                   pango/                     wget/
fribidi/                   graphviz/                  libcroco/                  libtool/                   pangomm/                   x265/
gcc/                       gsettings-desktop-schemas/ libde265/                  libunistring/              pcre/                      xz/
gd/                        gtk+3/                     libepoxy/                  little-cms2/               pcre2/
$ mpifort -v
Using built-in specs.
COLLECT_GCC=/usr/local/bin/gfortran
COLLECT_LTO_WRAPPER=/usr/local/Cellar/gcc/8.2.0/libexec/gcc/x86_64-apple-darwin18.0.0/8.2.0/lto-wrapper
Target: x86_64-apple-darwin18.0.0
Configured with: ../configure --build=x86_64-apple-darwin18.0.0 --prefix=/usr/local/Cellar/gcc/8.2.0 --libdir=/usr/local/Cellar/gcc/8.2.0/lib/gcc/8 --enable-languages=c,c++,objc,obj-c++,fortran --program-suffix=-8 --with-gmp=/usr/local/opt/gmp --with-mpfr=/usr/local/opt/mpfr --with-mpc=/usr/local/opt/libmpc --with-isl=/usr/local/opt/isl --with-system-zlib --enable-checking=release --with-pkgversion='Homebrew GCC 8.2.0' --with-bugurl=https://github.com/Homebrew/homebrew-core/issues --disable-nls --disable-multilib --with-native-system-header-dir=/usr/include --with-sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
Thread model: posix
gcc version 8.2.0 (Homebrew GCC 8.2.0)
```

### OpenCoarrays
Building OpenCoarrays requires

* [ ] An MPI implementation (default: MPICH).
* [x] CMake.
* [x] A Fortran compiler (default: GCC).
* [ ] Optional: An OpenSHMEM implementation.
