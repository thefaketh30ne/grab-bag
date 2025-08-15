SMODS.Back {
    key = "illusion",
    loc_txt = {
        name = "Illusion Deck",
        text = {
            "When {C:attention}Boss Blind{} is selected,",
            "create a {C:dark_edition}Negative {V:1}Ephemeral{} card"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX("8EA4B3") } } }
    end,
    atlas = "gb_Decks",
    pos = { x = 2, y = 0 },
    calculate = function(self, card, context)
        if context.setting_blind
        and context.blind.boss then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Ephemeral',
                                key_append = 'gb_illusion',
                                edition = 'e_negative'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    return true
                end)
            }))
            return nil, true
        end
    end,
}
