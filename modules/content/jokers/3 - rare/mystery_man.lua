SMODS.Joker {
    key = 'mystery_man',
	loc_txt = {
		name = 'Mystery Man',
		text = {
            "Played {C:attention}6{}s permanently",
            "gain {C:mult}+#1#{} Mult if scoring",
            
		}
	},
    config = { extra = { mult = 6} },
    rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 3 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before
        and context.cardarea == G.play
        and context.other_card:get_id() == 6 then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card,
                colour = G.C.MULT
            }
        end
    end
}