local utils = require("jump-to-test.utils")

local module = {}

local function search_for_file(filename)
  local command = "fd " .. filename
  local handle = io.popen(command)

  if handle == nil then
    return nil
  end

  local result = handle:read("*a")

  handle:close()

  local file_paths = utils.split(result, "\n")

  return file_paths
end

local function open_if_not_test(file_paths)
  for _, path in pairs(file_paths) do
    if not utils.is_test(path) then
      return vim.cmd("edit " .. path)
    end
  end
end

local function open_if_test(file_paths)
  for _, path in pairs(file_paths) do
    if utils.is_test(path) then
      return vim.cmd("edit " .. path)
    end
  end
end

module.setup = function()
  vim.api.nvim_create_user_command('JumpToTest', function()
    local init_filename = vim.fn.expand("%:t")

    local splitted = utils.split(init_filename, ".")
    local filename = utils.get_first(splitted)
    local extension = utils.get_second(splitted)
    local is_test_extension = utils.is_test_extension(extension)

    if filename == nil or filename == "" then
      return nil
    end


    local file_paths = search_for_file(filename)

    if file_paths == nil then
      return nil
    end

    if table.getn(file_paths) > 2 then
      return utils.toggle_telescope(file_paths)
    end

    if is_test_extension then
      return open_if_not_test(file_paths)
    end

    return open_if_test(file_paths)
  end, {})
end

return module
