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
    boss = { min = 2 },
    boss_colour = HEX("5d6385"),
    debuff_hand = function(self, cards, hand, handname, check)
        if gb_count_suits(cards) > 2 then
            self.triggered = true
            return true
        else
            return false
        end
    end
}