SMODS.Joker {
	key = 'forest_fire',
	loc_txt = {
		name = 'Forest Fire',
		text = {
			"Enhances all played cards",
            "in final hand into {C:attention}Wooden Cards{}",
		}
	},
	rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 3 },
	cost = 7,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gb_wooden
	end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and G.GAME.current_round.hands_left == 0 then
            for _, scored_card in ipairs(context.full_hand) do
                scored_card:set_ability('m_gb_wooden', nil, true)
                 G.E_MANAGER:add_event(Event({
                    func = function()
                        scored_card:juice_up()
                        return true
                    end
                }))
            end
        end
    end
}