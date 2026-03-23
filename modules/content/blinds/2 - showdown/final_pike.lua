SMODS.Blind {
    key = "final_pike",
    loc_txt = {
        name = "Platinum Pike",
        text = {
            "On Play or Discard,",
            "Discard all cards",
            "held in hand",
        }
    },
    dollars = 8,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 16 },
    boss = { showdown = true },
    boss_colour = HEX("a9b4b9"),
    config = { extra = { pause_triggering = false } },
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local any_selected = nil
                        local selection_limit = G.hand.config.highlighted_limit
                        G.hand.config.highlighted_limit = 10000
                        for _, playing_card in pairs(G.hand.cards) do
                            G.hand:add_to_highlighted(playing_card, true)
                            any_selected = true
                        end
                        if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                        G.hand.config.highlighted_limit = selection_limit
                        return true
                    end
                }))
                blind.triggered = true
                delay(0.7)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4); return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            elseif context.gb_after_discard and G.GAME.blind.effect.extra and not G.GAME.blind.effect.extra.pause_triggering then
                G.GAME.blind.effect.extra.pause_triggering = true -- don't want this discard to trigger it again
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local any_selected = nil
                        local selection_limit = G.hand.config.highlighted_limit
                        G.hand.config.highlighted_limit = 10000
                        for _, playing_card in pairs(G.hand.cards) do
                            G.hand:add_to_highlighted(playing_card, true)
                            any_selected = true
                        end
                        if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                        G.hand.config.highlighted_limit = selection_limit
                        G.GAME.blind.effect.extra.pause_triggering = false
                        return true
                    end
                }))
                blind.triggered = true
                delay(0.7)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4); return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
    end
}
