SMODS.Joker{
    key = "dread",
    loc_txt = {
		name = 'The Dread',
		text = {
            "{X:mult,C:white}X#1#{} Mult if scoring hand",
            "contains {C:attention}exactly #2#{} suits",

		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 5, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.suits } }
    end,
    config = { extra = { xmult = 3, suits = 2 } },

    calculate = function(self, card, context)
        if gb_count_suits(context.scoring_hand) == card.ability.extra.suits then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_dread")
    end
}




