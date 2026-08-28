SMODS.Joker {
    key = 'recursion',
	loc_txt = {
		name = 'Recursion',
		text = {
			"Retrigger all played {C:attention}2{}s ",
            "{C:attention}#2#{} times"
		}
	},
    config = { extra = { repetitions = 2 } },
    rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 7 },
	cost = 8,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.threshold, card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition
        and context.cardarea == G.play
        and context.other_card:get_id() == 2 then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}