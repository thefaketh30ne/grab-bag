SMODS.Joker {
	key = 'the_jolly',
	loc_txt = {
		name = 'The Jolly',
		text = {
			"If played hand contains a {C:attention}#1#{},",
            "{C:attention}1{} random scoring card",
            "{C:attention}permanently{} gains {C:mult}+#2#{} Mult",
		}
	},
	config = { extra = { hand_type = "Pair", mult = 8, chosen_index = -1 } },
	blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 2, y = 3 },
    soul_pos = { x = 7, y = 2 },
    rarity = "gb_shattered",
    cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hand_type, card.ability.extra.mult } }
	end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            card.ability.extra.chosen_index = -1
        end
        if context.before then
            if next(context.poker_hands[card.ability.extra.hand_type]) then
                card.ability.extra.chosen_index = pseudorandom('gb_the_jolly', 1, #context.scoring_hand)
            end
        end
        if context.individual and context.cardarea == G.play then
            local current_index = 0
            for k, playing_card in ipairs(context.scoring_hand) do
                if playing_card == context.other_card then
                    current_index = k
                    break
                end
            end
            if current_index == card.ability.extra.chosen_index then
                context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT,
                    message_card = context.other_card
                }
            end
        end
    end
}