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

#let quarto-thmbox-args = (base: "heading", base_level: 1)
