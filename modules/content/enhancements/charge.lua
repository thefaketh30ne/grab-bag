SMODS.Enhancement {
    key = 'charge',
    loc_txt = {
		name = 'Charge Card',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
            "Gains {X:mult,C:white}X#2#{} Mult",
            "while held in hand",
            "{C:attention}Resets{} when played"
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 0, y = 0 },
    config = { x_mult = 1, extra = { xmult_mod = 0.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_mult, card.ability.extra.xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.after
        and context.cardarea == G.hand then
            SMODS.calculate_context({ charge_card_charged = true, increment = card.ability.extra.xmult_mod })
            card.ability.x_mult = card.ability.x_mult + card.ability.extra.xmult_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.after
        and context.cardarea == G.play then
            SMODS.calculate_context({ charge_card_reset = true, final_xmult = card.ability.x_mult })
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.ability.x_mult = 1
                    return true
                end
            }))
            return {
                message = localize("k_reset"),
                colour = G.C.FILTER,
                message_card = card
            }
        end
    end
}

