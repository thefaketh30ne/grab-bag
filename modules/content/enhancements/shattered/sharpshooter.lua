SMODS.Enhancement {
    key = 'sharpshooter',
    loc_txt = {
		name = 'Sharpshooter Card',
		text = {
			"{C:green}#1# in #2# chance{} for {C:mult}+#3# Mult",
            "and {C:money}$#4#{} when scored",
            "{C:green}Probability{} increases by {C:attention}1",
            "when this {C:attention}fails{}",
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 4, y = 0 },
    config = { extra = { base_numerator = 1, mult = 20, odds = 10, money = 10 } },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.base_numerator, card.ability.extra.odds)
        return { vars = { new_numerator, new_denominator, card.ability.extra.mult, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, pseudoseed('gb_sharpshooter') + card.sort_id, card.ability.extra.base_numerator, card.ability.extra.odds) then
                return {
                    mult = card.ability.extra.mult,
                    dollars = card.ability.extra.money
                }
            else
                card.ability.extra.base_numerator = card.ability.extra.base_numerator + 1
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.GREEN
                }
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end
}