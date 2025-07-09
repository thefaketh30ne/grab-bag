SMODS.Joker{
    key = "flint",
    loc_txt = {
		name = 'The Flint',
		text = {
			"Doubles {C:blue}Chips{} and {C:red}Mult{}",
            "before scoring",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 4, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    calculate = function(self, card, context)
        if context.modify_hand then
            mult = mult * 2
            hand_chips = hand_chips * 2
            update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_flint")
    end
}