local utils = {}

utils.split = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

utils.get_first = function(tbl)
  return tbl[0] or tbl[1]
end

utils.toggle_telescope = function(file_paths)
  local conf = require("telescope.config").values

  require("telescope.pickers").new({ initial_mode = "normal" }, {
    prompt_title = "Jump to test",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
    on_complete = { function() vim.cmd "stopinsert" end }
  }):find()
end

return utils
