(if_expression
  (#set! text if)) @debug_path_segment

(function_definition
  name: (identifier) @_name
  (#set! text @_name)) @debug_path_segment

(function_declaration
  name: (identifier) @_name
  (#set! text @_name)) @debug_path_segment

(object_definition
  name: (identifier) @_name
  (#set! text @_name)) @debug_path_segment

(class_definition
  name: (identifier) @_name
  (#set! text @_name)) @debug_path_segment

(trait_definition
  name: (identifier) @_name
  (#set! text @_name)) @debug_path_segment
