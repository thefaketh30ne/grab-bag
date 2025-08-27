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
                button = "your_collection_fmod_hexes",
                id = "your_collection_fmod_hexes",
                label = { "Hexes" },
                minw = 5,
                minh = 1
            }
        )
    }
end

local function hexes_ui()
    local hexes = {}
    for k, v in pairs(SMODS.Stickers) do
        if GB.is_marking(k) then
            hexes[k] = v
        end
    end
    return SMODS.card_collection_UIBox(
        hexes,
        { 5, 5 },
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

G.FUNCS.your_collection_fmod_hexes = function()
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = hexes_ui()
    }
end