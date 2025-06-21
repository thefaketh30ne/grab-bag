SMODS.Back {
    key = "mathematical",
    loc_txt = {
        name = "Mathematical Deck",
        text = {
            "Swap {C:chips}Chips{} and {C:mult}Mult{} before scoring",
            "{C:red}X#1#{} base Blind size",
        }
    },
    atlas = "gb_Cards",
    pos = { x = 0, y = 0 },
    config = { extra = { ante_scaling = 2 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.ante_scaling } }
    end,
    calculate = function(self, back, context)
        if context.modify_hand then
            local temp = mult
            mult = hand_chips
            hand_chips = temp
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    return true
                end
            }))
        delay(0.6)
        end
    end,
    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.extra.ante_scaling
    end,
}