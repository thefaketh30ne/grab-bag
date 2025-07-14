SMODS.Joker{
    key = "arm",
    loc_txt = {
		name = 'The Arm',
		text = {
			"Played poker hands either",
            "lose {C:attention}#1#{} level or gain {C:attention}#2#{} levels"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 7, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { level_loss = 1, level_gain = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.level_loss,
            card.ability.extra.level_gain
        } }
    end,

    calculate = function(self, card, context)
        if context.before
        and context.main_eval then
            local level_choice = pseudorandom_element( { -card.ability.extra.level_loss, card.ability.extra.level_gain }, pseudoseed("gb_arm") )
            if not (G.GAME.hands[context.scoring_name].level <= 1 and level_choice < 0) then
                return {
                    level_up = level_choice
                }
            end
        end  
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_arm")
    end
}