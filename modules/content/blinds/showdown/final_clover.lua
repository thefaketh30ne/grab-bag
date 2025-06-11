SMODS.Blind {
    key = "final_clover",
    loc_txt = {
        name = "Celadon Clover",
        text = {
            "Shuffles all Jokers",
            "before scoring",
        }
    },
    dollars = 8,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 17 },
    boss = { showdown = true },
    boss_colour = HEX("80d585"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                if #G.jokers.cards > 1 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            for i = 1, 3 do
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle('gb_final_clover')
                                        play_sound('cardSlide1', 0.85)
                                        return true
                                    end
                                }))
                                delay(0.15)
                            end
                            delay(0.35)
                            return true
                        end
                    }))
                end
            end
        end
    end
}