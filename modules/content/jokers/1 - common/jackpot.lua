SMODS.Joker {
	key = 'jackpot',
	loc_txt = {
		name = 'Jackpot',
		text = {
			"If {C:attention}scoring hand{} contains 3 {C:attention}7{}s,",
			"{C:attention}enhance{} all scoring {C:attention}7{}s",
            "and earn {C:money}$#1#{}"
		}
	},
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 1, y = 3 },
	cost = 4,
	blueprint_compat = false,
    config = { extra = { dollars = 7 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            local sevens = {}
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 7 then
                    table.insert(sevens, playing_card)
                end
            end
            if #sevens >= 3 then
                local valid_keys = {}
                for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
                        valid_keys[#valid_keys + 1] = enhancement_center.key
                    end
                end
                for _, playing_card in ipairs(sevens) do
                    playing_card:set_ability(pseudorandom_element(valid_keys, pseudoseed('jackpot')), nil, nil)
                    playing_card:juice_up()
                end
                return {
                    dollars = card.ability.extra.dollars,
                    message = "Enhanced!",
                    colour = G.C.FILTER
                }
            end
        end
    end
}