(compilation_unit
  (function_definition) @input_function)

(compilation_unit
  (object_definition
    (template_body
      (function_definition) @input_function))
  (#set! method))

(compilation_unit
  (class_definition
    (template_body
      (function_definition) @input_function))
  (#set! method))

(compilation_unit
  (trait_definition
    (template_body
      (function_definition) @input_function))
  (#set! method))
