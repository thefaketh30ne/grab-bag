local max_config_page = 2
local GrabBag = SMODS.current_mod

GrabBag.save_config = function(self) --Saving configs.
    SMODS.save_mod_config(self)
end

function gb_desc_from_rows(desc_nodes, empty, align, maxw) --Taken from JoyousSpring's code like... a year ago? I don't remember :sob:
    local t = {}
    for k, v in ipairs(desc_nodes) do
        t[#t+1] = {n=G.UIT.R, config={align = align or "cl", maxw = maxw}, nodes=v}
    end
    return {n=G.UIT.R, config={align = "cm", colour = empty and G.C.CLEAR or G.C.UI.BACKGROUND_WHITE, r = 0.1, padding = 0.04, minw = 2, minh = 0.25, emboss = not empty and 0.05 or nil, filler = true}, nodes={
        {n=G.UIT.R, config={align = align or "cl", padding = 0.03}, nodes=t}
    }}
end

function GrabBag.create_checkbox_config(name_loc_key, desc_loc_key, config, ref_val) --Function to simplify adding configs to the menu, in case you are just adding simple configs.
    config = config or {} --This is to ensure that even when config is not set, it is always a table, helps to avoid crashes from checking config.scale (indexing nil).
    local config_name_node = {}
    localize {type = 'descriptions', key = name_loc_key, set = 'dictionary', nodes = config_name_node, vars = config.vars, scale = config.scale or 1.5, text_colour = config.text_colour or G.C.WHITE, shadow = config.shadow} 
    --Hard to explain, but this basically puts text in the node.
    config_name_node = gb_desc_from_rows(config_name_node,true) --Reorganizes the text in the node properly (?).
    config_name_node.config.colour = config.background_colour or config_name_node.config.colour
    config_name_node.config.align = "cl"

    local config_desc_node = {}
    localize {type = 'descriptions', key = desc_loc_key, set = 'dictionary', nodes = config_desc_node, vars = config.vars, scale = config.scale or 1, text_colour = config.text_colour, shadow = config.shadow} 
    --Hard to explain, but this basically puts text in the node.
    config_desc_node = gb_desc_from_rows(config_desc_node,true) --Reorganizes the text in the node properly (?).
    config_desc_node.config.colour = config.background_colour or config_desc_node.config.colour
    config_desc_node.config.align = "cl"

    --"cl" here means Center Left.
    return {n = G.UIT.R, config = {r = 0.1, minw = 8, minh = 1.2, align = "cl", colour = G.C.BLACK}, nodes = { --This is the entire box.
        {n = G.UIT.C, config = {align = "cl", colour = G.C.CLEAR}, nodes = {
            {n = G.UIT.R, config = {align = "cl", colour = G.C.CLEAR}, nodes = { --The node containing the name.
                {n = G.UIT.C, config = {align = "cl", colour = G.C.CLEAR}, nodes = {
                    config_name_node,
                }},
            }},
            {n = G.UIT.R, config = {align = "cr", colour = G.C.CLEAR, padding = config.toggle_padding or -1.2, minw = 7}, nodes = { --The node with the toggle. We use negative padding here to reduce the gap between Name and Description so that it looks like it's not between them.
                {n = G.UIT.C, config = {align = "cr", colour = G.C.CLEAR, minw = 7}, nodes = {
                    create_toggle({label = "", ref_table = GrabBag.config, ref_value = ref_val or 'hover', callback = function() GrabBag:save_config() end }), --Remember to change ref_table to your mod!
                }},
            }},
            {n = G.UIT.R, config = {align = "cl", colour = G.C.CLEAR}, nodes = { --The node containing the description.
                {n = G.UIT.C, config = {align = "cl", colour = G.C.CLEAR, padding = 0}, nodes = {
                    config_desc_node
                }},
            }},
        }},
    }}
end

function GrabBag.create_node_config(name_loc_key, desc_loc_key, config, node) --Having a config with customizable nodes beneath the name and description.
    config = config or {} --This is to ensure that even when config is not set, it is always a table, helps to avoid crashes from checking config.scale (indexing nil).
    local config_name_node = {}
    localize {type = 'descriptions', key = name_loc_key, set = 'dictionary', nodes = config_name_node, vars = config.vars, scale = config.scale or 1.5, text_colour = config.text_colour or G.C.WHITE, shadow = config.shadow} 
    --Hard to explain, but this basically puts text in the node.
    config_name_node = gb_desc_from_rows(config_name_node,true,"cm") --Reorganizes the text in the node properly (?).
    config_name_node.config.colour = config.background_colour or config_name_node.config.colour
    config_name_node.config.align = "cl"

    local config_desc_node = {}
    localize {type = 'descriptions', key = desc_loc_key, set = 'dictionary', nodes = config_desc_node, vars = config.vars, scale = config.scale or 1, text_colour = config.text_colour, shadow = config.shadow} 
    --Hard to explain, but this basically puts text in the node.
    config_desc_node = gb_desc_from_rows(config_desc_node,true,"cm") --Reorganizes the text in the node properly (?).
    config_desc_node.config.colour = config.background_colour or config_desc_node.config.colour
    config_desc_node.config.align = "cl"

    --"cl" here means Center Left.
    return {n = G.UIT.R, config = {r = 0.1, minw = 8, minh = 1.2, align = "cm", colour = G.C.BLACK}, nodes = { --This is the entire box.
        {n = G.UIT.C, config = {align = "cm", colour = G.C.CLEAR}, nodes = {
            {n = G.UIT.R, config = {align = "cm", colour = G.C.CLEAR}, nodes = { --The node containing the name.
                config_name_node,
            }},
            {n = G.UIT.R, config = {align = "cm", colour = G.C.CLEAR}, nodes = { --The node containing the description.
                config_desc_node
            }},
            {n = G.UIT.R, config = {align = "cm", colour = G.C.CLEAR, padding = config.node_padding or 0}, nodes = { --The node containing the option cycle.
                node
            }},
        }},
    }}
end

function G.FUNCS.gb_next_config_page(e)
    G.gb_config_page = G.gb_config_page or 1
    G.gb_config_page = math.min(G.gb_config_page + 1, max_config_page)
    G.FUNCS["openModUI_GrabBag"]() --Change BALATROSTARRAIL with your mod's id!
end

function G.FUNCS.gb_previous_config_page(e)
    G.gb_config_page = G.gb_config_page or 1
    G.gb_config_page = math.max(math.min(G.gb_config_page - 1, max_config_page), 1)
    G.FUNCS["openModUI_GrabBag"]() --Change BALATROSTARRAIL with your mod's id!
end

GrabBag.config_tab = function()
    G.gb_config_page = G.gb_config_page or 1

    local root_nodes = {} --This is called "root"_nodes because it was originally supposed to be put inside G.UIT.ROOT immediately. But uh, I realized it's not too optimized but I'm lazy to change its name :3
    if G.gb_config_page == 1 then
        root_nodes = {
            GrabBag.create_checkbox_config("gb_custom_music_name", "gb_custom_music_desc", nil, "custom_music"), --The first and second are keys to your localization file. The forth one is the config in your config.lua.
        }
    elseif G.gb_config_page == 2 then --next page
        --[[
        root_nodes = {
            GrabBag.create_checkbox_config("gb_joyful", "gb_joyful", nil, "enable"),
        }
        ]]
    end
    root_nodes[#root_nodes+1] = {n = G.UIT.R, config = {align = "cm", padding = 0.02}, nodes = { --Page turning stuff. This is always added to root_nodes.
        {n = G.UIT.C, config = {align = "cm", minw = 0.5, minh = 0.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.RED, shadow = true, button = "gb_previous_config_page"}, nodes = {
            {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
                {n = G.UIT.T, config = {text = "<", scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
            }}
        }},
        {n = G.UIT.C, config = {align = "cm", minw = 0.5, minh = 0.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.RED, shadow = true}, nodes = {
            {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
                {n = G.UIT.T, config = {text = localize("gb_page").." "..G.gb_config_page.."/"..(max_config_page or 1), scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
            }}
        }}, 
        {n = G.UIT.C, config = {align = "cm", minw = 0.5, minh = 0.5, padding = 0.1, r = 0.1, hover = true, colour = G.C.RED, shadow = true, button = "gb_next_config_page"}, nodes = {
            {n = G.UIT.R, config = {align = "cm", padding = 0.05}, nodes = {
                {n = G.UIT.T, config = {text = ">", scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
            }}
        }},
    }}

    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 5, align = "cm", padding = 0.15, colour = G.C.BLACK}, nodes = { --The first node should always be G.UIT.ROOT.
        {n = G.UIT.C, config = {r = 0.1, minw = 5, minh = 3, align = "cm", colour = {G.C.L_BLACK[1], G.C.L_BLACK[2], G.C.L_BLACK[3], 0.6}, padding = 0.1}, nodes = --We are using G.UIT.C here so that configs are aligned vertically.
            root_nodes
        },
    }}
end
