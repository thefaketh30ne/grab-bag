SMODS.Joker {
    key = 'dunce',
    loc_txt = {
        name = 'Dunce',
        text = {
            "This Joker gains {C:chips}+#1#{} Chips",
            "if {C:purple}Wheel of Fortune{}",
            "fails to trigger",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
        }
    },
    config = { extra = { chips = 0, chips_mod = 30 } },
    rarity = 1,
    atlas = 'gb_Jokers',
    pos = { x = 8, y = 0 },
    cost = 3,
    blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.wheel_of_fortune_fail and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end
}