/**
 * @file AlpineJs grammar for tree-sitter
 * @author Assem Alwaseai <assemcc2022@gmail.com>
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "alpinejs",

  rules: {
    // TODO: add the actual grammar rules
    source_file: $ => "hello"
  }
});
