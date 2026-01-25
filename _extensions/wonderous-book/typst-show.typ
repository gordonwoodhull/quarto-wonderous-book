// Import wonderous-book template
#import "@preview/wonderous-book:0.1.2": book

// Apply wonderous-book template
// Note: The template handles its own outline (table of contents)
#show: book.with(
$if(title)$
  title: [$title$],
$endif$
$if(by-author)$
  author: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
$endif$
)

// Enable heading numbering for chapters (required for Quarto cross-references)
// wonderous-book sets this inside body scope, but we need it globally for refs
#set heading(numbering: "1.")

// Apply chapter-based numbering to all figures
// Wonderous-book may not number Quarto's custom figure kinds (quarto-float-fig, etc.)
#set figure(numbering: figure-numbering)
