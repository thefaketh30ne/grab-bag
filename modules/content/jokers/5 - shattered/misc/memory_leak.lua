SMODS.Joker {
    key = 'memory_leak',
    loc_txt = {
        name = 'Memory Leak',
        text = {
            "Gives between {X:mult,C:white}X#1#{} and {X:mult,C:white}X#2#{} Mult",
            "{C:attention}Maximum{} value {C:attention}increases{} by {X:mult,C:white}X#3#{}",
            "before hand scored"
        }
    },
    config = { extra = { xmult_min = 1, xmult_max = 1, xmult_mod = 0.2 } },
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 1, y = 2 },
    rarity = "gb_shattered",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_min, card.ability.extra.xmult_max, card.ability.extra.xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.xmult_max = card.ability.extra.xmult_max + card.ability.extra.xmult_mod
            local random_mult = pseudorandom('gb_memory_leak', card.ability.extra.xmult_min * 10, card.ability.extra.xmult_max * 10) * 0.1
            return {
                xmult = random_mult
            }
        end
    end
}
