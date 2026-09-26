SMODS.Joker {
    key = 'parasite',
	loc_txt = {
		name = 'Parasite',
		text = {
            "Level down an",
            "{C:attention}unplayed poker hand,",
            "then level up",
            "{C:attention}played poker hand"
		}
	},
	blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
    config = { extra = { poker_hand = "High Card" } },
	pos = { x = 3, y = 2 },
    rarity = "gb_shattered",
    cost = 10,
    calculate = function(self, card, context)
        if context.before then
            local poker_hands = {}
            for hand_name, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(hand_name)
                and hand_name ~= context.scoring_name
                and G.GAME.hands[hand_name].level > 1 then
                    poker_hands[#poker_hands + 1] = hand_name
                end
            end
            print(poker_hands)
            if #poker_hands > 0 then
                card.ability.extra.poker_hand = pseudorandom_element(poker_hands, 'gb_j_parasite')
                SMODS.upgrade_poker_hands({
                    hands = card.ability.extra.poker_hand,
                    level_up = -1
                })
                SMODS.upgrade_poker_hands({
                    hands = context.scoring_name,
                    level_up = 1
                })
            end
        end
    end
}






