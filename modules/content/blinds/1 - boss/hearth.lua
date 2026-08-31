SMODS.Blind {
    key = "hearth",
    loc_txt = {
        name = "The Hearth",
        text = {
            "Lose $#1# if",
            "score catches fire"

        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    config = { extra = { dollars = 10 } },
    pos = { y = 27 },
    loc_vars = function(self)
        return { vars = { self.config.extra.dollars } }
    end,
    boss = { min = 3 },
    boss_colour = HEX("6be4b8"),
    calculate = function(self, blind, context)
        if context.last_hand_oneshot and not blind.disabled then
            ease_dollars(-self.config.extra.dollars)
        end
    end,
}