SMODS.Joker{
    key = "house",
    loc_txt = {
		name = 'The House',
		text = {
			"Cards in first hand",
            "are drawn {C:attention}face-down{} and",
            "{C:attention}permanently{} gain {C:mult}+#1#{} Mult",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 5, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { mult = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.stay_flipped 
        and context.to_area == G.hand 
        and G.GAME.current_round.hands_played == 0 
        and G.GAME.current_round.discards_used == 0 then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                stay_flipped = true
            }
        end
        if context.first_hand_drawn then
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_house")
    end
}