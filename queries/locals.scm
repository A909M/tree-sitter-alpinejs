; ============================================================================
; Alpine.js Tree-sitter Local Variable Queries
; ============================================================================
; These queries define scopes, variable definitions, and references for
; Alpine.js reactive data and component boundaries.

; ============================================================================
; Alpine Component Scopes
; ============================================================================

; Alpine components (elements with x-data) define local scopes
; Everything inside the element can access the data defined in x-data
(element
  (start_tag
    (attribute
      (alpine_attribute
        (alpine_directive) @_directive
        (alpine_attribute_value))))
  (#match? @_directive "^x-data$")) @local.scope

; Self-closing Alpine components also define scopes
((element  
  (self_closing_tag
    (attribute
      (alpine_attribute
        (alpine_directive) @_directive  
        (alpine_attribute_value)))))
  (#match? @_directive "^x-data$")) @local.scope

; ============================================================================
; Variable Definitions (Alpine Data Properties)
; ============================================================================

; Properties defined in x-data object literals are local definitions
; Example: x-data="{ count: 0, name: 'test' }"
(alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression
      (object_literal
        (object_property
          (identifier) @local.definition))))
  (#match? @_directive "^x-data$"))

; x-for loop variables are local definitions within their scope
; Example: x-for="item in items" - 'item' is a local definition
(alpine_attribute  
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression
      (identifier) @local.definition))
  (#match? @_directive "^x-for$"))

; ============================================================================
; Variable References
; ============================================================================

; All identifiers in Alpine expressions are potential references
; to data properties or loop variables
(alpine_expression
  (identifier) @local.reference)

; Identifiers in postfix expressions (count++, item--)
(postfix_expression
  (identifier) @local.reference)

; Identifiers in object property values
(object_property
  (identifier) @local.reference)

; ============================================================================
; Alpine Magic Properties ($el, $refs, etc.)
; ============================================================================

; Alpine magic properties are special global references
; They don't follow normal scoping rules but should be tracked
((identifier) @local.reference.magic
  (#match? @local.reference.magic "^\\$(el|refs|store|watch|dispatch|nextTick|root|data|id)$"))

; ============================================================================
; Event Handler Scopes
; ============================================================================

; Event handlers create their own micro-scopes for event parameters
; Example: @click="(event) => handleClick(event)"
; Note: This will be more relevant when we add function expression support

; ============================================================================
; Alpine Directive Context
; ============================================================================

; x-model creates two-way binding references
(alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression
      (identifier) @local.reference.binding))
  (#match? @_directive "^x-model$"))

; x-show, x-if expressions reference data for conditional rendering
(alpine_attribute
  (alpine_directive) @_directive  
  (alpine_attribute_value
    (alpine_expression
      (identifier) @local.reference.conditional))
  (#match? @_directive "^x-(show|if)$"))

; x-text, x-html expressions reference data for content display  
(alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression  
      (identifier) @local.reference.content))
  (#match? @_directive "^x-(text|html)$"))

; ============================================================================
; Shorthand References  
; ============================================================================

; Event handler references (@click, @submit, etc.)
(alpine_attribute
  (alpine_shorthand) @_shorthand
  (alpine_attribute_value
    (alpine_expression
      (identifier) @local.reference.event))
  (#match? @_shorthand "^@"))

; Data binding references (:class, :disabled, etc.)
(alpine_attribute
  (alpine_shorthand) @_shorthand
  (alpine_attribute_value
    (alpine_expression
      (identifier) @local.reference.binding))
  (#match? @_shorthand "^:"))

; ============================================================================
; Nested Component Handling
; ============================================================================

; When Alpine components are nested, inner components can access
; outer component data through Alpine's natural scoping
; The tree-sitter local scope system should handle this automatically
; with our @local.scope definitions above