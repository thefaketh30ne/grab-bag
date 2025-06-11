SMODS.Joker {
    key = 'first_strike',
    loc_txt = {
        name = 'First Strike',
        text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult",
            "for each {C:attention}Blind{} skipped",
            "Resets when {C:attention}Boss Blind{} is defeated",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        }
    },
    config = { extra = { xmult = 1, xmult_mod = 1 } },
    rarity = 2,
    atlas = 'gb_Jokers',
    pos = { x = 1, y = 4 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss then
                card.ability.extra.xmult = 1
                return {
                    message = 'Reset',
                    colour = G.C.RED
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
