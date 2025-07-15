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
		local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1, card.ability.extra.odds)
    	return { vars = { new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
        if context.buying_card and context.card ~= card then
            if SMODS.pseudorandom_probability(card, 'gb_coupon', 1, card.ability.extra.odds) then
                return {
                    dollars = context.card.cost,
                    message = "Refunded!",
                    colour = G.C.MONEY
                }
            end
        end
    end
}