(compilation_unit
  (function_definition) @output_function)

(compilation_unit
  (object_definition
    (template_body
      (comment)* @output_function.comment
      (function_definition) @output_function)))

(compilation_unit
  (class_definition
    (template_body
      (comment)* @output_function.comment
      (function_definition) @output_function)))

(compilation_unit
  (trait_definition
    (template_body
      (comment)* @output_function.comment
      (function_definition) @output_function)))
