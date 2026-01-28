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

$if(margin-geometry)$
// Configure marginalia page geometry for book context
// Geometry computed by Quarto's meta.lua filter (typstGeometryFromPaperWidth)
// IMPORTANT: This must come AFTER book.with() to override wonderous-book's margin settings
#import "@preview/marginalia:0.3.1" as marginalia

#show: marginalia.setup.with(
  inner: (
    far: $margin-geometry.inner.far$,
    width: $margin-geometry.inner.width$,
    sep: $margin-geometry.inner.separation$,
  ),
  outer: (
    far: $margin-geometry.outer.far$,
    width: $margin-geometry.outer.width$,
    sep: $margin-geometry.outer.separation$,
  ),
  top: $if(margin.top)$$margin.top$$else$1.25in$endif$,
  bottom: $if(margin.bottom)$$margin.bottom$$else$1.25in$endif$,
  // CRITICAL: Enable book mode for recto/verso awareness
  book: true,
  clearance: $margin-geometry.clearance$,
)
$endif$

// Enable heading numbering for chapters (required for Quarto cross-references)
// wonderous-book sets this inside body scope, but we need it globally for refs
#set heading(numbering: "1.")

// Apply chapter-based numbering to all figures
// Wonderous-book may not number Quarto's custom figure kinds (quarto-float-fig, etc.)
#set figure(numbering: figure-numbering)
