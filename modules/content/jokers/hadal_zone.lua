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
    config = { extra = { xmult = 1, xmult_mod = 0.25, odds = 2, card_to_destroy = nil } },
    rarity = 1,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 5 },
    soul_pos = { x = 8, y = 5 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult_mod,
            card.ability.extra.xmult,
            G.GAME.probabilities.normal or 1, 
            card.ability.extra.odds 
        }}
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.card_to_destroy = nil
            if pseudorandom('gb_hadal_zone') >= G.GAME.probabilities.normal / card.ability.extra.odds then
                card.ability.extra.card_to_destroy = pseudorandom_element(context.scoring_hand, pseudoseed('gb_hadal_zone'))
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card,
                }
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