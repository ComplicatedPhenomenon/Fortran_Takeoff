# Open usage
The `open` statement use a number of *tags* to specify which file to open and how it will be used.

required tags:

* unit: integer unit number to be used by read, write, and close
* filename: String constant, variable, or expression representing the absolute or relative pathname of the file.
* status: String constant, variable, or expression that reduce to:
   * 'old': For existing files, usually used when reading.
   * 'new': Used when writing to a file that does not existed.
   * 'replace': Used to overwrite a file that already existed.
* iostat: Integer variables to receive the status of the open operation. If the file is opened successfully, the variable is set to 0. Otherwise, it will contain a non-zero error code that indicates why the file could not be opened.(Does not exist, no permission, etc.)

https://pages.mtu.edu/~shene/COURSES/cs201/NOTES/chap05/format.html
