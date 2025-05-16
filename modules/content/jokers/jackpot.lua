SMODS.Joker {
	key = 'jackpot',
	loc_txt = {
		name = 'Jackpot',
		text = {
			"Earn {C:money}$#1#{} if played hand",
			"contains three {C:attention}7{}s",
		}
	},
	config = { extra = { dollars = 7 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 3 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			local tally = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 7 then
					tally = tally + 1
				end
            end
			if tally >= 3 then
            	return {
                	dollars = card.ability.extra.dollars
				}
			end
		end
	end
}