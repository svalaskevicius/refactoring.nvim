---@module "mini.test"

local child = MiniTest.new_child_neovim()

local expect, eq = MiniTest.expect, MiniTest.expect.equality

---@type {[string]: any|{[string]: any}}
local T = MiniTest.new_set {
  hooks = {
    pre_case = function()
      child.restart { "-u", "scripts/minimal_init.lua" }
      child.bo.readonly = false
      -- NOTE: we use `vim.notify` to show warnings to users, this makes
      -- it easier to catch them with mini.test
      child.lua "vim.notify = function(msg, level) if level == vim.log.levels.ERROR then error(msg) end end"
    end,
    post_once = child.stop,
  },
}

---@param lines string
local set_lines = function(lines)
  child.api.nvim_buf_set_lines(0, 0, -1, true, vim.split(lines, "\n"))
end

local get_lines = function()
  return child.api.nvim_buf_get_lines(0, 0, -1, true)
end

---@param row integer
---@param col integer
local set_cursor = function(row, col)
  child.api.nvim_win_set_cursor(0, { row, col })
end

---@param lines string
---@param cursor {[1]: integer, [2]: integer}
---@param expected_lines string
local function validate(lines, cursor, expected_lines)
  set_lines(lines)
  set_cursor(cursor[1], cursor[2])
  -- NOTE: some LSP servers (e.g. metals) take a while to start, so wait for the
  -- client to attach before triggering the refactor
  child.lua [[vim.wait(30000, function() return #vim.lsp.get_clients({ bufnr = 0 }) == 1  end)]]
  child.type_keys " ai"
  -- NOTE: wait for the buffer to reflect the refactor instead of a fixed sleep,
  -- as LSP round-trips (e.g. with metals) can take several seconds
  vim.wait(60000, function()
    return vim.deep_equal(get_lines(), vim.split(expected_lines, "\n"))
  end, 100)
  eq(get_lines(), vim.split(expected_lines, "\n"))
end

---@param path string
---@return string
local function read_file(path)
  local file = io.open(path)
  assert(file)
  local lines = file:read "*a"
  -- NOTE: remove trailling newline to avoid issues when splitting by newlines
  lines = lines:gsub("\n$", "") ---@type string

  return lines
end

T["lua"] = MiniTest.new_set {
  hooks = {
    pre_case = function()
      child.lua [[
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'lua',
  command = 'setlocal expandtab shiftwidth=2'
})
]]
    end,
  },
}

T["lua"]["simple assignment"] = function()
  local lines = read_file "./tests/files/inline_var_simple_assignment_before.lua"
  local expected_lines = read_file "./tests/files/inline_var_simple_assignment_after.lua"

  child.cmd "edit tmp.lua"
  validate(lines, { 1, 6 }, expected_lines)
end

T["lua"]["multiple assignment"] = function()
  local lines = read_file "./tests/files/inline_var_multiple_assignment_before.lua"
  local expected_lines = read_file "./tests/files/inline_var_multiple_assignment_after.lua"

  child.cmd "edit tmp.lua"
  validate(lines, { 1, 6 }, expected_lines)
end

-- TODO: maybe the comment should also be deleted
T["lua"]["filters LSP definitions without a Treesitter match"] = function()
  local lines = read_file "./tests/files/inline_var_filters_LSP_definitions_without_a_Treesitter_match_before.lua"
  local expected_lines =
    read_file "./tests/files/inline_var_filters_LSP_definitions_without_a_Treesitter_match_after.lua"

  child.cmd "edit tmp.lua"
  validate(lines, { 2, 6 }, expected_lines)
end

T["lua"]["orders references text edits backwards"] = function()
  local lines = read_file "./tests/files/inline_var_orders_references_text_edits_backwards_before.lua"
  local expected_lines = read_file "./tests/files/inline_var_orders_references_text_edits_backwards_after.lua"

  child.cmd "edit tmp.lua"
  validate(lines, { 1, 6 }, expected_lines)
end

T["c"] = MiniTest.new_set {
  hooks = {
    pre_case = function()
      child.lua [[
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'c',
  command = 'setlocal expandtab shiftwidth=2'
})
]]
    end,
  },
}

T["c"]["multiple assignment"] = function()
  local lines = read_file "./tests/files/inline_var_multiple_assignment_before.c"
  local expected_lines = read_file "./tests/files/inline_var_multiple_assignment_after.c"

  child.cmd "edit tmp.c"
  validate(lines, { 4, 8 }, expected_lines)
end

T["python"] = MiniTest.new_set {
  hooks = {
    pre_case = function()
      child.lua [[
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'python',
  command = 'setlocal expandtab shiftwidth=4'
})
]]
    end,
  },
}

T["python"]["comparison operator"] = function()
  local lines = read_file "./tests/files/inline_var_comparison_operator_before.py"
  local expected_lines = read_file "./tests/files/inline_var_comparison_operator_after.py"

  child.cmd "edit tmp.py"
  validate(lines, { 2, 4 }, expected_lines)
end

T["scala"] = MiniTest.new_set {
  hooks = {
    pre_case = function()
      child.lua [[
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'scala',
  command = 'setlocal expandtab shiftwidth=2'
})
]]
    end,
  },
}

T["scala"]["comparison operator"] = function()
  local lines = read_file "./tests/files/inline_var_comparison_operator_before.scala"
  local expected_lines = read_file "./tests/files/inline_var_comparison_operator_after.scala"

  -- NOTE: metals reads the file from disk to answer LSP requests, so the
  -- buffer must point to a real file (an unsaved `tmp.scala` makes it fail
  -- with `NoSuchFileException`)
  child.cmd "edit ./tests/files/inline_var_comparison_operator_before.scala"
  -- NOTE: put the cursor on the usage, not the declaration: in standalone
  -- mode (no build tool) metals answers `textDocument/definition` at the
  -- declaration position with the usage location, which can't be matched
  -- back to a treesitter variable
  validate(lines, { 3, 2 }, expected_lines)
end

return T
