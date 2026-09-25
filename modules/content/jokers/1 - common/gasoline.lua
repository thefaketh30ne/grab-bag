SMODS.Joker {
	key = 'gasoline',
	loc_txt = {
		name = 'Gasoline',
		text = {
			"Earn {C:money}$#1#{} at end of round,",
			"{C:red}self-destruct{} if",
			"score {C:attention}catches fire{}",
		}
	},
	config = { extra = { dollars = 8 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 2 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
	calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
    calculate = function(self, card, context)
        if context.after and SMODS.last_hand_oneshot then
			SMODS.destroy_cards(card, {
				pinch_anim = true
			})
			return {
				message = "Exploded!"
			}
		end
	end
}