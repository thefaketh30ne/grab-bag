SMODS.Blind {
    key = "weave",
    loc_txt = {
        name = "The Weave",
        text = {
            "Halves current money",
            "if played hand has",
            "more than 3 cards",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 3 },
    boss = { min = 4 },
    boss_colour = HEX("bc35b7"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                if #G.play.cards > 3 then
                    blind.triggered = true
                    local half_dollars = math.floor(G.GAME.dollars / 2)
                    if half_dollars > 0 then
                        ease_dollars(-half_dollars, true)
                    end
                end
            end
        end
    end
}