SMODS.Blind {
    key = "piper",
    loc_txt = {
        name = "The Piper",
        text = {
            "One random played card",
            "destroyed after scoring",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 2 },
    boss = { min = 3 },
    boss_colour = HEX("35bc4b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.before then
                local chosen_card = pseudorandom_element(context.full_hand, pseudoseed("gb_piper"))
                chosen_card.ability.piper_destroy = true
            end
            if context.destroy_card and context.destroy_card.ability.piper_destroy == true then
                return {
                    remove = true
                }
            end
        end
    end
}