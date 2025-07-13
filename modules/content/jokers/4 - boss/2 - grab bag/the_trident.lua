SMODS.Joker{
    key = "trident",
    loc_txt = {
		name = 'The Trident',
		text = {
            "If all played cards score,",
            "this Joker gains {C:mult}+#1#{} Mult",
            "for every card played",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 3, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { mult = 0, mult_mod = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.mult_mod,
            card.ability.extra.mult
        } }
    end,
    calculate = function(self, card, context)
        if context.before
        and context.main_eval
        and #context.scoring_hand == #context.full_hand
        and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod * #context.scoring_hand
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_trident")
    end
}