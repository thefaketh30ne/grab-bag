SMODS.Joker {
    key = 'divination',
    loc_txt = {
        name = 'Divination',
        text = {
            "{C:green}#1# in #2#{} chance to create",
            "a random {C:spectral}Spectral{} card when",
            "any {C:attention}Booster Pack{} is skipped",
        }
    },
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 5, y = 0 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster then
            if SMODS.pseudorandom_probability(card, 'gb_divination', G.GAME.probabilities.normal, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                        SMODS.add_card {
                            set = 'Spectral',
                            key_append = 'gb_divination'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = "+1 Spectral",
                    colour = G.C.SECONDARY_SET.Spectral,
                }
            end
        end
    end
}
