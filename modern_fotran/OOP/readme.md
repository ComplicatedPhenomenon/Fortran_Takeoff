The dummy argument that corresponds to the passed object of a procedure binding must always be polymorphic.

An abstract type is a type with the ABSTRACT attribute, . A nonpolymorphic object must not be declared with an abstract type.

A binding with the DEFERRED attribute is a deferred binding. A deferred binding defers the implementation of a procedure to extensions of the type. You can specify a deferred binding only in an abstract type definition. The dynamic type of a polymorphic object cannot be an abstract type. Therefore, a deferred binding cannot be invoked. An extension of an abstract type does not have to be abstract if that extension does not contain or inherit deferred bindings.

If a type definition contains or inherits a deferred binding, the ABSTRACT attribute must appear. If ABSTRACT appears, the type must be extensible.