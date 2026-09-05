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
    config = { extra = { dollars = 10, triggered = false } },
    pos = { y = 27 },
    collection_loc_vars = function(self)
        return { vars = { '10' } }
    end,
    loc_vars = function(self)
        return { vars = { self.config.extra.dollars } }
    end,
    boss = { min = 3 },
    boss_colour = HEX("6be4b8"),
    calculate = function(self, blind, context)
        if context.end_of_round
        and SMODS.last_hand_oneshot
        and self.config.extra.triggered == false
        and not blind.disabled then
            self.config.extra.triggered = true
            ease_dollars(-self.config.extra.dollars)
        end
    end,
}