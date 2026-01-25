-- wonderous-book.lua
-- Wonderous-book-specific appendix handling for Typst books
--
-- Wonderous-book is a simple fiction book template without parts or appendix support.
-- For Quarto book integration, we manually set up appendix numbering.

local function is_typst_book()
  local file_state = quarto.doc.file_metadata()
  return quarto.doc.is_format("typst") and
         file_state ~= nil and
         file_state.file ~= nil
end

local header_filter = {
  Header = function(el)
    local file_state = quarto.doc.file_metadata()

    if not is_typst_book() then
      return nil
    end

    if file_state == nil or file_state.file == nil then
      return nil
    end

    local file = file_state.file
    local bookItemType = file.bookItemType

    -- Only handle H1 book items
    if el.level ~= 1 or bookItemType == nil then
      return nil
    end

    -- Handle parts: wonderous-book doesn't have parts, emit as unnumbered heading
    if bookItemType == "part" then
      return pandoc.RawBlock('typst',
        '#heading(level: 1, numbering: none)[' .. pandoc.utils.stringify(el.content) .. ']')
    end

    -- Handle appendices: manually set up appendix numbering
    if bookItemType == "appendix" then
      if file.bookItemNumber == 1 or file.bookItemNumber == nil then
        -- Update Quarto's appendix state for numbering
        local stateUpdate = pandoc.RawBlock('typst', '#appendix-state.update(true)')

        -- Reset heading counter and set up A.1.1 numbering format
        local appendixSetup = pandoc.RawBlock('typst', [[
#counter(heading).update(0)
#set heading(
  outlined: true,
  numbering: (..nums) => {
    let vals = nums.pos()
    if vals.len() > 0 {
      numbering("A.1.1.", ..vals)
    }
  }
)]])

        -- If this is the synthetic "Appendices" divider heading,
        -- emit a heading for TOC display
        if el.classes:includes("unnumbered") then
          local language = quarto.doc.language
          local appendicesTitle = (language and language["section-title-appendices"]) or "Appendices"
          local appendicesHeading = pandoc.RawBlock('typst',
            '#heading(level: 1, numbering: none)[' .. appendicesTitle .. ']')
          return {stateUpdate, appendicesHeading, appendixSetup}
        end

        -- First actual appendix chapter - emit setup before the heading
        return {stateUpdate, appendixSetup, el}
      end
    end

    return nil
  end
}

-- Combine with file_metadata_filter so book metadata markers are parsed
-- during this filter's document traversal (needed for bookItemType, etc.)
return quarto.utils.combineFilters({
  quarto.utils.file_metadata_filter(),
  header_filter
})
