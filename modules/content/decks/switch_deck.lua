SMODS.Back {
    key = "switch",
    loc_txt = {
        name = "Switch Deck",
        text = {
            "+#1# {C:blue}Hand{} on {C:attention}odd{} rounds",
            "+#1# {C:red}Discard{} on {C:attention}even{} rounds"
        }
    },
    atlas = "gb_Decks",
    pos = { x = 1, y = 0 },
    config = { stat_boost = 1 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.stat_boost } }
    end,
    calculate = function(self, back, context)
        if context.setting_blind then
            if G.GAME.round % 2 == 1 then
                ease_hands_played(self.config.stat_boost)
            else
                ease_discard(self.config.stat_boost)
            end
        end
    end
}