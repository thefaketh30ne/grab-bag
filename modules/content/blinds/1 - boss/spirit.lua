SMODS.Blind {
    key = "spirit",
    loc_txt = {
        name = "The Spirit",
        text = {
            "#1# in 3 chance",
            "Spades and Clubs are",
            "drawn face down",
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 0 },
    boss = { min = 3 },
    boss_colour = HEX("6035bc"),
    loc_vars = function(self)
        return { vars = { G.GAME.probabilities.normal or 1 } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1' } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                (context.other_card:is_suit("Spades") or context.other_card:is_suit("Clubs")) and
                SMODS.pseudorandom_probability(blind, 'gb_spirit', G.GAME.probabilities.normal, 3) then
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