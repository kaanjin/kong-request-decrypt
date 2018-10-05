local BasePlugin = require "base_plugin"
local access = require "access"

local RequestDecryptPlugin = BasePlugin:extend()

function RequestDecryptPlugin:new()
	RequestDecryptPlugin.super.new(self, "request-decrypt")
end

function RequestDecryptPlugin:access(conf)
	RequestDecryptPlugin.super.access(self)
	access.run(conf)
end

return RequestDecryptPlugin