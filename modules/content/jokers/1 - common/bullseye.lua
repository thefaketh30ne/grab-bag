SMODS.Joker {
    key = 'bullseye',
	loc_txt = {
		name = 'Bullseye',
		text = {
			"Earn {C:money}$#1#{} if there are",
            "exactly {C:attention}#2#{} hands remaining",
            "at end of round",
            "{C:inactive,s:0.85}(Hands needed changes every round)",
		}
	},
	config = { extra = { dollars = 8, hands_required = 0 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 4 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.hands_required } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            if G.GAME.current_round.hands_left == card.ability.extra.hands_required then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
            card.ability.extra.hands_required = math.floor(G.GAME.round_resets.hands * pseudorandom("gb_bullseye"))
        end
    end
}