SMODS.Joker {
	key = 'yellow_pages',
	loc_txt = {
		name = 'Yellow Pages',
		text = {
			"The first {C:attention}3{} scoring cards",
			"give {C:mult}Mult{} equal to their rank",
		}
	},
	config = { extra = { scoring_tally = 0 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 7, y = 1 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.scoring_tally = 0
        end
        if context.individual and context.cardarea == G.play and card.ability.extra.scoring_tally < 3 then
            for _, playing_card in ipairs(context.scoring_hand) do
                card.ability.extra.scoring_tally = card.ability.extra.scoring_tally + 1
                return {
                    mult = ID_TO_RANK(context.other_card:get_id())
                } 
            end
        end
    end
}

ID_TO_RANK = function(id)
    local ranks = {
        0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
    }
    return ranks[id]
end