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
