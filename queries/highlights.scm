; Directives like x-data, x-show
(alpine_directive) @keyword

; Shorthands like @click, :class
(alpine_shorthand) @keyword

; Specifically highlight the event name in a shorthand
(alpine_shorthand
  (event_name) @function)

; Specifically highlight the attribute name in a bind shorthand
(alpine_shorthand
  (attribute_name) @property)

; Highlight the directive name in x-on, x-bind, etc.
(x_on
  (event_name) @function)
(x_bind
  (attribute_name) @property)
(x_transition
  (transition_name) @property)
