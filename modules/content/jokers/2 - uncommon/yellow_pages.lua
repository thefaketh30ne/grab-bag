SMODS.Joker {
	key = 'yellow_pages',
	loc_txt = {
		name = 'Yellow Pages',
		text = {
			"The first {C:attention}#1#{} scoring",
			"{C:attention}numbered{} cards give",
			"{C:mult}Mult{} equal to their rank",
		}
	},
	config = { extra = { scoring_tally = 0, cards_to_retrigger = 3 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 7, y = 1 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards_to_retrigger } }
	end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.scoring_tally = 0
        end
        if context.individual and context.cardarea == G.play
		and card.ability.extra.scoring_tally < card.ability.extra.cards_to_retrigger
		and not SMODS.has_no_rank(context.other_card)
		and context.other_card:get_id() >= 2
		and context.other_card:get_id() <= 10 then
			if not (context.blueprint or context.repetition_only) then
                card.ability.extra.scoring_tally = card.ability.extra.scoring_tally + 1
			end
            return {
                mult = context.other_card.base.nominal
            }
        end
    end
}