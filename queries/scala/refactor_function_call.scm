(call_expression
  function: (identifier) @function_call.name
  arguments: (arguments
    .
    (_) @function_call.arg
    .
    (","
      (_) @function_call.arg)*)?) @function_call
