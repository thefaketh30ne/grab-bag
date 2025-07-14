SMODS.Joker {
	key = 'eye_of_providence',
	loc_txt = {
		name = 'Eye of Providence',
		text = {
            "If there is exactly {C:attention}1{}",
            "scoring {C:gb_eyes}Eye{} in played hand,",
            "{C:green}#1# in #2#{} chance to {C:attention}destroy{} it",
            "and earn {C:money}$#3#{}"
		}
	},
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 6 },
	cost = 6,
	blueprint_compat = true,
    config = { extra = { dollars = 10, odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1, card.ability.extra.odds)
    	return { vars = { new_numerator, new_denominator, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card 
        and context.cardarea == G.play 
        and context.destroy_card:is_suit("gb_Eyes")
        and SMODS.pseudorandom_probability(card, 'gb_eye_of_providence', 1, card.ability.extra.odds) then
            local eye_tally = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_suit("gb_Eyes") then
                    eye_tally = eye_tally + 1
                end
            end
            if eye_tally == 1 then
                return {
                    remove = true,
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end,

    in_pool = function(self, args)
        return gb_is_suit_in_deck(suit_key)
    end
}
