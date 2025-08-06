SMODS.Joker {
	key = '13_leaf_clover',
	loc_txt = {
		name = '13 Leaf Clover',
		text = {
            "While in a {C:attention}Blind{},",
            "the first {C:attention}#1# {C:green}probability rolls{}",
            "will {C:attention}always succeed",
            "All subsequent {C:green}probability rolls{}",
            "will {C:attention}always fail",
            "{C:inactive}({C:attention}#2#{C:inactive}/#1# left)"
		}
	},
	config = { extra = { successes = 4, rolls_left = 4 } },
	rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 6, y = 6 },
	cost = 7,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.successes, card.ability.extra.rolls_left } }
	end,
    calculate = function(self, card, context)
        if context.fix_probability and G.GAME.in_blind then
            if card.ability.extra.rolls_left > 0 then
                return {
                    numerator = context.denominator
                }
            else
                return {
                    numerator = 0
                }
            end
        end
        if context.setting_blind then
            card.ability.extra.rolls_left = card.ability.extra.successes
            return {
                message = card.ability.extra.rolls_left .. "/" .. card.ability.extra.successes,
                colour = G.C.GREEN
            }
        end
        if context.pseudorandom_result and context.result and not context.blueprint then
            card.ability.extra.rolls_left = card.ability.extra.rolls_left - 1
            return {
                message = card.ability.extra.rolls_left .. "/" .. card.ability.extra.successes,
                colour = G.C.GREEN
            }
        end
    end
}