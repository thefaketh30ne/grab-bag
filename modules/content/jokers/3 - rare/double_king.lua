SMODS.Joker {
	key = 'double_king',
	loc_txt = {
		name = 'Double King',
		text = {
			"If played hand contains two {C:attention}Kings{},",
			"this joker gains {X:mult,C:white}X#1#{} Mult and",
			"{C:red}destroys{} the leftmost {C:attention}King{}",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	config = { extra = { xmult = 1, xmult_mod = 0.5, king_removed = false, activates = false } },
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 2 },
	cost = 7,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
    calculate = function(self, card, context)
		if context.before then
			card.ability.extra.king_removed = false
			card.ability.extra.activates = false
			local tally = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 13 then
					tally = tally + 1
				end
            end
			if tally >= 2 then
				card.ability.extra.activates = true
				SMODS.scale_card(card, {
                	ref_table = card.ability.extra,
                	ref_value = "xmult",
                	scalar_value = "xmult_mod",
                	message_colour = G.C.MULT
            	})
			end
		end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
			}
		end
		if context.destroy_card then
			if card.ability.extra.activates then
				for _, playing_card in ipairs(context.scoring_hand) do
					if playing_card:get_id() == 13 and context.destroy_card == playing_card and not card.ability.extra.king_removed then
						card.ability.extra.king_removed = true
						return { remove = true }
					end
				end
			end
		end
	end
}