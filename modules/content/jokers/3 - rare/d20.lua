SMODS.Joker {
    key = 'd20',
    loc_txt = {
        name = 'D20',
        text = {
            "{C:green}#1# in #2#{} chance to",
            "{C:attention}enhance{} a drawn card",
        }
    },
    config = { extra = { odds = 20 } },
    rarity = 3,
    cost = 8,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 4 },
    blueprint_compat = true,
    soul_pos = { x = 8, y = 4 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn or context.other_drawn then
		    for _, playing_card in ipairs(context.hand_drawn or context.other_drawn) do
			    if SMODS.pseudorandom_probability(card, 'gb_d20', G.GAME.probabilities.normal, card.ability.extra.odds) then
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