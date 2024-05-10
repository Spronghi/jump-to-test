local module = {}

local function split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function toggle_telescope(file_paths)
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

module.setup = function()
  vim.api.nvim_create_user_command('JumpToTest', function()
    local init_filename = vim.fn.expand("%:t")

    local filename = split(init_filename, ".")[0]

    if filename == nil or filename == "" then
      return
    end

    local command = "fd " .. filename
    local handle = io.popen(command)
    if handle == nil then
      return
    end

    local result = handle:read("*a")

    handle:close()

    local file_paths = split(result, "\n")


    toggle_telescope(file_paths)
  end, {})
end

return module
