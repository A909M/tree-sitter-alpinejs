; Injects JavaScript into Alpine.js attribute values.

; x-data contains a JavaScript object expression.
(
  (alpine_attribute
    (alpine_directive (x_data))
    (quoted_attribute_value
      (attribute_value) @injection.content))
  (#set! injection.language "javascript")
)

; Directives that contain a JavaScript expression to be evaluated.
(
  (alpine_attribute
    (alpine_directive
      [
        (x_show)
        (x_if)
        (x_text)
        (x_html)
        (x_model)
        (x_effect)
        (x_init)
        (x_teleport)
        (x_bind)
        (x_transition)
      ])
    (quoted_attribute_value
      (attribute_value) @injection.content))
  (#set! injection.language "javascript")
)

; x-on contains a JavaScript statement.
(
  (alpine_attribute
    (alpine_directive (x_on))
    (quoted_attribute_value
      (attribute_value) @injection.content))
  (#set! injection.language "javascript")
)

; Shorthand @ for x-on
(
  (alpine_attribute
    (alpine_shorthand) @shorthand
    (quoted_attribute_value
      (attribute_value) @injection.content))
  (#match? @shorthand "^@")
  (#set! injection.language "javascript")
)

; Shorthand : for x-bind
(
  (alpine_attribute
    (alpine_shorthand) @shorthand
    (quoted_attribute_value
      (attribute_value) @injection.content))
  (#match? @shorthand "^:")
  (#set! injection.language "javascript")
)

; x-for has a special "item in items" syntax.
(
  (alpine_attribute
    (alpine_directive (x_for))
    (quoted_attribute_value
      (attribute_value) @injection.content))
  (#set! injection.language "javascript")
)