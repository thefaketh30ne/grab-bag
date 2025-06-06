SMODS.Joker {
    key = "honeycomb",
    loc_txt = {
        name = 'Honeycomb',
        text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult",
            "for every {C:attention}#2# Honey Cards{} drawn",
            "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
            "{C:inactive}({C:attention}#4#{C:inactive}/#2#)",
        }
    },
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'gb_Jokers',
    pos = { x = 0, y = 5 },
    config = { extra = { xmult = 1, xmult_mod = 0.5, draw_tally = 0, card_draws = 6 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gb_honey
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.card_draws, card.ability.extra.xmult, card.ability.extra.draw_tally } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn then
            for _, playing_card in ipairs(context.hand_drawn) do
                if SMODS.has_enhancement(playing_card, 'm_gb_honey') then
                    card.ability.extra.draw_tally = card.ability.extra.draw_tally + 1
                    if card.ability.extra.draw_tally >= card.ability.extra.card_draws then
                        card.ability.extra.draw_tally = 0
                        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.MULT,
                            message_card = card
                        }
                    end
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end
}