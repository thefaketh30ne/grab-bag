SMODS.Joker {
    key = 'waterfall',
    loc_txt = {
        name = 'Waterfall',
        text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "for each scoring {C:attention}River Card{}",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
        }
    },
    config = { extra = { mult = 0, mult_mod = 3 } },
    rarity = 1,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 3 },
    cost = 5,
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual
            and context.cardarea == G.play
            and SMODS.has_enhancement(context.other_card, 'm_gb_river')
            and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_gb_river') then
                return true
            end
        end
        return false
    end
}