SMODS.Enhancement {
    key = 'river',
    loc_txt = {
		name = 'River Card',
		text = {
			"Gains {C:chips}+#1#{} Chips",
			"when played",
		}
	},
    atlas = 'Enhancements',
    pos = { x = 0, y = 0 },
    config = { bonus = 0, extra = { bonus_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.bonus_mod } }
    end,
    calculate = function(self, card, context)    
        if context.before and context.cardarea == G.play.cards then
            card.ability.bonus = card.ability.bonus + card.ability.extra.bonus_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end
    end
}
