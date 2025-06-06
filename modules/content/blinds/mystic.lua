SMODS.Blind {
    key = "Mystic",
    loc_txt = {
        name = "The Mystic",
        text = {
            "Played hand must",
            "contain a Face Card",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 6 },
    boss = { min = 1 },
    boss_colour = HEX("8135bc"),
    debuff_hand = function(self, cards, hand, handname, check)
        for _, card in pairs(cards) do
            if card:is_face() then return false end
        end
        return true
    end,
    in_pool = function(self)
        local face_cards = 0
        for _, card in pairs(G.playing_cards or {}) do
            if card:is_face() then
                face_cards = face_cards + 1
            end
        end
        if face_cards >= 10 then
            return true
        else
            return false
        end
    end
}