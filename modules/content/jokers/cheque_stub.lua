SMODS.Joker {
	key = 'cheque_stub',
	loc_txt = {
		name = 'Cheque Stub',
		text = {
            "At end of round, earn {C:money}$#1#{}",
            "and {C:attention}destroy{} leftmost",
            "card held in hand"
		}
	},
	config = { extra = { dollars = 4 } },
    pixel_size = { w = 54 },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 7, y = 0 },
	cost = 8,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
	end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
    calculate = function(self, card, context)
	    if context.end_of_round and context.main_eval then
            if G.hand.cards[1] then
                G.hand.cards[1]:start_dissolve()
                return { remove = true }
            end
        end
    end
}