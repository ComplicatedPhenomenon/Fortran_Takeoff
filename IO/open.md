# Open usage
The `open` statement use a number of *tags* to specify which file to open and how it will be used.

required tags:

* unit: integer unit number to be used by read, write, and close
* filename: String constant, variable, or expression representing the absolute or relative pathname of the file.
* status: String constant, variable, or expression that reduce to:
   * 'old': For existing files, usually used when reading.
   * 'new': Used when writing to a file that does not existed.
   * 'replace': Used to overwrite a file that already exists.
* iostat: Integer variables to receive the status of the open operation. If the file is opened successfully, the variable is set to 0. Otherwise, it will contain a non-zero error code that indicates why the file could not be opened.(Does not exist, no permission, etc.)

#  Why should subroutine and function be wrapped into module?
From my limited experience, I think it reduce reductant.

# PUBLIC attribute in module
A private entity of a module can only be accessed within that module. On the
other hand, one can explicitly list those entities that can be accessed
from outside.

Remember to use the module before accessing the public entity from the outside.

# Code Style
In order to memorize it's been a long way to get here for Fortran.

All attributes in capital. Better to convert the code written a year ago while
script.
# Variable string as file names
