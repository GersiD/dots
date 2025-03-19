return {
  'hat0uma/csvview.nvim',
  ---@module "csvview"
  ---@type CsvView.Options
  opts = {
    parser = { comments = { '#', '//' } },
    keymaps = {
      -- Text objects for selecting fields
      textobject_field_inner = { 'ic', mode = { 'o', 'x' } },
      textobject_field_outer = { 'ac', mode = { 'o', 'x' } },
      -- Excel-like navigation:
      -- Use <Tab> and <S-Tab> to move horizontally between fields.
      -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
      -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
      jump_next_field_end = { '', mode = {} },
      jump_prev_field_end = { '', mode = {} },
      jump_next_row = { '', mode = {} },
      jump_prev_row = { '', mode = {} },
    },
    view = {
      min_column_width = 2,
      spacing = 2,
      display_mode = 'border',
    },
  },
  cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
}
