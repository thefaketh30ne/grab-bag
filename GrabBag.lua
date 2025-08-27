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

GB.Hex = SMODS.Sticker:extend {
    prefix_config = { key = true },
    should_apply = false,
    config = {},
    rate = 0,
    sets = {
        Default = true
    },

    draw = function(self, card)
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center, nil, nil)
    end,

    apply = function(self, card, val)
        card.ability[self.key] = val and copy_table(self.config) or nil
    end
}