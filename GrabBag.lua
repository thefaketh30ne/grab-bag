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

GB.G.SHATTERED_TABLE = {
	{"j_obelisk", "j_gb_monolith"},
	{"j_flower_pot", "j_gb_ornate_vase"},
	{"j_rough_gem", "j_gb_cosmic_diamond"},
	{"j_splash", "j_gb_purple_rain"},
    {"j_gb_polariser", "j_gb_supercharger"},
    {"j_joker", "j_gb_jimbo"},
	{"j_invisible", "j_gb_pure_essence"},
	{"j_fibonnaci", "j_gb_golden_ratio"},
	{"j_scary_face", "j_gb_melting_face"},
	{"j_smiley_face", "j_gb_melting_face"},
	{"j_loyalty_card", "j_gb_phase_charts"},
	{"j_gb_torchlight", "j_gb_lighthouse"},
	{"j_hallucination", "j_gb_divination"},
	{"j_gb_bait", "j_gb_lure"},
	-- {"j_gb_lobster_claw", "j_gb_toy_fish"},
	-- {"j_castle", "j_gb_crumbling_castle"},
	-- {"j_dusk", "j_gb_midnight"},
	-- {"j_acrobat", "j_gb_midnight"},
	-- {"j_raised_fist", "j_gb_revolution"},
	-- {"j_misprint", "j_gb_memory_leak"},
	-- {"j_shortcut", "j_gb_metro_lines},
	-- {"j_space_joker", "j_gb_parasite"},
	-- {"j_idol", "j_gb_alien_relic"},
	-- {"j_ancient_joker", "j_gb_alien_relic"},
	-- {"j_greedy_joker", "j_gb_sin"},
	-- {"j_wrathful_joker", "j_gb_sin"},
	-- {"j_lusty_joker", "j_gb_sin"},
	-- {"j_gluttenous_joker", "j_gb_sin"},
}
