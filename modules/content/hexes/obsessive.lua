GB.Hex {
    key = 'obsessive_hex',
    atlas = 'gb_Hexes',
    pos = { x = 7, y = 0 },
    badge_colour = HEX("504584"),
    config = { extra = { dollars = 2 } },
    loc_txt = {
        name = "Obsessive",
        text = {
            "Lose {C:red}$#1#{} when discarded",
        },
        label = "Obsessive",
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability[self.key].extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            ease_dollars(-card.ability[self.key].extra.dollars)
        end
    end,
}