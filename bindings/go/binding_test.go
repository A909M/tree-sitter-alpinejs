package tree_sitter_alpinejs_test

import (
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_alpinejs "github.com/a909m/tree-sitter-alpinejs/bindings/go"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_alpinejs.Language())
	if language == nil {
		t.Errorf("Error loading Alpinejs grammar")
	}
}
