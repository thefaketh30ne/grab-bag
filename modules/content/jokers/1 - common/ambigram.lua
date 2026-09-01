SMODS.Joker {
    key = "ambigram",
    loc_txt = {
        name = 'Ambigram',
        text = {
            "{C:attention}5{}s and {C:attention}8{}s give",
            "{C:chips}+#1#{} Chips when scored",
        }
    },
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'Jokers',
    pos = { x = 0, y = 2 },
    config = { extra = { chips = 55 } },
     loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if (id == 8) or (id == 5) then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}