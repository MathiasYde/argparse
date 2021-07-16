local class = {
  _author = "Mathias Yde",
  _license = "MIT",
  _version = "1.0.0"
}

function table.clear(t)
  count = #t
  for i=0, count do t[i]=nil end
end

local object = {}

local stack = {}
local stack_count = 0

function push_identifier(identifier)
  table.insert(stack, identifier)
  stack_count = stack_count + 1
  if stack_count >= 2 then
    object[stack[1]] = stack[2]

    table.clear(stack)
    stack_count = 0
  end
end

local literal_map = {
  ["t"] = true,
  ["f"] = false,
  ["n"] = nil
}

function parse_literal(index, flag)
  push_identifier(literal_map[string.sub(flag, index, index)])
  return string.len(flag)
end

function parse_string(index, flag)
  local start_index = index

  index = index + 1
  while string.sub(flag, index, index) ~= '"' do
    index = index + 1
  end

  local identifier = string.sub(flag, start_index+1, index-1)
  push_identifier(identifier)

  return index
end

function parse_number(index, flag)
  local start_index = index

  index = index + 1
  while tonumber(string.sub(flag, index, index)) ~= nil do
    index = index + 1
  end

  local identifier = tonumber(string.sub(flag, start_index, index-1))
  push_identifier(identifier)

  return index
end

local parse_map = {
  ["\""] = parse_string,
  ["t"] = parse_literal,
  ["f"] = parse_literal,
  ["n"] = parse_literal,
  ["0"] = parse_number,
  ["1"] = parse_number,
  ["2"] = parse_number,
  ["3"] = parse_number,
  ["4"] = parse_number,
  ["5"] = parse_number,
  ["6"] = parse_number,
  ["7"] = parse_number,
  ["8"] = parse_number,
  ["9"] = parse_number
}

function parse_flag(flag)
  local equal_index = string.find(flag, "=", 1, true)
  local key = string.sub(flag, 3, equal_index - 1)
  local value = string.sub(flag, equal_index + 1, #flag)

  push_identifier(key)

  local index = 1

  while index < string.len(value) do
    local char = string.sub(value, index, index)
    local parser = parse_map[char]

    index = parser(index, value)
  end
end

function class.parse(args)
  for i, flag in pairs(args) do
    if (i < 0) then
      goto continue
    end

    parse_flag(flag)

    ::continue::
  end

  return object
end

return class.parse
