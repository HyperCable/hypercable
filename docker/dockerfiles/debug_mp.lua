
local jsonschema = require "jsonschema"
-- todo require event name
local validator = jsonschema.generate_validator({
  type = "object",
  properties = {
    app_instance_id = { type = "string" },
    user_id = { type = "string" },
    user_properties = { type = "object" },
    timestamp_micros = { type = "number" },
    non_personalized_ads = { type = "boolean"},
    events = { 
      type = "array",
      items = {
        type = "object",
        properties = {
            name = {type = "string"},
            params = {type = "object"}
        },
        required = {"name"}
      } 
    }
  },
  required = {"client_id", "events"}
})
local cjson = require "cjson"
local redis = require "resty.redis"
local r     = redis:new()
local ok
local err
if (os.getenv("SAAS_REDIS_HOST") == nil or os.getenv("SAAS_REDIS_HOST") == "") then
    ok, err = r:connect(os.getenv("REDIS_HOST"), os.getenv("REDIS_PORT")) 
else
    ok, err = r:connect(os.getenv("SAAS_REDIS_HOST"), os.getenv("SAAS_REDIS_PORT"))
end

if not ok then
  ngx.say(cjson.encode({
    status = "error", 
    msg =  "failed to connect: " .. err
    }
   )
  )
  return
end

local result = {status="ok", msg=""}
local query = ngx.req.get_uri_args()
local post = ngx.req.get_body_data()

local measurement_id = query["measurement_id"]
local api_secret = query["api_secret"]

-- check measurement_id
if (measurement_id == "" or measurement_id == nil) then
    result["msg"] = "measurement_id not present"
    result["status"] = "error"
    ngx.say(cjson.encode(result))
    return
end

-- check api_secret
if (api_secret == "" or api_secret == nil) then
    result["msg"] = "api_secret not present"
    result["status"] = "error"
    ngx.say(cjson.encode(result))
    return
else
    local site_uuid = string.match(ngx.var.request_uri, "/" .. "(" .. string.rep(".", 36) .. ")")
    if (site_uuid == "" or site_uuid == nil ) then
        result["msg"] = "site_uuid not present (e.g., /e63f4903-293c-408c-807f-63b49a2d7376/debug/mp/collect)"
        result["status"] = "error"
        ngx.say(cjson.encode(result))
        return
    else
        if (r:get(api_secret) ~= site_uuid) then
            result["msg"] = "api_secret is not correct"
            result["status"] = "error"
            ngx.say(cjson.encode(result))
            return
        end
    end
end

-- check payload
local valid_ok, valid_err = validator(cjson.decode(post))
if not valid_ok then
    result["msg"] = valid_err
    result["status"] = "error"
    ngx.say(cjson.encode(result))
    return
end

r:set_keepalive()
r = nil
ngx.status  = ngx.HTTP_OK
result["msg"] = "ok"
return ngx.say(cjson.encode(result))
