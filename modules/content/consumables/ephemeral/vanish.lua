SMODS.Consumable {
    key = "vanish",
    set = "Ephemeral",
    loc_txt = {
        name = 'Vanish',
        text = {
            "{C:red}+#1#{} discards for this blind",
        }
    },
    config = {extra = { discards = 2 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 0, y = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.discards } }
    end,
    use = function(self, card, area, copier)
        ease_discard(self.config.extra.discards)
    end,
    can_use = function(self, card)
        if G.hand and G.GAME.blind.in_blind then
            return true
        else
            return false
        end
    end,
}