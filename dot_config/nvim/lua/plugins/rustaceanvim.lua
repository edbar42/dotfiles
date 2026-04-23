return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  init = function()
    local cargo_bin = vim.fs.joinpath(vim.env.HOME, ".cargo", "bin")
    local cargo_home = vim.fs.joinpath(vim.env.HOME, ".cargo")
    local rustup_home = vim.fs.joinpath(vim.env.HOME, ".rustup")
    -- local rustc = vim.fs.joinpath(cargo_bin, "rustc")
    -- local sysroot = vim.trim(vim.fn.system({ rustc, "--print", "sysroot" }))
    -- local sysroot_src = vim.fs.joinpath(sysroot, "lib", "rustlib", "src", "rust", "library")

    local function set_rust_keymaps(bufnr)
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, {
          buffer = bufnr,
          desc = desc,
          silent = true,
        })
      end

      map("K", vim.lsp.buf.hover, "Rust: Hover documentation")
      map("<leader>ca", function()
        vim.cmd.RustLsp("codeAction")
      end, "Rust: Code actions")
      map("<leader>rr", function()
        vim.cmd.RustLsp("runnables")
      end, "Rust: Runnables")
      map("<leader>rd", function()
        vim.cmd.RustLsp("debuggables")
      end, "Rust: Debuggables")
      map("<leader>rt", function()
        vim.cmd.RustLsp("testables")
      end, "Rust: Testables")
      map("<leader>rm", function()
        vim.cmd.RustLsp("expandMacro")
      end, "Rust: Expand macro")
    end

    vim.g.rustaceanvim = function()
      return {
        server = {
          cmd = { vim.fs.joinpath(cargo_bin, "rust-analyzer") },
          cmd_env = {
            CARGO_HOME = cargo_home,
            PATH = cargo_bin .. ":" .. vim.env.PATH,
            RUSTUP_HOME = rustup_home,
          },
          on_attach = function(_, bufnr)
            vim.schedule(function()
              set_rust_keymaps(bufnr)
            end)
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                allTargets = true,
                buildScripts = {
                  enable = true,
                },
              },
              check = {
                allTargets = true,
                command = "clippy",
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end
  end,
}
