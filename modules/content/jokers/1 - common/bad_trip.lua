SMODS.Joker {
    key = "bad_trip",
    loc_txt = {
        name = 'Bad Trip',
        text = {
            "{C:mult}+#1#{} Mult",
            "{C:mult}#2#{} Mult for each unique",
            "poker hand played this run",
            "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
        }
    },
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'Jokers',
    pos = { x = 6, y = 0 },
    config = { extra = { base_mult = 25, mult_mod = -2, mult = 25 } },
    loc_vars = function(self, info_queue, card)
        if G.GAME.hands then
            local unique_poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.played ~= 0 and v.visible then
                    table.insert(unique_poker_hands, k)
                end
            end
            return { vars = { card.ability.extra.base_mult, card.ability.extra.mult_mod, math.max(card.ability.extra.base_mult + (card.ability.extra.mult_mod * #unique_poker_hands), 0) } }
        else
            return { vars = { card.ability.extra.base_mult, card.ability.extra.mult_mod, card.ability.extra.base_mult } }
        end
        
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local unique_poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.played ~= 0 and v.visible then
                    table.insert(unique_poker_hands, k)
                end
            card.ability.extra.mult = math.max(card.ability.extra.base_mult + (card.ability.extra.mult_mod * #unique_poker_hands), 0)
            end
            if G.GAME.hands[context.scoring_name] == 1 then
                return {
                    message = "Downgraded!",
                    colour = G.C.MULT,
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}