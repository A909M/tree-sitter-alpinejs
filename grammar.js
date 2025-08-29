/**
 * @file AlpineJs grammar for tree-sitter
 * @author Assem Alwaseai <assemcc2022@gmail.com>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "alpinejs",

  extras: $ => [/\s+/],

  rules: {
    // Start with the most basic HTML structure
    document: $ => repeat(choice(
      $.element,
      $.text
    )),

    // Basic HTML element: <div>content</div> or <input />
    element: $ => choice(
      // Regular element with content
      seq(
        $.start_tag,
        repeat(choice($.element, $.text)),
        $.end_tag
      ),
      // Self-closing element  
      $.self_closing_tag
    ),

    start_tag: $ => seq(
      '<',
      $.tag_name,
      repeat($.attribute),
      '>'
    ),

    // Context-aware attributes: Alpine vs regular HTML
    attribute: $ => choice(
      $.alpine_attribute,
      $.regular_attribute
    ),

    alpine_attribute: $ => seq(
      choice($.alpine_directive, $.alpine_shorthand),
      optional(seq('=', $.alpine_attribute_value))
    ),

    regular_attribute: $ => seq(
      $.regular_attribute_name,
      optional(seq('=', $.regular_attribute_value))
    ),

    // Alpine.js directive like x-data, x-show, x-on:click (higher precedence)
    alpine_directive: $ => /x-[a-zA-Z][a-zA-Z0-9-]*(:[\w.-]+)?/,

    // Alpine.js shorthand: @click for x-on:click, :class for x-bind:class
    alpine_shorthand: $ => choice(
      /[@][a-zA-Z][a-zA-Z0-9.-]*/,  // @click, @submit.prevent
      /[:][a-zA-Z][a-zA-Z0-9.-]*/   // :class, :disabled
    ),

    // Regular HTML attribute names (lower precedence for conflicts)  
    regular_attribute_name: $ => /[a-zA-Z][a-zA-Z0-9-]*/,

    // Alpine attribute values contain Alpine expressions
    alpine_attribute_value: $ => choice(
      seq('"', $.alpine_expression, '"'),
      seq("'", $.alpine_expression, "'")
    ),

    // Regular attribute values are plain text
    regular_attribute_value: $ => choice(
      seq('"', /[^"]*/, '"'),
      seq("'", /[^']*/, "'"),
      /[^<>"'=\s]+/  // unquoted
    ),


    // Simple Alpine.js expressions 
    alpine_expression: $ => choice(
      $.object_literal,
      $.postfix_expression,
      $.identifier
    ),

    // Simple object: { count: 0, name: "test" }
    object_literal: $ => seq(
      '{',
      optional(seq(
        $.object_property,
        repeat(seq(',', $.object_property))
      )),
      '}'
    ),

    object_property: $ => seq(
      $.identifier,
      ':',
      choice($.identifier, $.number, $.string_literal)
    ),

    identifier: $ => /[a-zA-Z_$][a-zA-Z0-9_$]*/,
    number: $ => /\d+/,
    string_literal: $ => choice(
      seq('"', /[^"]*/, '"'),
      seq("'", /[^']*/, "'")
    ),

    // Postfix expressions like count++, count--
    postfix_expression: $ => seq(
      $.identifier,
      choice('++', '--')
    ),

    end_tag: $ => seq(
      '</',
      $.tag_name,
      '>'
    ),

    self_closing_tag: $ => seq(
      '<',
      $.tag_name,
      repeat($.attribute),
      '/>'
    ),

    tag_name: $ => /[a-zA-Z][a-zA-Z0-9-]*/,

    text: $ => /[^<]+/
  }
});
