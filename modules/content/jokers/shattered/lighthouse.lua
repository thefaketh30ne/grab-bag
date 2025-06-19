SMODS.Joker {
    key = 'lighthouse',
    loc_txt = {
        name = 'Lighthouse',
        text = {
            "{X:mult,C:white}X#1#{} Mult for every",
            "{C:attention}Joker{} to the right of this one",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
        }
    },
    config = { extra = { xmult = 1, xmult_mod = 0.75 } },
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 2, y = 0 },
    rarity = "gb_shattered",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        local position = 0
        if card.area and card.area == G.jokers then
            for k, joker in ipairs(G.jokers.cards) do
                if joker == card then
                    position = #G.jokers.cards - k
                    break
                end
            end
            return { vars = { card.ability.extra.xmult_mod, 1 + card.ability.extra.xmult_mod * position} }
        else
            return { vars = { card.ability.extra.xmult_mod, 1 } }
        end
            
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local position = 0
            for k, joker in ipairs(G.jokers.cards) do
                if joker == card then
                    position = #G.jokers.cards - k
                    break
                end
            end
            card.ability.extra.xmult = 1 + card.ability.extra.xmult_mod * position
            return { 
                xmult = card.ability.extra.xmult
            }
        end
    end,
}