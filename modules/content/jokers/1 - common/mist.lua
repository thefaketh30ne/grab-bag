SMODS.Joker{
    key = "mist",
    loc_txt = {
        name = 'Mist',
		text = {
			"{C:chips}+#1#{} Chips for every",
            "{V:1}Ephemeral Card{} used this run",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
		}
    },
    config = { extra = { chips_mod = 10 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_mod,
                card.ability.extra.chips_mod * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.ephemeral or 0),
                colours = { HEX("8EA4B3") }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Ephemeral" and G.GAME.consumeable_usage_total.ephemeral then
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips_mod * G.GAME.consumeable_usage_total.ephemeral } },
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips_mod *
                    (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.ephemeral or 0)
            }
        end
    end,
}