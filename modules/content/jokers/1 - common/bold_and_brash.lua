SMODS.Joker {
    key = 'bold_and_brash',
    loc_txt = {
        name = 'Bold and Brash',
        text = {
            "{C:blue}+#1#{} hand if discarded hand",
            "contains a {C:attention}#2#{}", 
        }
    },
    config = { extra = { hands = 1, hand_to_discard = "Two Pair" } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 2, y = 5 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands, card.ability.extra.hand_to_discard } }
	end,
    calculate = function(self, card, context)
        if context.pre_discard then
            local _, _, poker_hands = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
			if next(poker_hands[card.ability.extra.hand_to_discard]) then
                ease_hands_played(card.ability.extra.hands)
                return {
                    message = "+1 Hand",
                    colour = G.C.BLUE
                }
            end
		end
    end
}