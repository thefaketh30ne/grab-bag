SMODS.Joker{
    key = 'taxman',
    loc_txt = {
        name = 'Taxman',
        text = {
            "{C:attention}Taxes half{} of your {C:attention}cashout",
            "and gains {C:chips}+#2#{} Chips",
            "for every {C:money}$1{} taken",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    },
    config = { extra = { chips = 0, chips_mod = 5 } },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    atlas = 'Jokers',
    pos = { x = 5, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod } }
    end,
    calculate = function(self, card, context)
        if context.cashed_out then
            local tax = math.floor(context.cashout_dollars / 2)
            if tax > to_big(0) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    blockable = false,
                    func = function()
                        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod * tax
                        ease_dollars(-tax)
                        SMODS.calculate_effect({ message = "Taxed!", colour = G.C.MONEY }, card)
                        return true
                    end
                }))
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}