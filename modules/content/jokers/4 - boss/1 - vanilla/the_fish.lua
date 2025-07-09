SMODS.Joker{
    key = "fish",
    loc_txt = {
		name = 'The Fish',
		text = {
			"Cards drawn after",
            "a hand is played",
            "{C:attention}permanently{} gain {C:chips}+#1#{} Chips",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 8, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { chips = 10, prepped = nil, upgraded = nil } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.chips
        } }
    end,

    calculate = function(self, card, context)
        if context.press_play then
            card.ability.extra.prepped = true
        end
        if context.stay_flipped and context.to_area == G.hand and card.ability.extra.prepped then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
            card.ability.extra.upgraded = true
        end
        if context.setting_blind or context.hand_drawn then
            card.ability.extra.prepped = nil
            if card.ability.extra.upgraded then
                card.ability.extra.upgraded = nil
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.CHIPS,
                }
            end
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_fish")
    end
}