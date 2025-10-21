SMODS.Blind {
    key = "bolt",
    loc_txt = {
        name = "The Bolt",
        text = {
            "Randomise rank of",
            "all played cards",
            "after scoring"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 24 },
    boss = { min = 1 },
    boss_colour = HEX("75624c"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after then
                for _, scored_card in ipairs(context.full_hand) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            assert(SMODS.change_base(
                                scored_card,
                                nil,
                                pseudorandom_element(SMODS.Ranks, pseudoseed("gb_bolt")).key
                            ))
                            scored_card:juice_up()
                            scored_card.vampired = nil
                            return true
                        end
                    }))
                end
            end
        end
    end,
}