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
                for _, scored_card in ipairs(context.full_hand) do
                    if next(SMODS.get_enhancements(scored_card)) and not scored_card.vampired then
                        scored_card.vampired = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:set_ability('c_base', nil, true)
                                scored_card:juice_up()
                                scored_card.vampired = nil
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end,
}