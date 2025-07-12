SMODS.Joker {
    key = 'lovers_locket',
    loc_txt = {
        name = 'Lover\'s Locket',
        text = {
            "{C:attention}Wild Cards{} have a",
            "{C:green}#2# in #3#{} chance to",
            "give {X:mult,C:white}X#1#{} Mult when scored",	
        }
    },
    config = { extra = { odds = 2, xmult = 2 } },
    rarity = 2,
    cost = 6,
    atlas = 'gb_Jokers',
    pos = { x = 2, y = 4 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { card.ability.extra.xmult, new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_wild") and
            SMODS.pseudorandom_probability(card, 'gb_lovers_locket', 1, card.ability.extra.odds) then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}