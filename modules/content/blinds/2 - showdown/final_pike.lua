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
    calculate = function(self, blind, context)
        if not blind.disabled then
            if (context.pre_discard or context.before) and not context.hook then
                local selection_limit = G.hand.config.highlighted_limit
                G.hand.config.highlighted_limit = 1000
                local any_selected = false
                for _, playing_card in pairs(G.hand.cards) do
                    if not playing_card.highlighted then
                        G.hand:add_to_highlighted(playing_card, true)
                        any_selected = true
                    end
                end
                if any_selected then 
                    G.FUNCS.discard_cards_from_highlighted(nil, true) 
                end
                G.hand.config.highlighted_limit = selection_limit
                blind.triggered = true
            end
        end
    end
}