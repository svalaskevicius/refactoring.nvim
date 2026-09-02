vim.cmd "set rtp+=."

vim.cmd "set rtp+=deps/mini.nvim"
vim.cmd "set rtp+=deps/async.nvim"
vim.cmd "set rtp+=deps/mason.nvim"
vim.cmd "set rtp+=deps/nvim-treesitter"

require("mini.test").setup()
require("mason").setup {
  install_root_dir = vim.fn.getcwd() .. "/deps/bin",
}
require("nvim-treesitter").setup {
  install_dir = vim.fn.getcwd() .. "/deps/parsers",
}

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
})
vim.lsp.config("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    ".git",
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
  on_init = function(client, init_result)
    if init_result.offsetEncoding then client.offset_encoding = init_result.offsetEncoding end
  end,
})
vim.lsp.config("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    ".git",
  },
})
vim.lsp.config("metals", {
  cmd = {
    "metals",
    "-J-Djol.magicFieldOffset=true",
    "-J-Djol.tryWithSudo=true",
    "-J-Djdk.attach.allowAttachSelf",
    "-J--add-opens=java.base/java.nio=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.jvm=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.resources=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED",
    "-J--add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED",
    "-J--add-opens=java.base/sun.nio.ch=ALL-UNNAMED",
    "-J--add-opens=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED",
    "-J--add-opens=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED",
    "-J--add-opens=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED",
    "-J--add-opens=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED",
    "-J-XX:+DisplayVMOutputToStderr",
    "-J-Xlog:disable",
    "-J-Xlog:all=warning,gc=warning:stderr",
  },
  filetypes = { "scala", "sc" },
  root_patterns = {
    "build.sbt",
    "build.sc",
    ".bloop",
    ".metals",
    ".scala-build",
    ".git",
  },
  init_options = {
    compilerOptions = {},
    debuggingProvider = false,
    testExplorerProvider = false,
    disableColorOutput = true,
    doctorProvider = "json",
    doctorVisibilityProvider = true,
    executeClientCommandProvider = true,
    inputBoxProvider = true,
    quickPickProvider = true,
    statusBarProvider = "show-message",
    bspStatusBarProvider = "on",
    treeViewProvider = true,
  },
  settings = {
    metals = {
      superMethodLensesEnabled = true,
    },
  },
})
vim.lsp.enable { "lua_ls", "clangd", "pyright", "metals" }

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ai", function()
  return require("refactoring").inline_var()
end, { expr = true })
vim.keymap.set("n", "<leader>ae", function()
  return require("refactoring").extract_func()
end, { expr = true })
vim.keymap.set("n", "<leader>aE", function()
  return require("refactoring").extract_func_to_file()
end, { expr = true })
vim.keymap.set("n", "<leader>av", function()
  return require("refactoring").extract_var()
end, { expr = true })
vim.keymap.set("n", "<leader>aI", function()
  return require("refactoring").inline_func()
end, { expr = true })

vim.keymap.set("n", "<leader>pv", function()
  return require("refactoring.debug").print_var { output_location = "below" }
end, { expr = true })
vim.keymap.set("n", "<leader>pV", function()
  return require("refactoring.debug").print_var { output_location = "above" }
end, { expr = true })

vim.keymap.set({ "x", "n" }, "<leader>pc", function()
  return require("refactoring.debug").cleanup()
end, { expr = true })

vim.keymap.set("n", "<leader>pp", function()
  return require("refactoring.debug").print_loc { output_location = "below" }
end, { expr = true })
vim.keymap.set("n", "<leader>pP", function()
  return require("refactoring.debug").print_loc { output_location = "above" }
end, { expr = true })

vim.keymap.set("n", "<leader>pe", function()
  return require("refactoring.debug").print_exp { output_location = "below" }
end, { desc = "Debug print exp below", expr = true })
vim.keymap.set("n", "<leader>pE", function()
  return require("refactoring.debug").print_exp { output_location = "above" }
end, { desc = "Debug print exp above", expr = true })
