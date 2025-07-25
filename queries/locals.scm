;; Scopes

[(source_file)
 (function_declaration_scope)
 (block)
 (if_statement)
 (while_statement)
 (for_statement)
 (switch_case)
 (catch_expression)] @local.scope

;; Definitions

(function_declaration name: _ @local.definition)
(parameter name: _ @local.definition)
(variable_declaration name: _ @local.definition)
(payload (identifier) @local.definition)

;; References

(identifier) @local.reference
