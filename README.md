# tree-sitter-alpinejs

Alpine.js grammar for [tree-sitter](https://github.com/tree-sitter/tree-sitter).

> [!WARNING]
>
> Please note that this project is a hobby project and still in development.
> It’s currently not functional nor ready for use.


## Install

```bash
npm install tree-sitter-alpinejs
```

## Usage

```javascript
const Parser = require('tree-sitter');
const AlpineJS = require('tree-sitter-alpinejs');

const parser = new Parser();
parser.setLanguage(AlpineJS);

const code = `<div x-data="{ count: 0 }">
  <button @click="count++">Click me</button>
</div>`;

const tree = parser.parse(code);
```

## Syntax Supported

- Alpine.js directives: `x-data`, `x-show`, `x-text`, etc.
- Shorthand syntax: `@click`, `:class`, etc.  
- JavaScript expressions within Alpine attributes
- HTML structure with Alpine.js enhancements

## Queries

This grammar includes queries for:

- `highlights.scm` - Syntax highlighting
- `injections.scm` - JavaScript injection into Alpine expressions  
- `locals.scm` - Local variable scoping
- `tags.scm` - Code navigation

## License

MIT