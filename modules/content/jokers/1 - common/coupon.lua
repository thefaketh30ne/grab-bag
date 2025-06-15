SMODS.Joker {
	key = 'coupon',
	loc_txt = {
		name = 'Coupon',
		text = {
			"{C:green}#1# in #2# chance{} to refund",
			"cards purchased in the {C:attention}Shop{}",
		}
	},
	config = { extra = { odds = 3 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 1 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
    calculate = function(self, card, context)
        if context.buying_card then
            if pseudorandom('gb_coupon') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    dollars = context.card.cost,
                    message = "Refunded!",
                    colour = G.C.MONEY
                }
            end
        end
    end
}