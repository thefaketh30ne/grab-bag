SMODS.Joker {
    key = 'hadal_zone',
    loc_txt = {
        name = 'Hadal Zone',
        text = {
            "When hand is played, {C:green}#3# in #4#{} chance",
            "for this Joker to gain {X:mult,C:white}X#1#{} Mult",
            "and {C:attention}destroy{} a random scoring card",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        }
    },
    config = { extra = { xmult = 1, xmult_mod = 0.25, card_to_destroy = nil } },
    rarity = 1,
    atlas = 'gb_Jokers',
    blueprint_compat = true,
    pos = { x = 9, y = 5 },
    soul_pos = { x = 8, y = 5 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1, 2)
        return { vars = { 
            card.ability.extra.xmult_mod,
            card.ability.extra.xmult,
            new_numerator,
            new_denominator
        }}
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.card_to_destroy = nil
            if SMODS.pseudorandom_probability(card, 'gb_hadal_zone', 1, 2) then
                card.ability.extra.card_to_destroy = pseudorandom_element(context.scoring_hand, pseudoseed('gb_hadal_zone'))
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
        if context.destroy_card
        and not context.blueprint 
        and card.ability.extra.card_to_destroy then
            if context.destroy_card == card.ability.extra.card_to_destroy then
                return {
                    remove = true
                }
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end
}