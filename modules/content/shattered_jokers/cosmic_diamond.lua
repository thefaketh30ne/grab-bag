SMODS.Joker {
    key = "cosmic_diamond",
    loc_txt = {
		name = 'Cosmic Diamond',
		text = {
			"Earn {C:money}$#1#{} at end of round",
			"Payout increases by {C:money}$#2#{} for every",
            "{C:attention}#4#{} scored {C:G.C.SUITS.Diamonds}Diamonds{} {C:inactive}(#3#/#4#)"
		}
	},
    blueprint_compat = true,
	atlas = 'ShatteredJokers',
	pos = { x = 0, y = 1 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { dollars = 1, dollars_mod = 1, diamond_tally = 0, diamonds = 7 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_mod, card.ability.extra.diamond_tally, card.ability.extra.diamonds } }
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
    calculate = function(self, card, context)
         if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") and not context.blueprint then
            card.ability.extra.diamond_tally = card.ability.extra.diamond_tally + 1
            if card.ability.extra.diamond_tally >= card.ability.extra.diamonds then
                card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_mod
                card.ability.extra.diamond_tally = card.ability.extra.diamond_tally - card.ability.extra.diamonds
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MONEY,
                    message_card = card
                }
            end
        end
    end
}