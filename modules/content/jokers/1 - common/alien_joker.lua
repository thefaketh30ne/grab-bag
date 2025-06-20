SMODS.Joker {
    key = 'alien_joker',
	loc_txt = {
		name = 'Alien Joker',
		text = {
			"Upgrade played {C:attention}poker hand{}",
			"every {C:attention}#1#{}th hand played",
            "{C:inactive}({C:attention}#2#{C:inactive}/#1#)",
		}
	},
	config = { extra = { hand_tally = 0, hands = 5 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 1, y = 5 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands, card.ability.extra.hand_tally } }
	end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.hand_tally = card.ability.extra.hand_tally + 1
            if card.ability.extra.hand_tally >= card.ability.extra.hands then
                card.ability.extra.hand_tally = 0
                return {
                    level_up = true,
                    message = "Zorp!",
                    colour = G.C.FILTER
                }
            else
                return {
                    message = card.ability.extra.hand_tally .. '/' .. card.ability.extra.hands,
                    colour = G.C.FILTER
                }
            end
        end
    end
}