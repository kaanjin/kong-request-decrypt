local multipart = require "multipart"
local cjson = require "cjson"

local req_set_header = ngx.req.set_header
local req_get_headers = ngx.req.get_headers
local req_read_body = ngx.req.read_body
local req_set_body_data = ngx.req.set_body_data
local req_get_body_data = ngx.req.get_body_data
local string_find = string.find
local pcall = pcall

local _M = {}

local CONTENT_LENGTH = "content-length"
local CONTENT_TYPE = "content-type"

local function parse_json(body)
  if body then
    local status, res = pcall(cjson.decode, body)
    if status then
      return res
    end
  end
end

local function is_json_content_type(content_type)
  if content_type == nil then
    return false
  end
  if string_find(content_type:lower(), "application/json", nil, true) then
    return true
  end
end

local function transform_json_body(conf, body, content_length)
  local encrypted = false
  local content_length = (body and #body) or 0
  local parameters = parse_json(body)
  -- ??
  if parameters == nil and content_length > 0 then
    return false, nil
  end

  if content_length > 0 and #conf.encryption_key > 0 then
    local encrypted_body = body
    parameters["body"] = encrypted_body
    parameters["key"] = conf.encryption_key
    encrypted = true
  end

  if encrypted then
    return true, cjson.encode(parameters)
  end
end

local function transform_body(conf)
  local content_type_value = req_get_headers()[CONTENT_TYPE]
  local is_json = is_json_content_type(content_type_value)
  if not is_json then
    return
  end

  req_read_body()
  local body = req_get_body_data()
  local is_body_transformed = false
  local content_length = (body and #body) or 0

  is_body_transformed, body = transform_json_body(conf, body, content_length)

  if is_body_transformed then
    req_set_body_data(body)
    req_set_header(CONTENT_LENGTH, #body)
  end
end

function _M.execute(conf)
  transform_body(conf)
end

return _M