SMODS.Joker {
	key = 'calculator',
	loc_txt = {
		name = 'Calculator',
		text = {
            "This Joker gains {C:chips}+#1#{} Chips",
            "for every scored {C:attention}numbered{} card",
            "resets when {C:attention}Boss Blind{} is defeated",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
		}
	},
	config = { extra = { chips = 0, chips_mod = 7 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 6, y = 1 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() <= 10 and context.other_card:get_id() >= 2 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS,
                    message_card = card
                }
            end
        end
        if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss and card.ability.extra.chips > 0 then
                card.ability.extra.chips = 0
                return {
                    message = 'AC',
                    colour = G.C.RED
                }
            end
        end
	end
}