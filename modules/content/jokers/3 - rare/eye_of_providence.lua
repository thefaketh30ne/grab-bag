SMODS.Joker {
	key = 'eye_of_providence',
	loc_txt = {
		name = 'Eye of Providence',
		text = {
            "Balances {C:blue}Chips{} and {C:red}Mult{} by {V:1}#1#%{}",
            "for every scoring {C:gb_eyes}Eye{} card"
		}
	},
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 3, y = 6 },
	cost = 6,
	blueprint_compat = true,
    config = { extra = { balance_percent = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.balance_percent, colours = { HEX("C82DFF") } } }
    end,
    calculate = function(self, card, context)
        if context.final_scoring_step then
            local balance_value = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_suit("gb_Eyes") then
                    balance_value = balance_value + card.ability.extra.balance_percent * 0.01
                end
            end
            gb_partial_balance(hand_chips, mult, balance_value)
        end
    end,

    in_pool = function(self, args)
        return gb_is_suit_in_deck(suit_key)
    end
}
