return {
  "tzachar/highlight-undo.nvim",
  keys = { "u", "U" },
  event = "BufRead",
  opts = function()
    return {
      hlgroup = "HighlightUndo",
      duration = 300,
    }
  end,
}
