SMODS.Joker {
	key = 'retro_joker',
	loc_txt = {
		name = 'Retro Joker',
		text = {
            "Scored {C:attention}2{}s, {C:attention}4{}s and {C:attention}8{}s",
            "give {X:mult,C:white}#1#X{} Mult",
		}
	},
	config = { extra = { xmult = 1.6 } },
	rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 3 },
    pixel_size = { w = 62, h = 94 },
	cost = 8,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (
                context.other_card:get_id() == 2
                or context.other_card:get_id() == 4
                or context.other_card:get_id() == 8
            ) then
            return {
                xmult = card.ability.extra.xmult
			}
        end
    end,
}