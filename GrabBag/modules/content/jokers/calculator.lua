SMODS.Joker {
	key = 'calculator',
	loc_txt = {
		name = 'Calculator',
		text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "for every scored {C:attention}numbered{} card",
            "resets when {C:attention}Boss Blind{} is defeated",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
		}
	},
	config = { extra = { mult = 0, mult_mod = 2 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 6, y = 1 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() <= 10 and context.other_card:get_id() >= 2 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end
        if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss and card.ability.extra.mult > 0 then
                card.ability.extra.mult = 0
                return {
                    message = 'AC',
                    colour = G.C.RED
                }
            end
        end
	end
}