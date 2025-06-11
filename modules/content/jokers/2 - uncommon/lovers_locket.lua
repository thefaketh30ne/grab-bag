SMODS.Joker {
    key = 'lovers_locket',
    loc_txt = {
        name = 'Lover\'s Locket',
        text = {
            "{C:attention}Wild Cards{} have a",
            "{C:green}#3# in #2#{} chance to",
            "give {X:mult,C:white}X#1#{} Mult when scored",	
        }
    },
    config = { extra = { odds = 2, xmult = 2 } },
    rarity = 2,
    atlas = 'gb_Jokers',
    pos = { x = 2, y = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult , card.ability.extra.odds, G.GAME.probabilities.normal or 1 } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_wild") and
            pseudorandom('gb_lovers_locket') < G.GAME.probabilities.normal / card.ability.extra.odds then
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