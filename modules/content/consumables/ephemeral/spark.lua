SMODS.Consumable {
    key = "spark",
    set = "Ephemeral",
    loc_txt = {
        name = 'Spark',
        text = {
            "Adds {C:attention}20%{} of blind",
            "requirement to current score",
        }
    },
    atlas = 'gb_Ephemerals',
    pos = { x = 1, y = 2 },
    use = function(self, card, area, copier)
        G.GAME.chips = G.GAME.chips + (G.GAME.blind.chips * 0.2)
        if G.GAME.chips > G.GAME.blind.chips then
            G.STATE = G.STATES.HAND_PLAYED
            G.STATE_COMPLETE = true
            end_round()
        end
    end,
    can_use = function(self, card)
        if G.hand and G.GAME.blind.in_blind then
            return true
        else
            return false
        end
    end
}