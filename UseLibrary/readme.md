Take a try to  refer to a library

Install a Library.
* First find the source code of the library.
* Build
  * A KISS tool for automatic building modern Fortran projects.
* Install.
  * Install a library didn't depend on the third party.

Install [FoBiS.py](https://github.com/szaghi/FoBiS.git).(Fortran Building System for poor people.)

>  FoBiS.py is able to build almost automatically complex Fortran projects with cumbersome inter-modules dependency. This removes the necessity to write complex makefile.

* Manual Install

  Since the network speed is poor, I installed it at the same time, the Python installer behaves far better than manual install.
* PyPi Install
  * FoBiS.py can be installed by means of `pip`.

   Does it support `pip3`?

   Yes, it does!
   szaghi also kindly remind you that t you need root permissions if you are not using your `virtualenv` or you are trying to install FoBiS.py into your system space.

   I use `sudo -H pip3 install FoBiS.py`, It went well.  

Install [forbear](https://github.com/szaghi/forbear.git)

* [reference](https://github.com/ComplicatedPhenomenon/Fortran_Takeoff/issues/3)    
  * > Module 'pygooglechart' not found: Gcov graphs disabled
Traceback (most recent call last): ...

    > Pygooglechart I a python module used by FoBiS to generate nice coverage reports.

  [pygooglechart source](https://github.com/gak/pygooglechart)

  [Tip](https://github.com/Fortran-FOSS-Programmers/FOODIE/issues/37)

  ```
  git clone --recursive https://github.com/szaghi/forbear
  ```
  `sudo easy_install3 pygooglechart`
  * Whenever I run `FoBiS.py build`, I get
    ```
    FoBiS.py build
    Traceback (most recent call last):
    File "/usr/local/bin/FoBiS.py", line 4, in <module>
    __import__('pkg_resources').run_script('FoBiS.py==2.2.8', 'FoBiS.py')
    File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 742, in run_script
    self.require(requires)[0].run_script(script_name, ns)
    File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 1510, in run_script
    exec(script_code, namespace, namespace)
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/EGG-INFO/scripts/FoBiS.py", line 21, in <module>
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/fobis/fobis.py", line 45, in main
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/fobis/fobis.py", line 58, in run_fobis
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/fobis/FoBiSConfig.py", line 65, in __init__
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/fobis/Fobos.py", line 76, in __init__
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/fobis/Fobos.py", line 238, in _set_cliargs
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/fobis/Fobos.py", line 176, in _check_local_variables
    File "/usr/local/lib/python3.6/dist-packages/FoBiS.py-2.2.8-py3.6.egg/fobis/Fobos.py", line 144, in _get_local_variables
    File "/usr/lib/python3.6/configparser.py", line 858, in items
    return [(option, value_getter(option)) for option in d.keys()]
    File "/usr/lib/python3.6/configparser.py", line 858, in <listcomp>
    return [(option, value_getter(option)) for option in d.keys()]
    File "/usr/lib/python3.6/configparser.py", line 855, in <lambda>
    section, option, d[option], d)
    File "/usr/lib/python3.6/configparser.py", line 394, in before_get
    self._interpolate_some(parser, option, L, value, section, defaults, 1)
    File "/usr/lib/python3.6/configparser.py", line 444, in _interpolate_some
    "found: %r" % (rest,))
    configparser.InterpolationSyntaxError: '%' must be followed by '%' or '(', found: '%^%FACE/%" -czf FACE.tar.gz *'
   ```
---
List of numerical libraries. [Transport Door](https://en.wikipedia.org/wiki/List_of_numerical_libraries)

Install Lapack
