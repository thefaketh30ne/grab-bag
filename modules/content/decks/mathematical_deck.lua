SMODS.Back {
    key = "mathematical",
    loc_txt = {
        name = "Mathematical Deck",
        text = {
            "Add {C:mult}Mult{} to {C:chips}Chips{}",
            "{C:red}X#1#{} base Blind size",
        }
    },
    atlas = "Cards",
    pos = { x = 0, y = 0 },
    config = { extra = { ante_scaling = 1.5 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.ante_scaling } }
    end,
    calculate = function(self, back, context)
        if context.final_scoring_step then
            hand_chips = hand_chips + mult
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