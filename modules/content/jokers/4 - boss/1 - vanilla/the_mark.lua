SMODS.Joker{
    key = "mark",
    loc_txt = {
		name = 'The Mark',
		text = {
			"All {C:attention}face{} cards are",
            "drawn {C:attention}face-down{}",
            "and give {X:mult,C:white}X#1#{} Mult when scored"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 2, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.xmult
        } }
    end,

    calculate = function(self, card, context)
        if context.stay_flipped and context.other_card:is_face() then
            return {
                stay_flipped = true
            }
        end
        if context.individual and context.other_card:is_face() and context.cardarea == G.play then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_mark")
    end
}




