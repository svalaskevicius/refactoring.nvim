(function_definition
  name: (identifier) @function.name
  parameters: (parameters
    (parameter
      (identifier) @function.arg
      (","
        (parameter
          (identifier) @function.arg)*)*))?
  (block) @function.body) @function

(object_definition
  (template_body
    (function_definition
      name: (identifier) @function.name
      parameters: (parameters
        (parameter
          (identifier) @function.arg
          (","
            (parameter
              (identifier) @function.arg)*)*)?
      (block) @function.body) @function.outside))

(class_definition
  (template_body
    (function_definition
      name: (identifier) @function.name
      parameters: (parameters
        (parameter
          (identifier) @function.arg
          (","
            (parameter
              (identifier) @function.arg)*)*)?
      (block) @function.body) @function.outside))

(trait_definition
  (template_body
    (function_definition
      name: (identifier) @function.name
      parameters: (parameters
        (parameter
          (identifier) @function.arg
          (","
            (parameter
              (identifier) @function.arg)*)*)?
      (block) @function.body) @function.outside))
