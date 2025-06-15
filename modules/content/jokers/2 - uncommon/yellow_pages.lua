SMODS.Joker {
	key = 'yellow_pages',
	loc_txt = {
		name = 'Yellow Pages',
		text = {
			"The first {C:attention}3{} cards to score",
			"give {C:mult}Mult{} equal to their rank",
		}
	},
	config = { extra = { scoring_tally = 0 } },
	rarity = 2,
	atlas = 'gb_Jokers',
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
				if not SMODS.has_no_rank(playing_card) then
                	card.ability.extra.scoring_tally = card.ability.extra.scoring_tally + 1
                	return {
                    	mult = context.other_card.base.nominal
                	} 
				end
            end
        end
    end
}