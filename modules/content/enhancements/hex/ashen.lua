SMODS.Enhancement {
    key = 'ashen',
    loc_txt = {
		name = 'Ashen Card',
		text = {
			"{C:green}#1# in #2#{} chance to",
            "{C:attention}level up{} played poker hand",
            "if played and scoring"
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 2, y = 0 },
    config = { h_mult = 0, extra = { odds = 5 } },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)    
        if context.before and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'gb_ashen', 1, card.ability.extra.odds) then
                return {
                    level_up = true
                }
            else
                return {
                    message = localize("k_nope_ex"),
                    colour = G.C.SECONDARY_SET.Tarot,
					sound = 'cancel'
                }
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end
}