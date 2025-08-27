SMODS.Enhancement {
    key = 'alloyed',
    loc_txt = {
		name = 'Alloyed Card',
		text = {
			"Gains {C:mult}+#1#{} Mult",
            "held in hand",
			"when played",
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 4, y = 0 },
    config = { h_mult = 0, extra = { mult_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod } }
    end,
    calculate = function(self, card, context)    
        if context.before and context.cardarea == G.play then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "h_mult",
                scalar_table = card.ability.extra,
                scalar_value = "mult_mod",
                message_colour = G.C.SHIPS
            })
        end
    end,
    in_pool = function(self, args)
        return false
    end
}