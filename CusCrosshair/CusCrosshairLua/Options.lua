local Options = CusCrosshair.loaded_options
function CusCrosshair:Save()
	local fileName = CusCrosshair.save_path .. "CusCrosshairoptions.txt"
	local file = io.open(fileName, "w+")
	file:write(json.encode(Options))
	file:close()
end

function CusCrosshair:Load_options()
	local file = io.open(CusCrosshair.save_path .. "CusCrosshairoptions.txt", 'r')
	if file == nil then
		local file = io.open(CusCrosshair.save_path .. "CusCrosshairoptions.ini", 'r')
		if file then
			CusCrosshair:Load_options_old()
		end
		CusCrosshair:Save()
		return
	end
	local file_contents = file:read("*all")
	local data = json.decode( file_contents )
	file:close()
	if data then
		for p, d in pairs(data) do
			Options[p] = d
		end
	end
end

function CusCrosshair:Load_options_old()
	local file = io.open(CusCrosshair.save_path .. "CusCrosshairoptions.ini", 'r')
	if file == nil then
		CusCrosshair:Save()
		return
	end
	local key
	for line in file:lines() do
		local loadKey = line:match('^%[([^%[%]]+)%]$')
		if loadKey then
			key = tonumber(loadKey) and tonumber(loadKey) or loadKey
			Options[key] = Options[key] or {}
		end
		local param, val = line:match('^([%w|_]+)%s-=%s-(.+)$')
		if param and val ~= nil then
			if tonumber(val) then
				val = tonumber(val)
			elseif val == "true" then
				val = true
			elseif val == "false" then
				val = false
			end
			if tonumber(param) then
				param = tonumber(param)
			end
			Options[key][param] = val
		end
	end
	file:close()
end