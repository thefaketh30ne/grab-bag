SMODS.Consumable {
    key = "incense",
    set = "Ephemeral",
    loc_txt = {
        name = 'Incense',
        text = {
            "{C:blue}+#1#{} hands for this blind",
        }
    },
    config = {extra = { hands = 2 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 7, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.hands } }
    end,
    use = function(self, card, area, copier)
        ease_hands_played(self.config.extra.hands)
    end,
    can_use = function(self, card)
        if G.hand and G.GAME.blind.in_blind then
            return true
        else
            return false
        end
    end,
}