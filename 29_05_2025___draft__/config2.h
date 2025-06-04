#define LA_IS  2
#define LA_NOT 4 

#define GRAMMAR_LL2__2025 {\
{ LA_IS, {"ident_terminal"}, { "labeled_point",{\
    { LA_IS, {""}, 2, {"ident", ":"}}\
}}},\
{ LA_IS, {"GOTO"}, { "goto_label",{\
    { LA_IS, {""}, 2, {"GOTO", "ident"}}\
}}},\
{ LA_IS, {"ident_terminal"}, { "program_name",{\
    { LA_IS, {""}, 1, {"ident"}}\
}}},\
{ LA_IS, {"INTEGER16"}, { "value_type",{\
    { LA_IS, {""}, 1, {"INTEGER16"}}\
}}},\
{ LA_IS, {"["}, { "array_specify",{\
    { LA_IS, {""}, 3, {"[", "unsigned_value", "]"}}\
}}},\
{ LA_IS, {"ident_terminal"}, { "declaration_element",{\
    { LA_IS, {""}, 2, {"ident", "array_specify_optional"}}\
}}},\
{ LA_IS, {"["}, { "array_specify_optional",{\
    { LA_IS, {""}, 1, {"array_specify"}}\
}}},\
{ LA_NOT, {"["}, { "array_specify_optional",{\
    { LA_IS, {""}, 0, {""}}\
}}},\
{ LA_IS, {","}, { "other_declaration_ident",{\
    { LA_IS, {""}, 2, {",", "declaration_element"}}\
}}},\
{ LA_IS, {"INTEGER16"}, { "declaration",{\
    { LA_IS, {""}, 3, {"value_type", "declaration_element", "other_declaration_ident__iteration"}}\
}}},\
{ LA_IS, { "," }, { "other_declaration_ident__iteration",{\
    { LA_IS, {""}, 2, { "other_declaration_ident", "other_declaration_ident__iteration" }}\
}}},\
{ LA_NOT, { "," }, { "other_declaration_ident__iteration",{\
    { LA_IS, {""}, 0, { "" }}\
}}},\
{ LA_IS, { "[" }, { "index_action",{\
    { LA_IS, {""}, 3, { "[", "expression", "]" }}\
}}},\
{ LA_IS, { "NOT" }, { "unary_operator",{\
    { LA_IS, {""}, 1, { "NOT" }}\
}}},\
{ LA_IS, { "-" }, { "unary_operator",{\
    { LA_IS, {""}, 1, { "-" }}\
}}},\
{ LA_IS, { "+" }, { "unary_operator",{\
    { LA_IS, {""}, 1, { "+" }}\
}}},\
{ LA_IS, { "NOT", "+", "-" }, { "unary_operation",{\
    { LA_IS, {""}, 2, { "unary_operator", "expression" }}\
}}},\
{ LA_IS, { "AND" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "AND" }}\
}}},\
{ LA_IS, { "OR" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "OR" }}\
}}},\
{ LA_IS, { "==" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "==" }}\
}}},\
{ LA_IS, { "!=" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "!=" }}\
}}},\
{ LA_IS, { "<=" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "<=" }}\
}}},\
{ LA_IS, { ">=" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { ">=" }}\
}}},\
{ LA_IS, { "+" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "+" }}\
}}},\
{ LA_IS, { "-" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "-" }}\
}}},\
{ LA_IS, { "*" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "*" }}\
}}},\
{ LA_IS, { "DIV" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "DIV" }}\
}}},\
{ LA_IS, { "MOD" }, { "binary_operator",{\
    { LA_IS, {""}, 1, { "MOD" }}\
}}},\
{ LA_IS, { "AND", "OR", "==", "!=", "<=", ">=", "+", "-", "*", "DIV", "MOD" }, { "binary_action",{\
    { LA_IS, {""}, 2, { "binary_operator", "expression" }}\
}}},\
{LA_IS, { "(" }, { "left_expression",{\
    {LA_IS, { "" }, 1, { "group_expression" }}\
}}},\
{LA_IS, { "NOT" }, { "left_expression",{\
    {LA_IS, { "" }, 1, { "unary_operation" }}\
}}},\
{LA_IS, { "+", "-" }, { "left_expression",{\
    {LA_IS,  { "unsigned_value_terminal"}, 1, { "value" }},\
    {LA_NOT, { "unsigned_value_terminal" }, 1, { "unary_operation" }}\
}}},\
{LA_IS, { "ident_terminal" }, { "left_expression",{\
    {LA_IS, {""}, 2, { "ident", "index_action_optional" }}\
}}},\
{LA_IS, { "unsigned_value_terminal" }, { "left_expression",{\
    {LA_IS, {""}, 1, { "value" }}\
}}},\
{LA_IS, { "[" }, { "index_action_optional",{\
    {LA_IS, {""}, 1, { "index_action" }}\
}}},\
{LA_NOT, { "[" }, { "index_action_optional",{\
    {LA_IS, {""}, 0, { "" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "expression",{\
    {LA_IS, {""}, 2, { "left_expression", "binary_action__iteration" }}\
}}},\
{LA_IS, { "AND", "OR", "==", "!=", "<=", ">=", "+", "-", "*", "DIV", "MOD" }, { "binary_action__iteration",{\
    {LA_IS, {""}, 2, { "binary_action", "binary_action__iteration" }}\
}}},\
{LA_NOT, { "AND", "OR", "==", "!=", "<=", ">=", "+", "-", "*", "DIV", "MOD" }, { "binary_action__iteration",{\
    {LA_IS, {""}, 0, { "" }}\
}}},\
{LA_IS, { "(" }, { "group_expression",{\
    {LA_IS, {""}, 3, { "(", "expression", ")" }}\
}}},\
{LA_IS, { "ident_terminal" }, { "bind_right_to_left",{\
    {LA_IS, {""}, 4, { "ident", "index_action_optional", ":=", "expression" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "bind_left_to_right",{\
    {LA_IS, {""}, 4, { "expression", "=:", "ident", "index_action_optional" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "if_expression",{\
    {LA_IS, {""}, 1, { "expression" }}\
}}},\
{LA_IS, { "{" }, { "body_for_true",{\
    {LA_IS, {""}, 1, { "block_statements_in_while_and_if_body" }}\
}}},\
{LA_IS, { "ELSE" }, { "false_cond_block_without_else",{\
    {LA_IS, {""}, 4, { "ELSE", "IF", "if_expression", "body_for_true" }}\
}}},\
{LA_IS, { "ELSE" }, { "body_for_false",{\
    {LA_IS, {""}, 2, { "ELSE", "block_statements_in_while_and_if_body" }}\
}}},\
{LA_IS, { "IF" }, { "cond_block",{\
    {LA_IS, {""}, 5, { "IF", "if_expression", "body_for_true", "false_cond_block_without_else__iteration", "body_for_false_optional" }}\
}}},\
{LA_IS, { "ELSE" }, { "false_cond_block_without_else__iteration",{\
    {LA_IS, {"IF"}, 2, { "false_cond_block_without_else", "false_cond_block_without_else__iteration" }},\
    {LA_NOT, { "IF" }, 0, { "" }}\
}}},\
{LA_NOT, { "ELSE" }, { "false_cond_block_without_else__iteration",{\
    {LA_IS, {""}, 0, { "" }}\
}}},\
{LA_IS, { "ELSE" }, { "body_for_false_optional",{\
    {LA_IS, {""}, 1, { "body_for_false" }}\
}}},\
{LA_NOT, { "ELSE" }, { "body_for_false_optional",{\
    {LA_IS, {""}, 0, { "" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "cycle_begin_expression",{\
    {LA_IS, {""}, 1, { "expression" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "cycle_end_expression",{\
    {LA_IS, {""}, 1, { "expression" }}\
}}},\
{LA_IS, { "ident_terminal" }, { "cycle_counter",{\
    {LA_IS, {""}, 1, { "ident" }}\
}}},\
{LA_IS, { "ident_terminal" }, { "cycle_counter_rl_init",{\
    {LA_IS, {""}, 3, { "cycle_counter", ":=", "cycle_begin_expression" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "cycle_counter_lr_init",{\
    {LA_IS, {""}, 3, { "cycle_begin_expression", "=:", "cycle_counter" }}\
}}},\
{LA_IS, { "ident_terminal" }, { "cycle_counter_init",{\
    {LA_IS, {":="}, 1, { "cycle_counter_rl_init" }},\
    {LA_NOT, { ":=" }, 1, { "cycle_counter_lr_init" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "unsigned_value_terminal" }, { "cycle_counter_init",{\
    {LA_IS, {""}, 1, { "cycle_counter_lr_init" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "cycle_counter_last_value",{\
    {LA_IS, {""}, 1, { "cycle_end_expression" }}\
}}},\
{LA_IS, { "DO" }, { "cycle_body",{\
    {LA_IS, {""}, 2, { "DO", "statement__or__block_statements" }}\
}}},\
{LA_IS, { "FOR" }, { "forto_cycle",{\
    {LA_IS, {""}, 5, { "FOR", "cycle_counter_init", "TO", "cycle_counter_last_value", "cycle_body" }}\
}}},\
{LA_IS, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";" }, { "statement_in_while_and_if_body",{\
    {LA_IS, {""}, 1, { "statement" }}\
}}},\
{LA_IS, { "CONTINUE" }, { "statement_in_while_and_if_body",{\
    {LA_IS, {""}, 1, { "CONTINUE" }}\
}}},\
{LA_IS, { "BREAK" }, { "statement_in_while_and_if_body",{\
    {LA_IS, {""}, 1, { "BREAK" }}\
}}},\
{LA_IS, { "{" }, { "block_statements_in_while_and_if_body",{\
    {LA_IS, {""}, 3, { "{", "statement_in_while_and_if_body__iteration", "}" }}\
}}},\
{LA_IS, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";", "CONTINUE", "BREAK" }, { "statement_in_while_and_if_body__iteration",{\
    {LA_IS, {""}, 2, { "statement_in_while_and_if_body", "statement_in_while_and_if_body__iteration" }}\
}}},\
{LA_NOT, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";", "CONTINUE", "BREAK" }, { "statement_in_while_and_if_body__iteration",{\
    {LA_IS, {""}, 0, { "" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "while_cycle_head_expression",{\
    {LA_IS, {""}, 1, { "expression" }}\
}}},\
{LA_IS, { "WHILE" }, { "while_cycle",{\
    {LA_IS, {""}, 3, { "WHILE", "while_cycle_head_expression", "block_statements_in_while_and_if_body" }}\
}}},\
{LA_IS, { "(", "NOT", "+", "-", "ident_terminal", "unsigned_value_terminal" }, { "repeat_until_cycle_cond",{\
    {LA_IS, {""}, 1, { "expression" }}\
}}},\
{LA_IS, { "REPEAT" }, { "repeat_until_cycle",{\
    {LA_IS, {""}, 4, { "REPEAT", "statement__or__block_statements", "UNTIL", "repeat_until_cycle_cond" }}\
}}},\
{LA_IS, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";" }, { "statement__or__block_statements",{\
    {LA_IS, {""}, 1, { "statement" }}\
}}},\
{LA_IS, { "{" }, { "statement__or__block_statements",{\
    {LA_IS, {""}, 1, { "block_statements" }}\
}}},\
{LA_IS, { "GET" }, { "input",{\
    {LA_IS, {""}, 2, { "GET", "argument_for_input" }}\
}}},\
{LA_IS, { "ident_terminal" }, { "argument_for_input",{\
    {LA_IS, {""}, 2, { "ident", "index_action_optional" }}\
}}},\
{LA_IS, { "(" }, { "argument_for_input",{\
    {LA_IS, {""}, 4, { "(", "ident", "index_action_optional", ")" }}\
}}},\
{LA_IS, { "PUT" }, { "output", {\
    {LA_IS, { "" }, 2, {"PUT", "expression"} }\
}}},\
{LA_IS, { "ident_terminal" }, { "statement", {\
    { LA_IS, { ":=" }, 1, {"bind_right_to_left"}},\
    { LA_IS, { ":" }, 1, {"labeled_point"}},\
    { LA_NOT, { ":=", ":" }, 1, {"bind_left_to_right"}} \
}}},\
{LA_IS, { "(", "NOT", "unsigned_value_terminal", "+", "-" }, { "statement", {\
    { LA_IS, {""}, 1, {"bind_left_to_right"}}\
}}},\
{LA_IS, { "IF" }, { "statement",{\
    {LA_IS, {""}, 1, {"cond_block"}}\
}}},\
{LA_IS, { "FOR" }, { "statement",{\
    {LA_IS, {""}, 1, {"forto_cycle"}}\
}}},\
{LA_IS, { "WHILE" }, { "statement",{\
    {LA_IS, {""}, 1, {"while_cycle"}}\
}}},\
{LA_IS, { "REPEAT" }, { "statement",{\
    {LA_IS, {""}, 1, {"repeat_until_cycle"}}\
}}},\
{LA_IS, { "GOTO" }, { "statement",{\
    {LA_IS, {""}, 1, {"goto_label"}}\
}}},\
{LA_IS, { "GET" }, { "statement",{\
    {LA_IS, {""}, 1, {"input"}}\
}}},\
{LA_IS, { "PUT" }, { "statement",{\
    {LA_IS, {""}, 1, {"output"}}\
}}},\
{LA_IS, { ";" }, { "statement",{\
    {LA_IS, {""}, 1, {";"}}\
}}},\
{ LA_IS, { "{" }, { "block_statements",{\
    { LA_IS, {""}, 3, { "{", "statement__iteration", "}" }}\
}}},\
{ LA_IS, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";" }, { "statement__iteration",{\
    { LA_IS, {""}, 2, { "statement", "statement__iteration" }}\
}}},\
{ LA_NOT, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";" }, { "statement__iteration",{\
    { LA_IS, {""}, 0, { "" }}\
}}},\
{ LA_IS, { "NAME" }, { "program",{\
    { LA_IS, {""}, 9, { "NAME", "program_name", ";", "BODY", "DATA", "declaration_optional", ";", "statement__iteration", "END" }}\
}}},\
{ LA_IS, { "INTEGER16" }, { "declaration_optional",{\
    { LA_IS, {""}, 1, { "declaration" }}\
}}},\
{ LA_NOT, { "INTEGER16" }, { "declaration_optional",{\
    { LA_IS, {""}, 0, { "" }}\
}}},\
{LA_IS, { "unsigned_value_terminal" }, { "unsigned_value", {\
    {LA_IS, { "" }, 1, { "unsigned_value_terminal" }}\
}}},\
{LA_IS, { "unsigned_value_terminal", "+", "-" }, { "value", {\
    {LA_IS, { "" }, 2, { "sign_optional", "unsigned_value" }}\
}}},\
{LA_IS, { "+", "-" }, { "sign_optional", {\
    {LA_IS, { "" }, 1, { "sign" }}\
}}},\
{LA_NOT, { "+", "-" }, { "sign_optional",{\
    {LA_IS, { "" }, 0, { "" }}\
}}},\
{LA_IS, { "ident_terminal" }, { "ident", {\
    {LA_IS, {""}, 1, {"ident_terminal"} }\
}}},\
{LA_IS, { "+" }, { "sign", {\
    {LA_IS, {""}, 1, {"+"}}\
}}},\
{LA_IS, { "-" }, { "sign", {\
    {LA_IS, {""}, 1, {"-"} }\
}}}\
\
},\
100,\
"program"