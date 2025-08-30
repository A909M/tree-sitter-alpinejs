/**
 * @file AlpineJs grammar for tree-sitter
 * @author Assem Alwaseai <assemcc2022@gmail.com>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

const HTML = require("tree-sitter-html/grammar");

module.exports = grammar(HTML, {
  name: "alpinejs",

  conflicts: $ => [
    [$.x_bind],
    [$.x_on],
    [$.x_transition],
  ],

  rules: {
    // Override the original attribute rule to have a stricter name
    attribute: $ => seq(
      alias(/[a-zA-Z_][a-zA-Z_0-9-]*/, $.attribute_name),
      optional(seq(
        '=',
        choice(
          $.attribute_value,
          $.quoted_attribute_value
        )
      ))
    ),

    start_tag: ($, original) => seq(
        '<',
        alias($._start_tag_name, $.tag_name),
        repeat(choice($.alpine_attribute, $.attribute)),
        '>',
    ),

    self_closing_tag: ($, original) => seq(
        '<',
        alias($._start_tag_name, $.tag_name),
        repeat(choice($.alpine_attribute, $.attribute)),
        '/>',
    ),

    alpine_attribute: $ => seq(
      choice(
        $.alpine_directive,
        $.alpine_shorthand
      ),
      optional(seq(
        '=',
        choice(
          $.quoted_attribute_value,
          $.attribute_value
        )
      ))
    ),

    alpine_directive: $ => choice(
      $.x_data,
      $.x_show,
      $.x_bind,
      $.x_on,
      $.x_text,
      $.x_html,
      $.x_model,
      $.x_if,
      $.x_for,
      $.x_transition,
      $.x_effect,
      $.x_ignore,
      $.x_ref,
      $.x_cloak,
      $.x_init,
      $.x_teleport,
      $.x_id
    ),

    x_data: $ => 'x-data',
    x_show: $ => 'x-show',
    x_text: $ => 'x-text',
    x_html: $ => 'x-html',
    x_model: $ => 'x-model',
    x_if: $ => 'x-if',
    x_for: $ => 'x-for',
    x_effect: $ => 'x-effect',
    x_ignore: $ => 'x-ignore',
    x_ref: $ => 'x-ref',
    x_cloak: $ => 'x-cloak',
    x_init: $ => 'x-init',
    x_teleport: $ => 'x-teleport',
    x_id: $ => 'x-id',

    x_bind: $ => seq('x-bind', optional(seq(':', alias(/[^= >]+/, $.attribute_name)))),
    x_on: $ => seq('x-on', optional(seq(':', alias(/[^= >]+/, $.event_name)))),
    x_transition: $ => seq('x-transition', optional(seq(':', alias(/[^= >]+/, $.transition_name)))),

    alpine_shorthand: $ => choice(
      // @event
      seq(
        '@',
        alias(/[^= >]+/, $.event_name)
      ),
      // :binding
      seq(
        ':',
        alias(/[^= >]+/, $.attribute_name)
      )
    )
  }
});