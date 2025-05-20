SMODS.Joker {
	key = 'supercharger',
	loc_txt = {
		name = 'Supercharger',
		text = {
			"{C:attention}Bonus Cards{} and {C:attention}Mult Cards{}",
			"give {X:mult,C:white}X#1#{} Mult when scored",
		}
	},
	config = { extra = { xmult = 1.5 } },
	blueprint_compat = true,
	atlas = 'ShatteredJokers',
	pos = { x = 3, y = 1 },
    rarity = "gb_shattered",
    cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_bonus') then
            return {
                xmult = card.ability.extra.xmult
			}
        end
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_mult') then
            return {
                chips = card.ability.extra.chips
			}
        end
    end
}