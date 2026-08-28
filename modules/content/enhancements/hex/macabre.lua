SMODS.Enhancement {
    key = 'macabre',
    loc_txt = {
		name = 'Macabre Card',
		text = {
			"Gains {C:mult}+#1#{} Mult",
			"when discarded",
            "{C:inactive}(Currently {C:mult}+#2# {C:inactive}Mult)"
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 0, y = 0 },
    config = { mult = 0, extra = { mult_mod = 10 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.mult_mod,
            card.ability.mult,
        } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "mult",
                scalar_table = card.ability.extra,
                scalar_value = "mult_mod",
                message_colour = G.C.MULT
            })
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
