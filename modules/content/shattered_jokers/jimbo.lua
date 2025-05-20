SMODS.Joker {
	key = 'jimbo',
	loc_txt = {
		name = 'Jimbo',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		}
	},
	config = { extra = { xmult = 4 } },
	blueprint_compat = true,
	atlas = 'ShatteredJokers',
	pos = { x = 7, y = 0 },
    soul_pos = { x = 7, y = 2 },
    rarity = "gb_shattered",
    cost = 10,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}