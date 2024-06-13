-- See `:help telescope` and `:help telescope.setup()`
local fb_actions = require "telescope._extensions.file_browser.actions"
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local sorters = require("telescope.sorters")
local util = require "telescope.utils"


require("telescope").setup {
  defaults = {
    file_sorter = function(opts)
      opts = opts or {}
      local fzy = opts.fzy_mod or require "telescope.algos.fzy"
      local OFFSET = -fzy.get_score_floor()

      return sorters.Sorter:new {
        discard = true,

        scoring_function = function(_, prompt, line)
          local _, l = line:match '(.*/)(.*)'

          if l ~= nil then
            --io.popen("echo '" .. line .. " -> " .. l .. "' >> /tmp/lua")
            line = l
          end
          -- Check for actual matches before running the scoring alogrithm.
          if not fzy.has_match(prompt, line) then
            return -1
          end

          local fzy_score = fzy.score(prompt, line)

          -- The fzy score is -inf for empty queries and overlong strings.  Since
          -- this function converts all scores into the range (0, 1), we can
          -- convert these to 1 as a suitable "worst score" value.
          if fzy_score == fzy.get_score_min() then
            return 1
          end

          -- Poor non-empty matches can also have negative values. Offset the score
          -- so that all values are positive, then invert to match the
          -- telescope.Sorter "smaller is better" convention. Note that for exact
          -- matches, fzy returns +inf, which when inverted becomes 0.
          return 1 / (fzy_score + OFFSET)
        end,

        -- The fzy.positions function, which returns an array of string indices, is
        -- compatible with telescope's conventions. It's moderately wasteful to
        -- call call fzy.score(x,y) followed by fzy.positions(x,y): both call the
        -- fzy.compute function, which does all the work. But, this doesn't affect
        -- perceived performance.
        highlighter = function(_, prompt, display)
          return fzy.positions(prompt, display)
        end,
      }
    end, ----
    -- path_display = { "tail" },
    file_ignore_patterns = {
      "node_modules", "build", "dist", "yarn.lock", "Cargo.lock", "deps", "target"
    },
    pickers = {
      ["builtin.lsp_document_symbols"] = {
        show_line = true
      }
    },
    mappings = {
      i = {
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extensions = {
    -- smart_open = {
    --   show_scores = false,
    --   max_unindexed = 6500,
    --   ignore_patterns = { "*.git/*", "*/tmp/*", "*/" },
    --   match_algorithm = "fzy",
    --   disable_devicons = false,
    -- },
    repo = {
      list = {
        fd_opts = {
          --"--no-ignore-vcs",
        },
        search_dirs = {
          "~/ssd/projects/",
          "~/data/linux/",
        },
      },
      settings = {
        -- auto_lcd = true,
      },
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = false, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    file_browser = {
      --theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
      -- group dirs
      grouped = true,
      hidden = true,
      dir_icon = "",
      hide_parent_dir = true,
      initial_mode = 'normal',
      mappings = {
        ["i"] = {
          ["<A-c>"] = fb_actions.create,
          ["<S-CR>"] = fb_actions.create_from_prompt,
          ["<A-r>"] = fb_actions.rename,
          ["<A-m>"] = fb_actions.move,
          ["<A-y>"] = fb_actions.copy,
          ["<A-d>"] = fb_actions.remove,
          ["<C-o>"] = fb_actions.open,
          ["<C-g>"] = fb_actions.goto_parent_dir,
          ["<C-e>"] = fb_actions.goto_home_dir,
          ["<C-w>"] = fb_actions.goto_cwd,
          ["<C-t>"] = fb_actions.change_cwd,
          ["<C-f>"] = fb_actions.toggle_browser,
          ["<C-h>"] = fb_actions.toggle_hidden,
          ["<C-s>"] = fb_actions.toggle_all,
          ["<C-l>"] = actions.select_default,
        },
        ["n"] = {
          -- trailing/ creates dir
          ["c"] = fb_actions.create,
          ["a"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["e"] = fb_actions.open,
          ["h"] = fb_actions.goto_parent_dir,
          ["gh"] = fb_actions.goto_home_dir,
          ["w"] = fb_actions.goto_cwd,
          ["t"] = fb_actions.change_cwd,
          ["f"] = fb_actions.toggle_browser,
          ["."] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
          ["l"] = actions.select_default,
          -- enter insert mode
          ["/"] = function() vim.api.nvim_feedkeys("i", "n", false) end,
        },
      },
    },
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"
require("telescope").load_extension "smart_open"
require("telescope").load_extension "repo"
require('telescope').load_extension('luasnip')
require("telescope").load_extension("ui-select")
--local sorters = require("telescope.sorters")
--
--builtin.find_files({
--  sorter = sorters.get_levenshtein_sorter,
--})
