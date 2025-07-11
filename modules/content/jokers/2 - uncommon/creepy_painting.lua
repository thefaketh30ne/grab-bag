SMODS.Joker{
    key = "creepy_painting",
    loc_txt = {
        name = 'Creepy Painting',
		text = {
            "{X:mult,C:white}X#1#{} Mult",
            "When {C:attention}Blind{} is selected, {C:green}#2# in #3# chance{}",
            "to destroy a random {C:attention}Joker{}",
            "and gain its sell value"
		}
    },
    config = { extra = { xmult = 2, odds = 2 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 5 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { card.ability.extra.xmult, new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.setting_blind 
            and not context.blueprint 
            and SMODS.pseudorandom_probability(card, 'gb_boing_ball', 1, card.ability.extra.odds) then
            local valid_targets = {}
            for _, joker in pairs(G.jokers.cards) do
                if joker ~= card
                    and not joker.ability.eternal 
                    and not joker.getting_sliced then
                    valid_targets[#valid_targets + 1] = joker
                end
            end
            local joker_to_destroy = pseudorandom_element(valid_targets, pseudoseed('gb_creepy_painting'))
            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                local joker_sell_value = joker_to_destroy.sell_cost
                card.sell_cost = card.sell_cost + joker_to_destroy.sell_cost
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
                return {
                    message = "+$" .. joker_sell_value,
                    colour = G.C.MONEY
                }
            end
            return {}
        end
    end
}