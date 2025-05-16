SMODS.Joker {
	key = 'polariser',
	loc_txt = {
		name = 'Polariser',
		text = {
			"Scored {C:attention}Bonus Cards{} give {C:mult}+#1#{} Mult",
			"Scored {C:attention}Mult Cards{} give {C:chips}+#2#{} Chips",
		}
	},
	config = { extra = { mult = 4, chips = 30 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 4, y = 0 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_bonus') then
            return {
                mult = card.ability.extra.mult
			}
        end
		if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_mult') then
            return {
                chips = card.ability.extra.chips
			}
        end
    end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_mult') or SMODS.has_enhancement(playing_card, 'm_bonus') then
                return true
            end
        end
        return false
    end
}
