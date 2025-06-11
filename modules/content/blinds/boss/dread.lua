SMODS.Blind {
    key = "dread",
    loc_txt = {
        name = "The Dread",
        text = {
            "Cannot play more",
            "than two suits",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 12 },
    boss = { min = 6 },
    boss_colour = HEX("5d6385"),
    debuff_hand = function(self, cards, hand, handname, check)
        local scored_suits = {}
        for _, card in pairs(cards) do
            if card.base.suit and not scored_suits[card.base.suit] then scored_suits[card.base.suit] = true end
        end
        local suit_count = 0
            for _, _ in pairs(scored_suits) do
                suit_count = suit_count + 1
            end
        if suit_count > 2 then
            return true
        else
            return false
        end
    end
}