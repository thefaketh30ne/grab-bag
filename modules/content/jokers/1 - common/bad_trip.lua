SMODS.Joker {
    key = "bad_trip",
    loc_txt = {
        name = 'Bad Trip',
        text = {
            "{C:chips}+#1#{} Chips",
            "{C:chips}#2#{} Chips for each unique",
            "poker hand played this run",
            "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
        }
    },
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'Jokers',
    pos = { x = 6, y = 0 },
    config = { extra = { base_chips = 100, chips_mod = -10, chips = 100 } },
    loc_vars = function(self, info_queue, card)
        if G.GAME.hands then
            local unique_poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.played ~= 0 and v.visible then
                    table.insert(unique_poker_hands, k)
                end
            end
            return { vars = { card.ability.extra.base_chips, card.ability.extra.chips_mod, math.max(card.ability.extra.base_chips + (card.ability.extra.chips_mod * #unique_poker_hands), 0) } }
        else
            return { vars = { card.ability.extra.base_chips, card.ability.extra.chips_mod, card.ability.extra.base_chips } }
        end
        
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local unique_poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.played ~= 0 and v.visible then
                    table.insert(unique_poker_hands, k)
                end
            card.ability.extra.chips = math.max(card.ability.extra.base_chips + (card.ability.extra.chips_mod * #unique_poker_hands), 0)
            end
            if G.GAME.hands[context.scoring_name] == 1 then
                return {
                    message = "Downgraded!",
                    colour = G.C.CHIPS,
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}