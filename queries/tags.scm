; An element with x-data is a component definition.
(element
  (start_tag
    (tag_name) @name
    (alpine_attribute (alpine_directive (x_data))))) @definition.component

; Shorthand event handlers are method definitions.
(alpine_attribute
  (alpine_shorthand (event_name) @name)) @definition.method
