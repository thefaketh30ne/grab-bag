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

SMODS.current_mod.custom_collection_tabs = function()
    return {
        UIBox_button(
            {
                button = "your_collection_gb_hexes",
                id = "your_collection_gb_hexes",
                label = { "Hexes" },
                minw = 5,
                minh = 1
            }
        )
    }
end

GB.HEX_KEYS = {
        "cowardly",
        "egoistic",
        "haunted",
        -- "paranoid",
        "despot",
        "decaying",
        -- "ravenous",
        -- "devoted",
        -- "obsessive",
        "unstable",
        -- "inflexible",
        -- "slothful",
    }

local function hexes_ui()
    local hexes = {}
    for k, v in pairs(SMODS.Stickers) do
        if GB.is_hex(k) then
            hexes[k] = v
        end
    end
    return SMODS.card_collection_UIBox(
        hexes,
        { 6, 6 },
        {
            snap_back = true,
            hide_single_page = true,
            collapse_single_page = true,
            center = "c_base",
            h_mod = 1.03,
            back_func = "your_collection_other_gameobjects",
            modify_card = function(card, center)
                card.ignore_pinned = true
                center:apply(card, true)
            end
        }
    )
end

G.FUNCS.your_collection_gb_hexes = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = hexes_ui()
    }
end

local function wrap_without_markings(func)
    local removed = {}
    for k, v in pairs(SMODS.Stickers) do
        if GB.is_hex(k) then
             removed[k] = v
            SMODS.Stickers[k] = nil
        end
    end
    local ret = func()
    for k, v in pairs(removed) do
        SMODS.Stickers[k] = v
    end
    return ret
end

local stickers_ui_ref = create_UIBox_your_collection_stickers
create_UIBox_your_collection_stickers = function()
    return wrap_without_markings(stickers_ui_ref)
end

local other_objects_ref = create_UIBox_Other_GameObjects
create_UIBox_Other_GameObjects = function()
    return wrap_without_markings(other_objects_ref)
end

function GB.is_hex(str)
    for _, v in ipairs(GB.HEX_KEYS) do
        if 'gb_' .. v .. '_hex' == str then
            return true
        end
    end
    return false
end

function GB.has_hex(card)
    for k, v in pairs(card and card.ability or {}) do
        if GB.is_hex(k) then
            return k, v
        end
    end
end

function GB.set_hex(card, hex)
    local key = 'gb_' .. hex .. '_hex'
    if card and GB.is_hex(key) then
        -- remove existing hexes before applying
        for k, _ in pairs(card.ability) do
            if GB.is_hex(k) then
                card.ability[k] = nil
            end
        end

        SMODS.Stickers[key]:apply(card, true)
    end
end

function GB.hex_tooltip(hex)
    local key = 'gb_' .. hex .. '_hex'
    local hex_key = SMODS.Stickers[key]
    local vars = {}
    if not hex_key then return end
    if hex_key.loc_vars then
        local dummy_card = { ability = {} }
        hex_key:apply(dummy_card, true)
        vars = hex_key:loc_vars({}, dummy_card).vars
    end
    return {
        set = 'Other',
        key = key,
        vars = vars
    }
end