local lu = require("test.lua.luaunit")
local utils = require("lua.jump-to-test.utils")

function test_utils_split()
  local splitted = utils.split("foo.bar.asd", ".")
  local splittedAgain = utils.split("foo\nbar\nasd", "\n")

  lu.assertEquals(splitted, { "foo", "bar", "asd" })
  lu.assertEquals(splittedAgain, { "foo", "bar", "asd" })
end

function test_utils_get_first()
  local tbl = { "foo", "bar", "asd" }

  lu.assertEquals(utils.get_first(tbl), "foo")
end

function test_utils_get_second()
  local tbl = { "foo", "bar", "asd" }

  lu.assertEquals(utils.get_second(tbl), "bar")
end

os.exit(lu.LuaUnit.run())
