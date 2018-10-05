local function validate_key(value)
  if #value == 0 then
    return false, "Encryption key must be not empty"
  end

  return true
end

return {
  fields = {
    encryption_key = {type = "string", required = true, func = validate_key}
  }
}