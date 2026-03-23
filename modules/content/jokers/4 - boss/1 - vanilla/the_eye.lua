SMODS.Joker{
    key = "eye",
    loc_txt = {
		name = 'The Eye',
		text = {
			"This Joker gains {X:mult,C:white}X#1#{} Mult for",
            "every {C:attention}consecutive poker hand{}",
            "that has not already been",
            "played this round",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 3, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult = 1, xmult_mod = 0.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before
        and context.main_eval
        and not context.blueprint
        and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1 then
            card.ability.extra.xmult = 1
            return {
                message = localize("k_reset"),
                colour = G.C.FILTER
            }
        end

        if context.joker_main and context.main_eval and not G.GAME.hands[context.scoring_name].played_this_round > 1 then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_colour = G.C.MULT
            })
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_eye")
    end
}