
SMODS.Joker {
	key = 'joker_boy',
	loc_txt = {
		name = 'Joker Boy',
		text = {
            "Rounds {C:chips}Chips{} and {C:mult}Mult{} to",
            "the next power of {C:attention}#1#{}",
		}
	},
	config = { extra = { power = 2 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 7, y = 6 },
	cost = 8,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.power } }
	end,
    calculate = function(self, card, context)
        local ln2_inverse = 1 / math.log(2)
	    if context.joker_main then
            hand_chips = 2 ^ math.ceil(math.log(hand_chips) * ln2_inverse)
            mult = 2 ^ math.ceil(math.log(mult) * ln2_inverse)
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            return {
                message = "Retro!",
                colour = G.C.FILTER
            }
        end
    end
}