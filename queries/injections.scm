; ============================================================================
; Alpine.js Tree-sitter Injection Queries  
; ============================================================================
; These queries define where JavaScript should be injected for syntax 
; highlighting and IntelliSense within Alpine.js expressions.

; ============================================================================
; Alpine Directive Injections
; ============================================================================

; Inject JavaScript into x-data expressions
; Examples: x-data="{ count: 0, items: [] }"
((alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression) @injection.content))
  (#match? @_directive "^x-data$")
  (#set! injection.language "javascript")
  (#set! injection.include-children))

; Inject JavaScript into x-show/x-if expressions  
; Examples: x-show="isVisible", x-if="count > 0"
((alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression) @injection.content))
  (#match? @_directive "^x-(show|if|text|html|model)$")  
  (#set! injection.language "javascript")
  (#set! injection.include-children))

; Inject JavaScript into x-for expressions
; Examples: x-for="item in items"
((alpine_attribute
  (alpine_directive) @_directive
  (alpine_attribute_value
    (alpine_expression) @injection.content))
  (#match? @_directive "^x-for$")
  (#set! injection.language "javascript")
  (#set! injection.include-children))

; ============================================================================
; Alpine Shorthand Injections
; ============================================================================

; Inject JavaScript into event handlers (@click, @submit, etc.)
; Examples: @click="count++", @submit.prevent="handleSubmit()"
((alpine_attribute
  (alpine_shorthand) @_shorthand
  (alpine_attribute_value
    (alpine_expression) @injection.content))
  (#match? @_shorthand "^@")
  (#set! injection.language "javascript")
  (#set! injection.include-children))

; Inject JavaScript into data binding (:class, :disabled, etc.)  
; Examples: :class="isActive ? 'active' : ''", :disabled="loading"
((alpine_attribute
  (alpine_shorthand) @_shorthand
  (alpine_attribute_value
    (alpine_expression) @injection.content))
  (#match? @_shorthand "^:")
  (#set! injection.language "javascript")
  (#set! injection.include-children))

; ============================================================================
; Complex Expression Injections
; ============================================================================

; Inject JavaScript into object literals within Alpine expressions
; This provides proper JS highlighting for complex data structures
(object_literal) @injection.content
  (#set! injection.language "javascript")
  (#set! injection.include-children)

; Inject JavaScript into postfix expressions (count++, items--)
(postfix_expression) @injection.content  
  (#set! injection.language "javascript")
  (#set! injection.include-children)

; ============================================================================
; Special Alpine.js Patterns
; ============================================================================

; Handle Alpine magic properties ($el, $refs, $store, etc.)
; These should be treated as JavaScript but with Alpine-specific context
((alpine_attribute_value
  (alpine_expression
    (identifier) @injection.content))
  (#match? @injection.content "^\\$")
  (#set! injection.language "javascript")
  (#set! injection.include-children))

; ============================================================================
; Template Literals and Complex Expressions
; ============================================================================

; Future: Template literal support for advanced Alpine expressions  
; This will be useful when we extend the grammar to support template strings

; Future: Function call support
; For expressions like x-data="{ init() { this.count = 0; } }"