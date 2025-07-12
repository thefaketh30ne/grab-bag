SMODS.Joker{
    key = "lance",
    loc_txt = {
		name = 'The Lance',
		text = {
            "Cards discarded this {C:attention}Ante{}",
            "are drawn {C:attention}face-down{} and",
            "give {X:mult,C:white}X#1#{} Mult when scored"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 7, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    config = { extra = { xmult = 1.75 } },

    calculate = function(self, card, context)
        if context.stay_flipped and context.to_area == G.hand and
            context.other_card.ability.discarded_this_ante then
            return {
                stay_flipped = true
            }
        end
        if context.individual
        and context.cardarea == G.play
        and context.other_card.ability.discarded_this_ante then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_lance")
    end
}