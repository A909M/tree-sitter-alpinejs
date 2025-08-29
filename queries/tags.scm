; ============================================================================
; Alpine.js Tree-sitter Tags Queries  
; ============================================================================
; These queries define symbols for code navigation (go-to-definition,
; find-references, symbol search) in Alpine.js applications.

; ============================================================================
; Alpine Component Definitions
; ============================================================================

; Alpine components (elements with x-data) are major navigation points
; They define the boundaries of Alpine reactive scopes
(element
  (start_tag
    (tag_name) @name
    (attribute
      (alpine_attribute
        (alpine_directive) @_directive)))
  (#match? @_directive "^x-data$")) @definition.component

; Self-closing Alpine components
(element
  (self_closing_tag  
    (tag_name) @name
    (attribute
      (alpine_attribute
        (alpine_directive) @_directive)))
  (#match? @_directive "^x-data$")) @definition.component

; ============================================================================
; Data Property Definitions
; ============================================================================

; Data properties defined in x-data objects
; These are the "variables" that Alpine.js components expose
(alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression
      (object_literal
        (object_property
          (identifier) @name))))
  (#match? @_directive "^x-data$")) @definition.property

; ============================================================================
; Alpine Directive Usage (References)
; ============================================================================

; x-show directive usage - references to conditional logic
(alpine_attribute
  (alpine_directive) @name
  (#match? @name "^x-show$")) @reference.directive

; x-if directive usage - references to conditional rendering
(alpine_attribute  
  (alpine_directive) @name
  (#match? @name "^x-if$")) @reference.directive

; x-for directive usage - references to list rendering  
(alpine_attribute
  (alpine_directive) @name
  (#match? @name "^x-for$")) @reference.directive

; x-model directive usage - references to two-way binding
(alpine_attribute
  (alpine_directive) @name  
  (#match? @name "^x-model$")) @reference.directive

; x-text/x-html directive usage - references to content binding
(alpine_attribute
  (alpine_directive) @name
  (#match? @name "^x-(text|html)$")) @reference.directive

; ============================================================================
; Event Handler Definitions
; ============================================================================

; Alpine event handlers using @ shorthand
; These are "methods" that handle user interactions
(alpine_attribute
  (alpine_shorthand) @name
  (#match? @name "^@[a-zA-Z]")) @definition.method

; ============================================================================
; Data Binding References  
; ============================================================================

; Alpine data binding using : shorthand
; These are references to reactive data properties
(alpine_attribute
  (alpine_shorthand) @name
  (#match? @name "^:[a-zA-Z]")) @reference.property

; ============================================================================
; Variable References in Expressions
; ============================================================================

; All identifiers in Alpine expressions are references
; to data properties, methods, or loop variables
(alpine_expression
  (identifier) @name) @reference.variable

; Postfix expression references (count++, item--)
(postfix_expression
  (identifier) @name) @reference.variable

; ============================================================================
; Magic Property References
; ============================================================================

; Alpine magic properties are special global references
; These provide access to Alpine's internal APIs
((alpine_expression
  (identifier) @name)
  (#match? @name "^\\$(el|refs|store|watch|dispatch|nextTick|root|data|id)$")) @reference.magic

; ============================================================================
; HTML Structure Navigation
; ============================================================================

; HTML elements with Alpine directives are important navigation points
; They show the structure of the Alpine application
(element
  (start_tag
    (tag_name) @name
    (attribute
      (alpine_attribute))))  @definition.element

; Self-closing elements with Alpine directives
(element
  (self_closing_tag
    (tag_name) @name  
    (attribute
      (alpine_attribute)))) @definition.element

; ============================================================================
; Loop Variable Definitions
; ============================================================================

; x-for creates local loop variables
; Example: x-for="item in items" - 'item' is a local definition
(alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression
      (identifier) @name))
  (#match? @_directive "^x-for$")) @definition.variable

; ============================================================================
; Template Boundaries
; ============================================================================

; x-if conditions create template boundaries  
; These are useful for understanding conditional rendering structure
(alpine_attribute
  (alpine_directive) @name
  (alpine_attribute_value) @definition.condition
  (#match? @name "^x-if$"))

; x-for loops create template boundaries
; These are useful for understanding list rendering structure  
(alpine_attribute
  (alpine_directive) @name
  (alpine_attribute_value) @definition.loop
  (#match? @name "^x-for$"))

; ============================================================================
; Component Interaction Points
; ============================================================================

; x-model creates two-way data flow points
; These are important for understanding data synchronization
(alpine_attribute
  (alpine_directive) @name
  (alpine_attribute_value
    (alpine_expression
      (identifier) @property))
  (#match? @name "^x-model$")) @definition.binding