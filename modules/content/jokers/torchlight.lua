SMODS.Joker {
    key = 'torchlight',
    loc_txt = {
        name = 'Torchlight',
        text = {
            "{C:mult}+#1#{} Mult for every",
            "{C:attention}Joker{} to the left of this one",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
        }
    },
    config = { extra = { mult = 0, mult_mod = 5 } },
    rarity = 1,
    cost = 4,
    atlas = 'gb_Jokers',
    pos = { x = 5, y = 1 },
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local position = 0
        if card.area and card.area == G.jokers then
            for k, joker in ipairs(G.jokers.cards) do
                if joker == card then
                    position = k - 1
                    break
                end
            end
            return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult_mod * position } }
        else
            return { vars = { card.ability.extra.mult_mod, 0 } }
        end
            
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local position = 0
            for k, joker in ipairs(G.jokers.cards) do
                if joker == card then
                    position = k - 1
                    break
                end
            end
            card.ability.extra.mult = card.ability.extra.mult_mod * position
            return { 
                mult = card.ability.extra.mult
            }
        end
    end,
}