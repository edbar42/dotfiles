return {
  {
    "nvim-mini/mini.snippets",
    opts = function(_, opts)
      local snippets = require("mini.snippets")
      -- Neovim uses `cs` (Tree-sitter: `c_sharp`), while friendly-snippets
      -- stores its C# snippets under `csharp`.
      local csharp_patterns = {
        "csharp/**/*.json",
        "csharp/**/*.lua",
        "cs/**/*.json",
        "cs/**/*.lua",
        "**/cs.json",
        "**/cs.lua",
      }
      opts.snippets = {
        snippets.gen_loader.from_lang({
          lang_patterns = { cs = csharp_patterns, c_sharp = csharp_patterns },
        }),
      }
    end,
  },
}
