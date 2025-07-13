gb_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
	cardareas = {
		deck = true,
		discard = true
	}
}

ASPL = {}
ASPL.FUNC = {}
ASPL.G = {}

GB = {}
GB.G = {}

ASPL.G.MODPATH = SMODS.current_mod.path
local NFS = require("nativefs")

to_big = to_big or function(a) return a end
--talisman compat, but honestly your mod looks pretty stable from what im seeing
--thanks bepis

function ASPL.FUNC.RequireFolder(path)
	local files = NFS.getDirectoryItemsInfo(ASPL.G.MODPATH .. "/" .. path)
	for i = 1, #files do
		local file_name = files[i].name
		if file_name:sub(-4) == ".lua" then
			assert(SMODS.load_file(path .. file_name))()
			print("Loaded " .. path .. file_name)
		end
	end
end


function ASPL.FUNC.RequireFolderRecursive(path)
	local function scan(currentPath)
		local fullPath = ASPL.G.MODPATH .. "/" .. currentPath
		local files = NFS.getDirectoryItemsInfo(fullPath)

		for _, fileInfo in ipairs(files) do
			local fileName = fileInfo.name
			local fileType = fileInfo.type
			local childPath = currentPath == "" and fileName or currentPath .. "/" .. fileName

			if fileType == "directory" then
				-- Recursively scan subdirectories
				scan(childPath)
			elseif fileType == "file" and fileName:sub(-4) == ".lua" then
				-- Load the Lua file with proper relative path
				assert(SMODS.load_file(childPath))()
				print("Loaded " .. childPath)
			end
		end
	end
	scan(path)  -- Start scanning from initial path
end

ASPL.FUNC.RequireFolderRecursive("modules")
