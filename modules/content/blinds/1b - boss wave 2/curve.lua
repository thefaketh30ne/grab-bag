SMODS.Blind {
    key = "curve",
    loc_txt = {
        name = "The Curve",
        text = {
            "Discarded cards are",
            "placed back",
            "into the deck"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 26 },
    boss = { min = 1 },
    boss_colour = HEX("94e3f5"),
    calculate = function(self, blind, context)
        if context.setting_blind then
            gb_discard_into_deck = true
        end
    end,
    disable = function(self)
        gb_discard_into_deck = nil
    end,
    defeat = function(self)
        gb_discard_into_deck = nil
    end
}