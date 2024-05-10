local utils             = {}

utils.split             = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

utils.get_first         = function(tbl)
  return tbl[0] or tbl[1]
end

utils.get_second        = function(tbl)
  if tbl[0] ~= nil then
    return tbl[1]
  end

  return tbl[2]
end

utils.is_test           = function(filename)
  return string.find(filename, "test") or string.find(filename, "spec")
end

utils.is_test_extension = function(extension)
  return extension == "test" or extension == "spec"
end

utils.toggle_telescope  = function(file_paths)
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

utils.dump              = function(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then k = '"' .. k .. '"' end
      s = s .. "[" .. k .. "] = " .. utils.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

return utils
