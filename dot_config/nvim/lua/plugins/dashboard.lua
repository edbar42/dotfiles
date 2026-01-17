return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      enabled = true,
      -- We increase this to 100+ to ensure there's room for two columns
      width = 100, 
      row = nil,
      col = nil,
      -- Pane gap is the space BETWEEN the left and right columns
      pane_gap = 10, 
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      preset = {
        pick = nil,
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "p", desc = "Visited Projects", action = ":lua Snacks.dashboard.pick('projects')"},
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- The Header automatically spans both panes in Snacks
        header = [[
                  ░██ ░██                               ░████    ░██████  
                  ░██ ░██                              ░██ ██   ░██   ░██ 
 ░███████   ░████████ ░████████   ░██████   ░██░████  ░██  ██         ░██ 
░██    ░██ ░██    ░██ ░██    ░██       ░██  ░███     ░██   ██     ░█████  
░█████████ ░██    ░██ ░██    ░██  ░███████  ░██      ░█████████  ░██      
░██        ░██   ░███ ░███   ░██ ░██   ░██  ░██           ░██   ░██       
 ░███████   ░█████░██ ░██░█████   ░█████░██ ░██           ░██   ░████████ 
        ]],
      },
      formats = {
        icon = function(item)
          if item.file and item.icon == "file" or item.icon == "directory" then
            return Snacks.dashboard.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        -- Header spans the top
        { section = "header", padding = 2 },
        
        -- LEFT COLUMN (Pane 1)
        { section = "keys", gap = 1, padding = 1 },
        
        -- RIGHT COLUMN (Pane 2)
        {
          pane = 2,
          section = "terminal",
          title = "Remote Sync Status",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = [[
            git fetch > /dev/null 2>&1
            UPSTREAM=${1:-'@{u}'}
            LOCAL=$(git rev-parse @)
            REMOTE=$(git rev-parse "$UPSTREAM")
            BASE=$(git merge-base @ "$UPSTREAM")

            if [ $LOCAL = $REMOTE ]; then
                echo " Up to date"
            elif [ $LOCAL = $BASE ]; then
                echo "󰚰 Need to pull"
            elif [ $REMOTE = $BASE ]; then
                echo "󰶣 Need to push"
            else
                echo " Diverged"
            fi

            LAST_SYNC=$(stat -c %y .git/FETCH_HEAD 2>/dev/null | cut -d' ' -f1,2 | cut -d: -f1,2)
            echo "󱑂 Last sync: ${LAST_SYNC:-'Never'}"
          ]],
          height = 3,
          padding = 1,
          ttl = 60 * 5,
        },
        -- Bottom line
        { section = "startup" },
      },
    },
  },
}
