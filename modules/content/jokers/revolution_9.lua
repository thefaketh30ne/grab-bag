SMODS.Joker {
    key = 'revolution_9',
    loc_txt = {
        name = 'Revolution 9',
        text = {
            "Every {C:attention}#1#th{} {C:attention}9{} played",
            "gives {C:chips}+#2#{} Chips",
            "{C:inactive}({C:attention}#3#{C:inactive}/#1#)",
        }
    },
    config = { extra = { chips = 99, nine_tally = 0, total_nines = 9 } },
    rarity = 1,
    atlas = 'gb_Jokers',
    pos = { x = 2, y = 1 },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.total_nines, 
            card.ability.extra.chips, 
            card.ability.extra.nine_tally 
        }}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 9 then
                card.ability.extra.nine_tally = card.ability.extra.nine_tally + 1
                if card.ability.extra.nine_tally >= card.ability.extra.total_nines then
                    card.ability.extra.nine_tally = 0
                    return {
                        chips = card.ability.extra.chips,
                        message = 'Nine!',
                        colour = G.C.FILTER,
                        message_card = card,
                    }
                end
            end
        end
    end,
}