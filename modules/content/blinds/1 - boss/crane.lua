SMODS.Blind {
    key = "crane",
    loc_txt = {
        name = "The Crane",
        text = {
            "Cards are drawn",
            "face-down after Discard"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 23 },
    boss = { min = 3 },
    boss_colour = HEX("515968"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.pre_discard then
                blind.prepped = true
            end
            if context.stay_flipped and context.to_area == G.hand and blind.prepped then
                return {
                    stay_flipped = true
                }
            end
        end
        if context.setting_blind or context.hand_drawn then
            blind.prepped = nil
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

