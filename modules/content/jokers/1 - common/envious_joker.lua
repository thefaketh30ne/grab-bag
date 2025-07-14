SMODS.Joker {
	key = 'envious_joker',
	loc_txt = {
		name = 'Envious Joker',
		text = {
            "Played cards with",
            "{C:gb_eyes}Eyes{} suit give",
            "{C:mult}+#1#{} Mult when scored",
		}
	},
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 0, y = 6 },
	cost = 5,
	blueprint_compat = true,
    config = { extra = { mult = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit("gb_Eyes") then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
