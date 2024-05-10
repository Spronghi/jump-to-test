local utils = require("jump-to-test.utils")

local module = {}

module.setup = function()
  vim.api.nvim_create_user_command('JumpToTest', function()
    local init_filename = vim.fn.expand("%:t")

    local splitted = utils.split(init_filename, ".")
    local filename = utils.get_first(splitted)

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

    local file_paths = utils.split(result, "\n")


    utils.toggle_telescope(file_paths)
  end, {})
end

return module
