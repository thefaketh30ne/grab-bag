SMODS.Joker {
	key = 'snooker_balls',
	loc_txt = {
		name = 'Snooker Balls',
		text = {
			"{C:attention}Flushes{} can be played",
            "with {C:attention}2{} suits"
		}
	},
	rarity = 2,
	atlas = 'Jokers',
    config = { extra = { active = false } },
	pos = { x = 2, y = 9 },
	cost = 7,
	blueprint_compat = true,
    calculate = function(self, card, context)
        if context.evaluate_poker_hand then
            if gb_could_count_as_exactly_x_suits(context.full_hand, 2)
            and #context.full_hand >= SMODS.four_fingers("flush") then
                card.ability.extra.active = true
                return {
                    replace_scoring_name = "Flush"
                }
            else
                card.ability.extra.active = false
            end
        end
        if context.modify_scoring_hand and card.ability.extra.active then
            return {
                add_to_hand = true
            }
        end
	end
}