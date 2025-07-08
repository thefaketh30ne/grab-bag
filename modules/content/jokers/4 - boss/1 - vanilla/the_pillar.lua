SMODS.Joker{
    key = "pillar",
    loc_txt = {
		name = 'The Pillar',
		text = {
            "Played cards previously",
            "played this {C:attention}Ante permanently{}",
            "gain {C:chips}+#1#{} Chips when scored"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 6, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { chips = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual
        and context.main_eval
        and context.cardarea == G.play
        and context.other_card.played_this_ante == true then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card,
                colour = G.C.CHIPS
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_pillar")
    end
}