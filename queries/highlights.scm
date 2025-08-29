; ============================================================================
; Alpine.js Tree-sitter Syntax Highlighting Queries
; ============================================================================

; Alpine directives (x-data, x-show, x-text, etc.)
(alpine_directive) @attribute.alpine

; Alpine shorthand (@click, :class, etc.)  
(alpine_shorthand) @attribute.alpine.shorthand

; HTML structure
(tag_name) @tag

; Regular HTML attributes
(regular_attribute_name) @attribute

; String literals in HTML attributes  
(regular_attribute_value
  "\"" @punctuation.delimiter
  "\"" @punctuation.delimiter)
(regular_attribute_value 
  "'" @punctuation.delimiter
  "'" @punctuation.delimiter)

; ============================================================================
; Alpine.js Expressions (JavaScript-like syntax)
; ============================================================================

; Object literals: { count: 0, name: 'test' }
(object_literal
  "{" @punctuation.bracket
  "}" @punctuation.bracket)

(object_property
  (identifier) @property
  ":" @punctuation.delimiter)

; Alpine expression delimiters
(alpine_attribute_value
  "\"" @punctuation.delimiter
  "\"" @punctuation.delimiter)
(alpine_attribute_value
  "'" @punctuation.delimiter  
  "'" @punctuation.delimiter)

; Identifiers and variables
(identifier) @variable

; Numbers
(number) @number

; String literals within Alpine expressions
(string_literal
  "\"" @punctuation.delimiter
  "\"" @punctuation.delimiter) @string
(string_literal
  "'" @punctuation.delimiter
  "'" @punctuation.delimiter) @string

; Postfix operators (count++, count--)
(postfix_expression
  (identifier) @variable
  ["++" "--"] @operator)

; Object property access
(object_property
  ":" @punctuation.delimiter)

; Comma separators in objects
"," @punctuation.delimiter

; ============================================================================
; HTML Keywords and Special Cases
; ============================================================================

; Self-closing tag syntax
(self_closing_tag
  "<" @punctuation.bracket
  "/>" @punctuation.bracket)

; Regular tag syntax  
(start_tag
  "<" @punctuation.bracket
  ">" @punctuation.bracket)
(end_tag
  "</" @punctuation.bracket
  ">" @punctuation.bracket)

; Attribute assignment
"=" @operator

; ============================================================================  
; Alpine.js Specific Highlighting
; ============================================================================

; Highlight Alpine directive names with special styling
((alpine_directive) @keyword.alpine
  (#match? @keyword.alpine "^x-(data|show|text|html|if|for|model|cloak|transition)$"))

; Highlight Alpine event handlers  
((alpine_shorthand) @function.alpine
  (#match? @function.alpine "^@"))

; Highlight Alpine data binding
((alpine_shorthand) @variable.alpine  
  (#match? @variable.alpine "^:"))

; ============================================================================
; Text Content
; ============================================================================

; Plain text content
(text) @string.plain