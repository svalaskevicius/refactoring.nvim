[
  (val_definition)
  (var_definition)
  (return_expression)
  (if_expression)
  (while_expression)
  (do_while_expression)
  (for_expression)
  (match_expression)
  (throw_expression)
  (try_expression)
  (object_definition)
  (class_definition)
  (trait_definition)
  (function_declaration)
  (import_declaration)
] @output_statement

(block
  [
    (identifier)
    (call_expression)
    (infix_expression)
    (prefix_expression)
    (postfix_expression)
    (parenthesized_expression)
    (instance_expression)
    (field_expression)
    (lambda_expression)
    (tuple_expression)
    (string)
    (interpolated_string_expression)
    (character_literal)
    (integer_literal)
    (boolean_literal)
    (null_literal)
    (block)
  ] @output_statement)

(function_definition
  (block
    .
    (_) @output_statement.inside)) @output_statement

(object_definition
  body: (template_body
    .
    (_) @output_statement.inside)) @output_statement

(class_definition
  body: (template_body
    .
    (_) @output_statement.inside)) @output_statement

(trait_definition
  body: (template_body
    .
    (_) @output_statement.inside)) @output_statement
