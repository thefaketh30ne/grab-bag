SMODS.Joker {
    key = 'roadside_oddity',
    loc_txt = {
        name = 'Roadside Oddity',
        text = {
            "The {C:attention}first{} and {C:attention}last{} scoring cards",
            "give {X:mult,C:white}X#1#{} Mult if played hand",
            "contains a {C:attention}Straight"
        }
    },
    rarity = 2,
    config = { extra = { xmult = 2 } },
    atlas = 'gb_Jokers',
    pos = { x = 8, y = 2 },
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.play
        and next(context.poker_hands[context.scoring_name]) then
            for k, search_card in ipairs(context.scoring_hand) do
                if context.other_card == search_card then
                    index = k
                    break
                end
            end
            if index
            and (index == #context.scoring_hand
            or index == 1) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
