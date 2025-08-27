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
    config = { bonus = 0, extra = { bonus_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.bonus_mod } }
    end,
    calculate = function(self, card, context)    
        if context.before and context.cardarea == G.play then
            card.ability.bonus = card.ability.bonus + card.ability.extra.bonus_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end
    end
}
