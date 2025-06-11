SMODS.Blind {
    key = "cross",
    loc_txt = {
        name = "The Cross",
        text = {
            "Divides all listed ",
            "probabilities by 10",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 9 },
    boss = { min = 4 },
    boss_colour = HEX("53c45c"),
    set_blind = function(self)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * 0.1
    end,
    disable = function(self)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * 10
    end,
    defeat = function(self)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * 10
    end
}