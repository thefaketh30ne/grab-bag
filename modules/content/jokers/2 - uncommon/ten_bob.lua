SMODS.Joker {
	key = 'ten_bob',
	loc_txt = {
		name = 'Ten Bob',
		text = {
            "At end of round, set {C:attention}sell value",
            "of a random held Joker to {C:money}$#1#{}",
            "If all held Jokers {C:attention}sell{} for {C:money}$#1#{},",
            "earn {C:money}$#1#{} at end of round"
		}
	},
	rarity = 2,
	atlas = 'Jokers',
    config = { extra = { dollars = 10, all_jokers_ten = false } },
    pixel_size = { w = 50 },
	pos = { x = 9, y = 0 },
	cost = 10,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calc_dollar_bonus = function(self, card)
        return (card.ability.extra.all_jokers_ten and card.ability.extra.dollars or 0)
    end,
    calculate = function(self, card, context)
        if context.end_of_round
        and context.main_eval
        and not context.blueprint then
            local valid_targets = {}
            for _, joker in pairs(G.jokers.cards) do
                if joker.sell_cost ~= card.ability.extra.dollars then
                    print(joker.sell_cost)
                    valid_targets[#valid_targets + 1] = joker
                end
            end
            local selected_joker = pseudorandom_element(valid_targets, pseudoseed('gb_ten_bob'))
            print(selected_joker)
            if selected_joker then
                selected_joker.sell_cost = 10
                card:juice_up()
                return {
                    message = "Sell Value Set!",
                    colour = G.C.MONEY,
                    message_card = selected_joker
                }
            else
                card.ability.extra.all_jokers_ten = true
            end
        end
        if context.starting_shop then
            card.ability.extra.all_jokers_ten = false
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        sell_cost = card.ability.extra.dollars
    end,
}
