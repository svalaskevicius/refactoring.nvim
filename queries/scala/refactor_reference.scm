(val_definition
  pattern: (identifier) @reference.identifier
  (#set! reference_type write)
  (#set! declaration))

(var_definition
  pattern: (identifier) @reference.identifier
  (#set! reference_type write)
  (#set! declaration))

(parameter
  (identifier) @reference.identifier
  (type_identifier) @_type
  (#set-type! scala @_type @reference.identifier)
  (#set! declaration))

(function_definition
  name: (identifier) @reference.identifier
  (#set! declaration)
  (#set! reference_type write))

(function_declaration
  name: (identifier) @reference.identifier
  (#set! declaration)
  (#set! reference_type write))

(object_definition
  name: (identifier) @reference.identifier
  (#set! declaration)
  (#set! reference_type write))

(class_definition
  name: (identifier) @reference.identifier
  (#set! declaration)
  (#set! reference_type write))

(_
  (identifier) @reference.identifier
  (#set! reference_type read))

(_
  (identifier) @reference.identifier
  (#set! reference_type write))
