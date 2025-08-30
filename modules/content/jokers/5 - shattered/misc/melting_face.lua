SMODS.Joker {
	key = 'melting_face',
	loc_txt = {
		name = 'Melting Face',
		text = {
			"{C:attention}Face{} cards give",
            "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult",
            "for every scoring {C:attention}face{} card",
		}
	},
	config = { extra = { mult = 2, chips = 15, faces = 0 } },
	blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 6, y = 0 },
    rarity = "gb_shattered",
    cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            card.ability.extra.faces = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_face() then
                    card.ability.extra.faces = card.ability.extra.faces + 1
                end
            end
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                chips = card.ability.extra.chips * card.ability.extra.faces,
                mult = card.ability.extra.mult * card.ability.extra.faces
            }
        end
    end
}