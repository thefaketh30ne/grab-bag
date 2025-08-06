SMODS.Joker {
    key = "golden_ratio",
    loc_txt = {
		name = 'Golden Ratio',
		text = {
			"Scored {C:attention}Ace{}s, {C:attention}3{}s, {C:attention}6{}s and {C:attention}8{}s",
			"are enhanced to {C:attention}Gold Cards{}",
            "and give {X:mult,C:white}X#1#{} Mult",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 4, y = 1 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local cards = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if (
                scored_card:get_id() == 3
                or scored_card:get_id() == 6
                or scored_card:get_id() == 8
                or scored_card:get_id() == 14
                ) then
                    cards = cards + 1
                    scored_card:set_ability('m_gold', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if cards > 0 then
                return {
                    message = localize('k_gold'),
                    colour = G.C.MONEY
                }
            end
        end
        if context.individual and context.cardarea == G.play and
            (
                context.other_card:get_id() == 3
                or context.other_card:get_id() == 6
                or context.other_card:get_id() == 8
                or context.other_card:get_id() == 14
            ) then
            return {
                xmult = card.ability.extra.xmult
			}
        end
    end
}