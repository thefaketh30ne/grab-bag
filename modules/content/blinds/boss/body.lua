SMODS.Blind {
    key = "body",
    loc_txt = {
        name = "The Body",
        text = {
            "Enhanced cards are",
            "drawn face down",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 5 },
    boss = { min = 6 },
    boss_colour = HEX("35acbc"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                next(SMODS.get_enhancements(context.other_card)) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}