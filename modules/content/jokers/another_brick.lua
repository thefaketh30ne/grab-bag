SMODS.Joker {
    key = "another_brick",
    loc_txt = {
                name = 'Another Brick',
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "for each {C:attention}Stone Card{C:attention}",
                    "in first hand",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",	
                }
            },
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'Jokers',
    pos = { x = 3, y = 1 },
    config = { extra = { xmult = 1, xmult_mod = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult }}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }   
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end
}