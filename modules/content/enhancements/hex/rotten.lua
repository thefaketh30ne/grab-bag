SMODS.Enhancement {
    key = 'rotten',
    loc_txt = {
		name = 'Rotten Card',
		text = {
            "{C:red}X#1# {C:attention}Blind{} size",
            "if held in hand"
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 5, y = 0 },
    config = { extra = { zblind_size = 0.9 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_blind_size } }
    end,
    calculate = function(self, card, context)    
        if context.before and context.cardarea == G.hand then
            return {
                xblindsize = card.ability.extra.x_blind_size
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
