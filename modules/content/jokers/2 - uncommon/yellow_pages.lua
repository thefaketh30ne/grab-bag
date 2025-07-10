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
	config = { extra = { scoring_tally = 0, cards_to_trigger = 3, trigger_cards = {} } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 7, y = 1 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.cards_to_trigger } }
	end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.scoring_tally = 0
			for _, playing_card in ipairs(context.scoring_hand) do
				if not SMODS.has_no_rank(playing_card)
				and playing_card:get_id() >= 2
				and playing_card:get_id() <= 10 then
					if card.ability.extra.scoring_tally >= card.ability.extra.cards_to_trigger then
						break
					else
						card.ability.extra.trigger_cards[#card.ability.extra.trigger_cards + 1] = playing_card
						card.ability.extra.scoring_tally = card.ability.extra.scoring_tally + 1
					end
				end
			end
        end
		if context.individual and context.cardarea == G.play then
			for _, trigger_card in ipairs(card.ability.extra.trigger_cards) do
				if context.other_card == trigger_card then
            		return {
                		mult = context.other_card.base.nominal
					}
				end
			end
        end
    end
}