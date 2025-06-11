SMODS.Blind {
    key = "lance",
    loc_txt = {
        name = "The Lance",
        text = {
            "All cards discarded",
            "this ante are",
            "drawn face down",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 14 },
    boss = { min = 1 },
    boss_colour = HEX("5d6d85"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card.ability.discarded_this_ante then
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