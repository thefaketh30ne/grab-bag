GB.Hex {
    key = 'despot_hex',
    atlas = 'gb_Hexes',
    pos = { x = 4, y = 0 },
    badge_colour = HEX("807519"),
    config = { extra = { dollars = 2 } },
    loc_txt = {
        name = "Despot",
        text = {
            "When played, lose {C:red}$#1#{}",

        },
        label = "Despot",
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability[self.key].extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            ease_dollars(-card.ability[self.key].extra.dollars)
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    return true
                end
            }))
        end
    end
}