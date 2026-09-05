SMODS.Joker {
	key = 'eye_chart',
	loc_txt = {
		name = 'Eye Chart',
		text = { {
            "Flips cards held in hand" ,
            "{C:attention}face-down{} when hand played"
        },
            {
            "This Joker gains {C:mult}+#2#{} Mult" ,
            "for each card flipped",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
		} }
	},
	config = { extra = { mult = 0, mult_mod = 1 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 4 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local cards_flipped = 0
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_card.facing == "front" then
                    playing_card:flip()
                    cards_flipped = cards_flipped + 1
                end
            end
            SMODS.scale_card(card, {
	            ref_table = card.ability.extra,
                ref_value = "mult",
	            scalar_value = "mult_mod",
                scalar_table = card.ability.extra,
                operation = function(ref_table, ref_value, initial, change)
	                ref_table[ref_value] = initial + cards_flipped * change
                end,
            })
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}