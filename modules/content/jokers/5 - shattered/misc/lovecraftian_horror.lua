SMODS.Joker {
    key = 'lovecraftian_horror',
    loc_txt = {
        name = 'Lovecraftian Horror',
        text = {
            "When a card is discarded, {C:green}#3# in #4#{} chance",
            "for this Joker to gain {X:mult,C:white}X#2#{} Mult",
            "and {C:attention}destroy{} the discarded card",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
        }
    },
    config = { extra = { xmult = 1, xmult_mod = 0.25, odds = 6 } },
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 5, y = 2 },
    soul_pos = { x = 6, y = 2 },
    rarity = "gb_shattered",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = {
            card.ability.extra.xmult,
            card.ability.extra.xmult_mod,
            new_numerator, 
            new_denominator
        } }
    end,
    calculate = function(self, card, context)
        if context.discard then
            if SMODS.pseudorandom_probability(card, 'gb_lovecraftian_horror', 1, card.ability.extra.odds) then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "xmult_mod",
                    message_colour = G.C.MULT
                })
                return {
                    remove = true
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}