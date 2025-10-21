SMODS.Blind {
    key = "bell",
    loc_txt = {
        name = "The Bell",
        text = {
            "Unenhance all played",
            "cards after scoring"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 21 },
    boss = { min = 4 },
    boss_colour = HEX("6d4461"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.after then
                for _, played_card in ipairs(context.full_hand) do
                    if next(SMODS.get_enhancements(played_card)) and not played_card.vampired then
                        played_card.vampired = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                played_card:set_ability('c_base', nil, true)
                                played_card:juice_up()
                                played_card.vampired = nil
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end,
}