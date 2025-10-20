---@diagnostic disable: duplicate-set-field
-- allstar deck take_ownership

gb_common_get_weight = SMODS.Rarities["Common"].get_weight

SMODS.Rarity:take_ownership('Common',
    {
        get_weight = function(self, weight, object_type) 
            if G.GAME.selected_back.effect.center.key == "b_gb_allstar" then
                return 0
            else 
                return gb_common_get_weight(self, weight, object_type)
            end
        end
    },
true )

-- slim pickings challenge take_ownership of uncommon and rare
gb_uncommon_get_weight = SMODS.Rarities["Uncommon"].get_weight
gb_rare_get_weight = SMODS.Rarities["Rare"].get_weight

SMODS.Rarity:take_ownership('Uncommon',
    {
        get_weight = function(self, weight, object_type) 
            if G.GAME.modifiers["gb_no_uncommon"] == true then
                return 0
            else
                return gb_uncommon_get_weight(self, weight, object_type)
            end
        end
    },
true )

SMODS.Rarity:take_ownership('Rare',
    {
        get_weight = function(self, weight, object_type) 
            if G.GAME.modifiers["gb_no_rare"] == true then
                return 0
            else 
                return gb_rare_get_weight(self, weight, object_type)
            end
        end
    },
true )

-- obsessive hex hook
local original_can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    original_can_discard(e)
    for _, playing_card in ipairs(G.hand.highlighted) do
        local hex_key, _ = GB.get_hex(playing_card)
        if hex_key == "gb_obsessive_hex" then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
            break
        end
    end
end