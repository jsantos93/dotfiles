return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  config = function()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>nn", "<cmd>NoNeckPain<CR>", { desc = "Toggles the plugin state, between enable and disable." }) 
  end,
}
