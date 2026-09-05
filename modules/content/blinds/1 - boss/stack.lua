SMODS.Blind {
    key = "stack",
    loc_txt = {
        name = "The Stack",
        text = {
            "Played hand must",
            "contain 2 numbered cards",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 31 },
    boss = { min = 1 },
    boss_colour = HEX("8493ab"),
    debuff_hand = function(self, cards, hand, handname, check)
        local number_tally = 0
        for _, card in pairs(cards) do
            if gb_is_number(card) then
                number_tally = number_tally + 1
            end
        end
        return number_tally < 2
    end,
    in_pool = function(self)
        local number_tally = 0
        for _, card in pairs(G.playing_cards or {}) do
            if gb_is_number(card) then
                number_tally = number_tally + 1
            end
        end
        if number_tally >= 10 then
            return true
        else
            return false
        end
    end
}