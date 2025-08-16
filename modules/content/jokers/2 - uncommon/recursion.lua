SMODS.Joker {
    key = 'recursion',
	loc_txt = {
		name = 'Recursion',
		text = {
			"If played hand contains",
            "{C:attention}#1#{} scoring {C:attention}2{}s, retrigger",
            "all played {C:attention}2{}s {C:attention}#2#{} times"
		}
	},
    config = { extra = { threshold = 2, repetitions = 2 } },
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
            local twos = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 2 then
                    twos = twos + 1
                end
            end
            if twos >= card.ability.extra.threshold then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}