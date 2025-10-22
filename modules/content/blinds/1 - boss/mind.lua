SMODS.Blind {
    key = "mind",
    loc_txt = {
        name = "The Mind",
        text = {
            "#1# in #2# chance",
            "Hearts and Diamonds are",
            "drawn face down",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 1 },
    boss = { min = 3 },
    boss_colour = HEX("bc7635"),
    loc_vars = function(self)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1, 3)
        return { vars = { new_numerator, new_denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1', '3' } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                (context.other_card:is_suit("Hearts") or context.other_card:is_suit("Diamonds")) and
                SMODS.pseudorandom_probability(blind, 'gb_mind', 1, 3) then
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