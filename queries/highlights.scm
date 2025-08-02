;; Comments

(comment) @comment

;; Punctuation

["(" ")" "," "->" "." ".." "..." ":" ";" "=" "{" "|" "}"] @punctuation

;; Literals

"undefined" @literal
(boolean) @boolean_literal
(character) @character_literal
"'" @character_literal_delimiter
(character (escape_sequence) @character_literal_escape_sequence)
"null" @null_literal
[(integer) (float)] @number_literal
(string) @string_literal
(multiline_string) @string_literal
"\"" @string_literal_delimiter
"\\\\" @string_literal_delimiter
(string (escape_sequence) @string_literal_escape_sequence)

;; Operators

(_ operator: _ @operator)
(variable_declaration "=" @operator)
[".*" ".?" "*" "?" "!"] @operator

(anonymous_struct_initializer "." @matchfix_operator)
(initializer_list ["{" "}"] @matchfix_operator)
(call_expression ["(" ")"] @matchfix_operator)
(arguments ["(" ")"] @matchfix_operator)
["[" "]"] @matchfix_operator

(field_expression "." @member_access_operator)
(error_type "." @member_access_operator)

;; Keywords

["asm" "defer" "errdefer" "error" "comptime"] @keyword

["extern" "packed" "enum" "struct" "union" "opaque"
 "align" "addrspace" "const" "volatile" "allowzero"
 "fn" "callconv"] @type_keyword
(error_set_declaration "error" @type_keyword)

["if" "else" "switch" "=>" "catch" "and" "or" "orelse"] @evaluation_branch

["inline" "while" "for"] @evaluation_loop
(while_statement (else_clause "else" @evaluation_loop))
(while_expression "else" @evaluation_loop)
(for_statement (else_clause "else" @evaluation_loop))
(for_expression "else" @evaluation_loop)

["break" "continue" "return" "try" "unreachable"] @evaluation_end

"var" @declaration
(function_declaration "fn" @declaration)
(comptime_declaration "comptime" @declaration)
(variable_declaration "const" @declaration)

["pub" "export" "noinline" "threadlocal" "linksection"] @declaration_modifier
(function_declaration ["extern" "inline"] @declaration_modifier)
(parameter ["comptime" "noalias"] @declaration_modifier)
(variable_declaration "extern" @declaration_modifier)
(container_field ["comptime" "align"] @declaration_modifier)

;; Identifiers

(identifier) @variable
(identifier "@" @variable_delimiter (string "\"" @variable_delimiter) @variable)
(identifier (string (escape_sequence) @variable_escape_sequence))

((identifier) @type
 (#match? @type "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^[A-Z_][A-Z_0-9]*$"))

(member_identifier) @member_variable
(member_identifier "@" @member_variable_delimiter (string "\"" @member_variable_delimiter))
(member_identifier (string (escape_sequence) @member_variable_escape_sequence))

((member_identifier) @member_type
 (#match? @member_type "^[A-Z]"))

((member_identifier) @member_constant
 (#match? @member_constant "^[A-Z_][A-Z_0-9]*$"))

(call_expression
 function: [(identifier) @function
            (_ member: _ @member_function)])

(call_expression
 function: [(identifier) @_name @type
            (_ member: _ @_name @member_type)]
 (#match? @_name "^[A-Z]"))

(_ type: [(identifier) @type
          (_ member: _ @member_type)])

(builtin_identifier) @builtin_function
(builtin_type) @builtin_type

(error_type (identifier) @member_constant)
(error_set_declaration (identifier) @member_constant)

(function_declaration name: _ @function)
(parameter name: _ @function_parameter)
"..." @special_function_parameter

;; Query precedence fixes

(asm_output_item ["[" "]"] @punctuation)
(asm_input_item ["[" "]"] @punctuation)
(asm_expression "volatile" @keyword)
(switch_case "inline" @evaluation_branch)
