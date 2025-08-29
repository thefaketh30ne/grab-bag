GB.Hex {
    key = 'slothful_hex',
    atlas = 'gb_Hexes',
    pos = { x = 1, y = 0 },
    badge_colour = HEX("2D8248"),
    loc_txt = {
        name = "Slothful",
        text = {
            "{C:green}#1# in #2# chance{} to",
            "not score when played"
        },
        label = "Slothful",
    },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability[self.key].extra.odds)
		return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.modify_scoring_hand and context.other_card == card then
            if SMODS.pseudorandom_probability(card, 'slothful', 1, card.ability[self.key].extra.odds) then
                return {
                    remove_from_hand = true
                }
            end
        end
    end
}