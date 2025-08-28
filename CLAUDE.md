# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Tree-sitter grammar for AlpineJS, a lightweight JavaScript framework. The project provides language bindings for multiple platforms (C, Go, Node.js, Python, Rust, Swift) and is currently in early development (v0.1.0).

## Core Architecture

- **`grammar.js`**: Main grammar definition file where Tree-sitter parsing rules are defined. Currently contains placeholder rules that need implementation.
- **`src/`**: Generated C parser code (created by `tree-sitter generate`)
- **`bindings/`**: Language-specific bindings for different platforms:
  - `node/`: Node.js bindings with TypeScript definitions
  - `python/`: Python package with proper module structure
  - `c/`, `go/`, `rust/`, `swift/`: Platform-specific bindings
- **`queries/`**: Tree-sitter query files for syntax highlighting and code analysis (not yet created)

## Essential Commands

### Development
```bash
# Generate parser from grammar.js
tree-sitter generate

# Test the grammar
tree-sitter test
make test

# Launch interactive playground
npm run start
# (runs: tree-sitter build --wasm && tree-sitter playground)
```

### Building
```bash
# Build C library
make

# Build Node.js bindings
npm install

# Build Python package
pip install -e .

# Build Rust bindings
cargo build
```

### Testing
```bash
# Test Node.js bindings
npm test
# (runs: node --test bindings/node/*_test.js)

# Test Python bindings
python -m pytest bindings/python/tests/

# Test grammar rules
tree-sitter test
```

## Grammar Development

The grammar is defined in `grammar.js` using Tree-sitter's DSL. Currently contains only a placeholder rule. When developing:

1. Define parsing rules in `grammar.js`
2. Run `tree-sitter generate` to create C parser
3. Test with `tree-sitter test` or the playground
4. Add test cases in `test/corpus/` directory (when created)
5. Create syntax highlighting queries in `queries/` directory

## Multi-Language Support

This project supports 6 language bindings. When making changes:
- C bindings are generated automatically
- Node.js bindings use `node-gyp-build` for native compilation
- Python bindings use setuptools with C extensions
- Go, Rust, and Swift bindings have their own build systems
- Each binding has its own test suite that should pass

## Tree-sitter Configuration

The `tree-sitter.json` file defines:
- Grammar metadata (scope: `source.alpinejs`)
- File type associations
- Injection patterns for embedded usage
- Language bindings configuration