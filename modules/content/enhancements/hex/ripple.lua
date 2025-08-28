SMODS.Enhancement {
    key = 'ripple',
    loc_txt = {
		name = 'Ripple Card',
		text = {
            "{C:attention}Always scores",
			"Gains {C:chips}+#1#{} Chips",
			"when played",
		}
	},
    always_scores = true,
    atlas = 'gb_Enhancements',
    pos = { x = 3, y = 0 },
    config = { bonus = 0, extra = { chips_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod } }
    end,
    calculate = function(self, card, context)    
        if context.before and context.cardarea == G.play then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "bonus",
                scalar_table = card.ability.extra,
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
