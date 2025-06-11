SMODS.Joker {
    key = 'd20',
    loc_txt = {
        name = 'D20',
        text = {
            "{C:green}#2# in #1#{} chance to",
            "{C:attention}enhance{} a drawn card",
        }
    },
    config = { extra = { odds = 20 } },
    rarity = 3,
    cost = 8,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 4 },
    soul_pos = { x = 8, y = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal or 1 } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn or context.other_drawn then
		    for _, playing_card in ipairs(context.hand_drawn or context.other_drawn) do
			    if pseudorandom('d20') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local valid_keys = {}
                    for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
                            valid_keys[#valid_keys + 1] = enhancement_center.key
                        end
                    end
                    playing_card:set_ability(
                        pseudorandom_element(valid_keys, pseudoseed('d20')),
                        nil,
                        nil
                    )
                    playing_card:juice_up()
                    return {
                        message = "Enhanced!",
                        colour = G.C.FILTER
                    }
                end
		    end
        end
    end
}