#define LA_IS  0
#define LA_NOT 1 

//unsigned_value_terminal unsigned_value
#define NEW__GRAMMAR_123 {\
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
    { LA_IS, {""}, 1, {""}}\
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
    {LA_IS,  { "unsigned_value_terminal"}, 1, { "value" }}\
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
    {LA_IS, {"IF"}, 2, { "false_cond_block_without_else", "false_cond_block_without_else__iteration" }}\
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
    {LA_IS, {":="}, 1, { "cycle_counter_rl_init" }}\
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
{LA_IS, { "DO" }, { "forto_cycle",{\
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
    { LA_IS, { ":=" }, 1, {"bind_right_to_left"} },\
    { LA_IS, { ":" }, 1, {"labeled_point"} },\
    { LA_NOT, { ":=", ":" }, 1, {"bind_left_to_right"} } \
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


//block_statements("{") = "{", statement__iteration, "}";
{ LA_IS, { "{" }, { "block_statements",{\
    { LA_IS, {""}, 3, { "{", "statement__iteration", "}" }}\
}}},\
//statement__iteration(ident_terminal, "(", "NOT", UNSIGNED_VALUE, "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";") = statement, statement__iteration;
{ LA_IS, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";" }, { "statement__iteration",{\
    { LA_IS, {""}, 2, { "statement", "statement__iteration" }}\
} }}, \
//statement__iteration(!(ident_terminal, "(", "NOT", UNSIGNED_VALUE, "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";")) = ε;
{ LA_NOT, { "ident_terminal", "(", "NOT", "unsigned_value_terminal", "+", "-", "IF", "FOR", "WHILE", "REPEAT", "GOTO", "GET", "PUT", ";" }, { "statement__iteration",{\
    { LA_IS, {""}, 0, { "" }}\
} }}, \
//program("NAME") = "NAME", program_name, ";", "BODY", "DATA", declaration_optional, ";", statement__iteration, "END";
{ LA_IS, { "NAME" }, { "program",{\
    { LA_IS, {""}, 9, { "NAME", "program_name", ";", "BODY", "DATA", "declaration_optional", ";", "statement__iteration", "END" }}\
} }}, \
//declaration_optional("INTEGER16") = declaration;
{ LA_IS, { "INTEGER16" }, { "declaration_optional",{\
    { LA_IS, {""}, 1, { "declaration" }}\
} }}, \
//declaration_optional(!"INTEGER16") = ε;
{ LA_NOT, { "INTEGER16" }, { "declaration_optional",{\
    { LA_IS, {""}, 0, { "" }}\
}}},\


//unsigned_value(unsigned_value_terminal) = unsigned_value_terminal;
{LA_IS, { "unsigned_value_terminal" }, { "unsigned_value", {\
    {LA_IS, { "" }, 1, { "unsigned_value_terminal" }}\
}}},\
//value(unsigned_value_terminal, "+", "-") = sign_optional, unsigned_value;
{LA_IS, { "unsigned_value_terminal", "+", "-" }, { "value", {\
    {LA_IS, { "" }, 2, { "sign_optional", "unsigned_value" }}\
}}},\
//sign_optional("+", "-") = sign;
{LA_IS, { "+", "-" }, { "sign_optional", {\
    {LA_IS, { "" }, 1, { "sign" }}\
}}},\
//sign_optional(!("+", "-")) = ε;
{LA_NOT, { "+", "-" }, { "sign_optional",{\
    {LA_IS, { "" }, 1, { "" }}\
}}},\


{LA_IS, { "ident_terminal" }, { "ident", {\
    {LA_IS, {""}, 1, {"ident_terminal"} }\
}}},\
{LA_IS, { "+" }, { "sign", {\
    {LA_IS, {""}, 1, {"+"}}\
}}},\
{LA_IS, { "-" }, { "sign", {\
    {LA_IS, {""}, 1, {"-"} }\
}}},\
\
},\
176,\
"program"


#define NEW__GRAMMAR_123___OLD_COPY {\
    {"labeled_point", 2, {"ident", "tokenCOLON"}},\
    {"goto_label", 2, {"tokenGOTO","ident"}},\
    {"program_name", 1, {"ident_terminal"}},\
    {"value_type", 1, {"INTEGER16"}},\
    {"other_declaration_ident", 2, {"tokenCOMMA", "ident"}},\
    {"other_declaration_ident____iteration_after_one", 2, {"other_declaration_ident","other_declaration_ident____iteration_after_one"}},\
    {"other_declaration_ident____iteration_after_one", 2, {"tokenCOMMA", "ident"}},\
    {"value_type__ident", 2, {"value_type", "ident"}},\
    {"declaration", 2, {"value_type__ident", "other_declaration_ident____iteration_after_one"}},\
    {"declaration", 2, {"value_type", "ident"}},\
\
    {"unary_operator", 1, {"NOT"}},\
    {"unary_operator", 1, {"-"}},\
    {"unary_operator", 1, {"+"}},\
    {"binary_operator", 1, {"AND"}},\
    {"binary_operator", 1, {"OR"}},\
    {"binary_operator", 1, {"=="}},\
    {"binary_operator", 1, {"!="}},\
    {"binary_operator", 1, {"<="}},\
    {"binary_operator", 1, {">="}},\
    {"binary_operator", 1, {"+"}},\
    {"binary_operator", 1, {"-"}},\
    {"binary_operator", 1, {"*"}},\
    {"binary_operator", 1, {"DIV"}},\
    {"binary_operator", 1, {"MOD"}},\
    {"binary_action", 2, {"binary_operator","expression"}},\
\
    {"left_expression", 2, {"tokenGROUPEXPRESSIONBEGIN__expression","tokenGROUPEXPRESSIONEND"}},\
    {"left_expression", 2, {"unary_operator","expression"}},\
    {"left_expression", 1, {"ident_terminal"}},\
    {"left_expression", 1, {"value_terminal"}},\
    {"binary_action____iteration_after_two", 2, {"binary_action","binary_action____iteration_after_two"}},\
    {"binary_action____iteration_after_two", 2, {"binary_action","binary_action"}},\
    {"expression", 2, {"left_expression","binary_action____iteration_after_two"}},\
    {"expression", 2, {"left_expression","binary_action"}},\
    {"expression", 2, {"tokenGROUPEXPRESSIONBEGIN__expression","tokenGROUPEXPRESSIONEND"}},\
    {"expression", 2, {"unary_operator","expression"}},\
    {"expression", 1, {"ident_terminal"}},\
    {"expression", 1, {"value_terminal"}},\
\
    {"tokenGROUPEXPRESSIONBEGIN__expression", 2, {"tokenGROUPEXPRESSIONBEGIN","expression"}},\
    {"group_expression", 2, {"tokenGROUPEXPRESSIONBEGIN__expression","tokenGROUPEXPRESSIONEND"}},\
\
    {"bind_right_to_left", 2, {"ident","rl_expression"}},\
    {"bind_left_to_right", 2, {"lr_expression","ident"}},\
\
    {"body_for_true", 2, {"statement_in_while_body____iteration_after_two","tokenSEMICOLON"}},\
    {"body_for_true", 2, {"statement_in_while_body","tokenSEMICOLON"}},\
    {"body_for_true", 1, {";"}},\
    {"tokenELSE__statement_in_while_body", 2, {"tokenELSE","statement_in_while_body"}},\
    {"tokenELSE__statement_in_while_body____iteration_after_two", 2, {"tokenELSE","statement_in_while_body____iteration_after_two"}},\
    {"body_for_false", 2, {"tokenELSE__statement_in_while_body____iteration_after_two","tokenSEMICOLON"}},\
    {"body_for_false", 2, {"tokenELSE__statement_in_while_body","tokenSEMICOLON"}},\
    {"body_for_false", 2, {"tokenELSE","tokenSEMICOLON"}},\
    {"tokenIF__tokenGROUPEXPRESSIONBEGIN", 2, {"tokenIF","tokenGROUPEXPRESSIONBEGIN"}},\
    {"expression__tokenGROUPEXPRESSIONEND", 2, {"expression","tokenGROUPEXPRESSIONEND"}},\
    {"tokenIF__tokenGROUPEXPRESSIONBEGIN__expression__tokenGROUPEXPRESSIONEND", 2, {"tokenIF__tokenGROUPEXPRESSIONBEGIN","expression__tokenGROUPEXPRESSIONEND"}},\
    {"body_for_true__body_for_false", 2, {"body_for_true","body_for_false"}},\
    {"cond_block", 2, {"tokenIF__tokenGROUPEXPRESSIONBEGIN__expression__tokenGROUPEXPRESSIONEND","body_for_true__body_for_false"}},\
    {"cond_block", 2, {"tokenIF__tokenGROUPEXPRESSIONBEGIN__expression__tokenGROUPEXPRESSIONEND","body_for_true"}},\
\
    {"cycle_counter", 1, {"ident_terminal"}},\
    {"rl_expression", 2, {"tokenRLBIND","expression"}},\
    {"lr_expression", 2, {"expression","tokenLRBIND"}},\
    {"cycle_counter_init", 2, {"cycle_counter","rl_expression"}},\
    {"cycle_counter_init", 2, {"lr_expression","cycle_counter"}},\
    {"cycle_counter_last_value", 1, {"value_terminal"}},\
    {"cycle_body", 2, {"tokenDO","statement____iteration_after_two"}},\
    {"cycle_body", 2, {"tokenDO","statement"}},\
    {"tokenFOR__cycle_counter_init", 2, {"tokenFOR","cycle_counter_init"}},\
    {"tokenTO__cycle_counter_last_value", 2, {"tokenTO","cycle_counter_last_value"}},\
    {"tokenFOR__cycle_counter_init__tokenTO__cycle_counter_last_value", 2, {"tokenFOR__cycle_counter_init","tokenTO__cycle_counter_last_value"}},\
    {"cycle_body__tokenSEMICOLON", 2, {"cycle_body","tokenSEMICOLON"}},\
    {"forto_cycle", 2, {"tokenFOR__cycle_counter_init__tokenTO__cycle_counter_last_value","cycle_body__tokenSEMICOLON"}},\
\
    {"continue_while", 2, {"tokenCONTINUE","tokenWHILE"}},\
    {"exit_while", 2, {"tokenEXIT","tokenWHILE"}},\
    {"tokenWHILE__expression", 2, {"tokenWHILE","expression"}},\
    {"tokenEND__tokenWHILE", 2, {"tokenEND","tokenWHILE"}},\
    {"tokenWHILE__expression__statement_in_while_body", 2, {"tokenWHILE__expression","statement_in_while_body"}},\
    {"tokenWHILE__expression__statement_in_while_body____iteration_after_two", 2, {"tokenWHILE__expression","statement_in_while_body____iteration_after_two"}},\
    {"while_cycle", 2, {"tokenWHILE__expression__statement_in_while_body____iteration_after_two","tokenEND__tokenWHILE"}},\
    {"while_cycle", 2, {"tokenWHILE__expression__statement_in_while_body","tokenEND__tokenWHILE"}},\
    {"while_cycle", 2, {"tokenWHILE__expression","tokenEND__tokenWHILE"}},\
\
    {"tokenUNTIL__expression", 2, {"tokenUNTIL","expression"}},\
    {"tokenREPEAT__statement____iteration_after_two", 2, {"tokenREPEAT","statement____iteration_after_two"}},\
    {"tokenREPEAT__statement", 2, {"tokenREPEAT","statement"}},\
    {"repeat_until_cycle", 2, {"tokenREPEAT__statement____iteration_after_two","tokenUNTIL__expression"}},\
    {"repeat_until_cycle", 2, {"tokenREPEAT__statement","tokenUNTIL__expression"}},\
    {"repeat_until_cycle", 2, {"tokenREPEAT","tokenUNTIL__expression"}},\
 \
    {"input__first_part", 2, {"tokenGET","tokenGROUPEXPRESSIONBEGIN"}},\
    {"input__second_part", 2, {"ident","tokenGROUPEXPRESSIONEND"}},\
    {"input", 2, {"input__first_part","input__second_part"}},\
\
    {"output__first_part", 2, {"tokenPUT","tokenGROUPEXPRESSIONBEGIN"}},\
    {"output__second_part", 2, {"expression","tokenGROUPEXPRESSIONEND"}},\
    {"output", 2, {"output__first_part","output__second_part"}},\
\
    {"statement", 2, {"ident","rl_expression"}},\
    {"statement", 2, {"lr_expression","ident"}},\
    {"statement", 2, {"tokenIF__tokenGROUPEXPRESSIONBEGIN__expression__tokenGROUPEXPRESSIONEND","body_for_true__body_for_false"}},\
    {"statement", 2, {"tokenIF__tokenGROUPEXPRESSIONBEGIN__expression__tokenGROUPEXPRESSIONEND","body_for_true"}},\
    {"statement", 2, {"tokenFOR__cycle_counter_init__tokenTO__cycle_counter_last_value","cycle_body__tokenSEMICOLON"}},\
    {"statement", 2, {"tokenWHILE__expression__statement_in_while_body____iteration_after_two","tokenEND__tokenWHILE"}},\
    {"statement", 2, {"tokenWHILE__expression__statement_in_while_body","tokenEND__tokenWHILE"}},\
    {"statement", 2, {"tokenWHILE__expression","tokenEND__tokenWHILE"}},\
    {"statement", 2, {"tokenREPEAT__statement____iteration_after_two","tokenUNTIL__expression"}},\
    {"statement", 2, {"tokenREPEAT__statement","tokenUNTIL__expression"}},\
    {"statement", 2, {"tokenREPEAT","tokenUNTIL__expression"}},\
    {"statement", 2, {"ident","tokenCOLON"}},\
    {"statement", 2, {"tokenGOTO","ident"}},\
    {"statement", 2, {"input__first_part","input__second_part"}},\
    {"statement", 2, {"output__first_part","output__second_part"}},\
    {"statement____iteration_after_two", 2, {"statement","statement____iteration_after_two"}},\
    {"statement____iteration_after_two", 2, {"statement","statement"}},\
\
    {"statement_in_while_body", 2, {"ident","rl_expression"}},\
    {"statement_in_while_body", 2, {"lr_expression","ident"}},\
    {"statement_in_while_body", 2, {"tokenIF__tokenGROUPEXPRESSIONBEGIN__expression__tokenGROUPEXPRESSIONEND","body_for_true__body_for_false"}},\
    {"statement_in_while_body", 2, {"tokenIF__tokenGROUPEXPRESSIONBEGIN__expression__tokenGROUPEXPRESSIONEND","body_for_true"}},\
    {"statement_in_while_body", 2, {"tokenFOR__cycle_counter_init__tokenTO__cycle_counter_last_value","cycle_body__tokenSEMICOLON"}},\
    {"statement_in_while_body", 2, {"tokenWHILE__expression__statement_in_while_body____iteration_after_two","tokenEND__tokenWHILE"}},\
    {"statement_in_while_body", 2, {"tokenWHILE__expression__statement_in_while_body","tokenEND__tokenWHILE"}},\
    {"statement_in_while_body", 2, {"tokenWHILE__expression","tokenEND__tokenWHILE"}},\
    {"statement_in_while_body", 2, {"tokenREPEAT__statement____iteration_after_two","tokenUNTIL__expression"}},\
    {"statement_in_while_body", 2, {"tokenREPEAT__statement","tokenUNTIL__expression"}},\
    {"statement_in_while_body", 2, {"tokenREPEAT","tokenUNTIL__expression"}},\
    {"statement_in_while_body", 2, {"ident","tokenCOLON"}},\
    {"statement_in_while_body", 2, {"tokenGOTO","ident"}},\
    {"statement_in_while_body", 2, {"input__first_part","input__second_part"}},\
    {"statement_in_while_body", 2, {"output__first_part","output__second_part"}},\
    {"statement_in_while_body", 2, {"tokenCONTINUE","tokenWHILE"}},\
    {"statement_in_while_body", 2, {"tokenEXIT","tokenWHILE"}},\
    {"statement_in_while_body____iteration_after_two", 2, {"statement_in_while_body","statement_in_while_body____iteration_after_two"}},\
    {"statement_in_while_body____iteration_after_two", 2, {"statement_in_while_body","statement_in_while_body"}},\
\
    {"tokenNAME__program_name", 2, {"tokenNAME","program_name"}},\
    {"tokenSEMICOLON__tokenBODY", 2, {"tokenSEMICOLON","tokenBODY"}},\
    {"tokenDATA__declaration", 2, {"tokenDATA","declaration"}},\
    {"tokenNAME__program_name__tokenSEMICOLON__tokenBODY", 2, {"tokenNAME__program_name","tokenSEMICOLON__tokenBODY"}},\
    {"program____part1", 2, {"tokenNAME__program_name__tokenSEMICOLON__tokenBODY","tokenDATA__declaration"}},\
    {"program____part1", 2, {"tokenNAME__program_name__tokenSEMICOLON__tokenBODY","tokenDATA"}},\
    {"statement__tokenEND", 2, {"statement","tokenEND"}},\
    {"statement____iteration_after_two__tokenEND", 2, {"statement____iteration_after_two","tokenEND"}},\
    {"program____part2", 2, {"tokenSEMICOLON","statement____iteration_after_two__tokenEND"}},\
    {"program____part2", 2, {"tokenSEMICOLON","statement__tokenEND"}},\
    {"program____part2", 2, {"tokenSEMICOLON","tokenEND"}},\
    {"program", 2, {"program____part1","program____part2"}},\
\
    {"tokenCOLON", 1, {":"}},\
    {"tokenGOTO", 1, {"GOTO"}},\
    {"tokenINTEGER16", 1, {"INTEGER16"}},\
    {"tokenCOMMA", 1, {","}},\
    {"tokenNOT", 1, {"NOT"}},\
    {"tokenAND", 1, {"AND"}},\
    {"tokenOR", 1, {"OR"}},\
    {"tokenEQUAL", 1, {"=="}},\
    {"tokenNOTEQUAL", 1, {"!="}},\
    {"tokenLESSOREQUAL", 1, {"<="}},\
    {"tokenGREATEROREQUAL", 1, {">="}},\
    {"tokenPLUS", 1, {"+"}},\
    {"tokenMINUS", 1, {"-"}},\
    {"tokenMUL", 1, {"*"}},\
    {"tokenDIV", 1, {"DIV"}},\
    {"tokenMOD", 1, {"MOD"}},\
    {"tokenGROUPEXPRESSIONBEGIN", 1, {"("}},\
    {"tokenGROUPEXPRESSIONEND", 1, {")"}},\
    {"tokenRLBIND", 1, {"<<"}},\
    {"tokenLRBIND", 1, {">>"}},\
    {"tokenELSE", 1, {"ELSE"}},\
    {"tokenIF", 1, {"IF"}},\
    {"tokenDO", 1, {"DO"}},\
    {"tokenFOR", 1, {"FOR"}},\
    {"tokenTO", 1, {"TO"}},\
    {"tokenWHILE", 1, {"WHILE"}},\
    {"tokenCONTINUE", 1, {"CONTINUE"}},\
    {"tokenEXIT", 1, {"EXIT"}},\
    {"tokenREPEAT", 1, {"REPEAT"}},\
    {"tokenUNTIL", 1, {"UNTIL"}},\
    {"tokenGET", 1, {"GET"}},\
    {"tokenPUT", 1, {"PUT"}},\
    {"tokenNAME", 1, {"NAME"}},\
    {"tokenBODY", 1, {"BODY"}},\
    {"tokenDATA", 1, {"DATA"}},\
    {"tokenEND", 1, {"END"}},\
    {"tokenSEMICOLON", 1, {";"}},\
\
    {"value", 1, {"value_terminal"}},\
\
    {"ident", 1, {"ident_terminal"}},\
\
    {"", 2, {"",""}}\
\
},\
176,\
"program"