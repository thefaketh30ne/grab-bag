SMODS.Joker {
	key = 'empty_handed',
	loc_txt = {
		name = 'Empty Handed',
		text = {
            "{X:mult,C:white}X#1#{} Mult if all",
			"consumable slots are empty"
		}
	},
	config = { extra = { xmult = 2 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 6, y = 8 },
	cost = 5,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			    return {
                    xmult = card.ability.extra.xmult
                }
            end
		end
	end
}