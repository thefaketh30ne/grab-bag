SMODS.Joker {
    key = "journal_3",
    loc_txt = {
        name = 'Journal 3',
        text = {
            "{C:attention}3{}s give {C:mult}+#1#{} Mult",
            "when scored for every",
            "{C:attention}3{} scored this hand"
        }
    },
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'Jokers',
    pos = { x = 7, y = 8 },
    config = { extra = { mult = 3, threes = 0 } },
     loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 3) then
                card.ability.extra.threes = card.ability.extra.threes + 1
                return {
                    mult = card.ability.extra.mult * card.ability.extra.threes
                }
            end
        end
        if context.after then
            card.ability.extra.threes = 0
        end
    end
}