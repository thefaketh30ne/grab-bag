SMODS.Joker {
    key = "purple_rain",
    loc_txt = {
		name = 'Purple Rain',
		text = {
			"Retriggers every {C:attention}scoring card{} once",
            "for every {C:attention}non-scoring card{}",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 3, y = 0 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { repetitions = 0 } },
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            card.ability.extra.repetitions = 0
            for _, _ in ipairs(context.full_hand) do
                card.ability.extra.repetitions = card.ability.extra.repetitions + 1
            end
            for _, _ in ipairs(context.scoring_hand) do
                card.ability.extra.repetitions = card.ability.extra.repetitions - 1
            end
        end
        if context.repetition and context.cardarea == G.play then	
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}