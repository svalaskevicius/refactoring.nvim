; NOTE: `value_separator`/`identifier_separator` are only captured for
; multi-variable declarations (like in the other languages), so that a simple
; declaration is deleted as a whole when inlining
(val_definition
  pattern: (identifier) @variable.identifier
  value: (_) @variable.value) @variable.declaration

(var_definition
  pattern: (identifier) @variable.identifier
  value: (_) @variable.value) @variable.declaration
