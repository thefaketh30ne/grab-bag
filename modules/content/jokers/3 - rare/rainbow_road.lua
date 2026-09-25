SMODS.Joker {
    key = "rainbow_road",
    loc_txt = {
		name = 'Rainbow Road',
		text = {
			"{C:attention}Wild Cards{} have a",
            "{C:green}#1# in #2# chance{} to {C:attention}level up",
            "played {C:attention}poker hand{} when scored"
		}
	},
    blueprint_compat = true,
    atlas = 'Jokers',
    rarity = 3,
    cost = 7,
    pos = { x = 7, y = 9 },
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'gb_rainbow_road')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_wild") and
        SMODS.pseudorandom_probability(card, 'gb_rainbow_road', 1, card.ability.extra.odds) then
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
    end
}
