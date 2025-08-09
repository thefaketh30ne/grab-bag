SMODS.Back {
    key = "frankendeck",
    loc_txt = {
        name = "Frankendeck",
        text = {
            "Combine the first {C:attention}5 Vanilla{} decks",
            "All shops cost {C:white,X:money}X1.5{} as much"
        }
    },
    -- TODO: SHOP COST MULTIPLIER
    config = {
        discards = 1,
        dollars = 10,
        extra_hand_bonus = 2,
        extra_discard_bonus = 1,
        no_interest = true,
        joker_slot = 1
    },
    atlas = "gb_Decks",
    pos = { x = 5, y = 0 },
    apply = function(self, back)
        G.GAME.gb_cost_multiplier = 1.5
    end,
}