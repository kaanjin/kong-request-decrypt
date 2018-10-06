local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.request-decrypt.access"

local RequestDecryptPlugin = BasePlugin:extend()

function RequestDecryptPlugin:new()
	RequestDecryptPlugin.super.new(self, "request-decrypt")
end

function RequestDecryptPlugin:access(conf)
	RequestDecryptPlugin.super.access(self)
	access.execute(conf)
end

return RequestDecryptPlugin