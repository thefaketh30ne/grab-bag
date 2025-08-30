SMODS.Joker {
	key = 'gamblers_fallacy',
	loc_txt = {
		name = 'Gambler\'s Fallacy',
		text = {
            "When a {C:green}probability roll {C:attention}fails,",
            "add {C:green}+#2#{} to all {C:green}listed probabilites",
            "{C:attention}Resets{} when one {C:attention}succeeds",
            "{C:inactive}(Currently {C:green}+#1#{C:inactive})"
		}
	},
	config = { extra = { fail_increase = 1, current_increase = 0 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 0, y = 7 },
	cost = 7,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        local fail_increase = card.ability.extra.fail_increase
        return { vars = { 
            card.ability.extra.current_increase,
            card.ability.extra.fail_increase
    } }
	end,
    calculate = function(self, card, context)
        if context.fix_probability then
            return {
                numerator = context.numerator + card.ability.extra.current_increase
            }
        end
        if context.pseudorandom_result and not context.blueprint then
            if context.result then
                card.ability.extra.current_increase = 0
                return {
                    message = localize("k_reset"),
                    colour = G.C.GREEN
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "current_increase",
                    scalar_value = "fail_increase",
                    message_colour = G.C.GREEN
                })
            end
        end
    end
}