vim.keymap.set('n', '<leader>1', function()
  require('config.utils.terminals').run(
    'cargo build --release ; time cargo run --release',
    { direction = 'float', normal_on_open = true }
  )
end, { desc = 'Run Rust Proj', buffer = true })
vim.keymap.set('n', '<leader>2', function()
  require('config.utils.terminals').run('time cargo test', { direction = 'float', normal_on_open = false })
end, { desc = 'Run Rust Proj', buffer = true })
