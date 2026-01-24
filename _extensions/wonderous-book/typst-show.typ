// Import wonderous-book template
#import "@preview/wonderous-book:0.1.2": book

// Apply wonderous-book template
// Note: The template handles its own outline (table of contents)
#show: book.with(
  title: "Book Title",
  author: "Author",
)

// Enable heading numbering for chapters (required for Quarto cross-references)
// wonderous-book sets this inside body scope, but we need it globally for refs
#set heading(numbering: "1.")
