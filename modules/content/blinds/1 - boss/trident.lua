SMODS.Blind {
    key = "trident",
    loc_txt = {
        name = "The Trident",
        text = {
            "Permanently debuffs",
            "unscored cards",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 10 },
    boss = { min = 3 },
    boss_colour = HEX("35bc9c"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            local triggered = false
            if context.individual and context.cardarea == "unscored" then
                context.other_card:juice_up()
                context.other_card.ability.perma_debuff = true
                triggered = true
            end
            if triggered then
                blind.triggered = true
            end
        end
    end
}