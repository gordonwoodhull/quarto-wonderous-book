// Quarto-managed appendix state
// wonderous-book doesn't have appendix support, so we handle it separately for Quarto books
#let quarto-appendix-state = state("quarto-appendix", false)

// Helper to check appendix mode
#let quarto-in-appendix() = quarto-appendix-state.get()

// Chapter-based numbering for books with appendix support
// Note: bookly handles most numbering internally via its states, these are for Quarto elements
#let quarto-equation-numbering = it => {
  let pattern = if quarto-in-appendix() { "(A.1)" } else { "(1.1)" }
  numbering(pattern, counter(heading).get().first(), it)
}

#let quarto-callout-numbering = it => {
  let pattern = if quarto-in-appendix() { "A.1" } else { "1.1" }
  numbering(pattern, counter(heading).get().first(), it)
}

#let quarto-subfloat-numbering(n-super, subfloat-idx) = {
  let chapter = counter(heading).get().first()
  let pattern = if quarto-in-appendix() { "A.1a" } else { "1.1a" }
  numbering(pattern, chapter, n-super, subfloat-idx)
}

// Theorem configuration for theorion
// Chapter-based numbering (H1 = chapters)
#let quarto-theorem-inherited-levels = 1

// Appendix-aware theorem numbering
#let quarto-theorem-numbering(loc) = {
  if quarto-appendix-state.at(loc) { "A.1" } else { "1.1" }
}

// Theorem render function
// Note: brand-color is not available at this point in template processing
#let quarto-theorem-render(prefix: none, title: "", full-title: auto, body) = {
  block(
    width: 100%,
    inset: (left: 1em),
    stroke: (left: 2pt + black),
  )[
    #if full-title != "" and full-title != auto and full-title != none {
      strong[#full-title]
      linebreak()
    }
    #body
  ]
}

// Chapter-based figure numbering for Quarto's custom float kinds
// Wonderous-book's built-in numbering may not cover Quarto's custom kinds
// (quarto-float-fig, quarto-float-tbl, etc.), so we apply this globally
#let quarto-figure-numbering(num) = {
  let chapter = counter(heading).get().first()
  let pattern = if quarto-in-appendix() { "A.1" } else { "1.1" }
  numbering(pattern, chapter, num)
}
