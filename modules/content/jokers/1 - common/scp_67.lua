SMODS.Joker {
	key = 'scp_67',
	loc_txt = {
		name = 'SCP-67',
		text = {
            "Rounds {C:chips}Chips{} to the",
            "next number ending in {C:attention}67{}",
		}
	},
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 6, y = 7 },
	cost = 6,
	blueprint_compat = true,
    calculate = function(self, card, context)   
	    if context.joker_main then
            local new_chips = math.ceil((hand_chips - 67) * 0.01) * 100 + 67
            return {
                message = "67!",
                chip_mod = new_chips - hand_chips,
                colour = G.C.CHIPS
            }
        end
    end
}
