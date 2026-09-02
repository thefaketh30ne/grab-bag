SMODS.Blind {
    key = "stand",
    loc_txt = {
        name = "The Stand",
        text = {
            "Randomise suit",
            "of all played cards",
            "after scoring"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 25 },
    boss = { min = 2 },
    boss_colour = HEX("4c7773"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after then
                for _, playing_card in ipairs(G.play.cards) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            assert(SMODS.change_base(
                                playing_card,
                                playing_card.rank,
                                pseudorandom_element(SMODS.Suits, pseudoseed("gb_stand")).key,
                            ))
                            playing_card:juice_up()
                            return true
                        end
                    }))
                end
            end
        end
    end,
}