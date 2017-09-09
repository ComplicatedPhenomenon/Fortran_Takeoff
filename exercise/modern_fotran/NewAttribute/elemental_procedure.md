 If the ELEMENTAL prefix specifier is used, the RECURSIVE specifier cannot be used.
 An elemental subprogram is a pure subprogram. However subprograms  are not
 necessarily elemental subprograms. 

 Elemental procedures must conform to the following rule:

 * The result if an elemental function must be a scalar, and must not have the `ALLOCATABLE`  or `POINTER` attribute.
 * The following apply to dummy arguments used in elemental subprograms:
    *  All dummy arguments must be scalar, and must not have the `ALLOCATABLE`  or `POINTER` attribute.
    *  A dummy argument cannot be used in a specification expression, except ()
    * A dummy argument cannot be an asterisk or a dummy procedure.
