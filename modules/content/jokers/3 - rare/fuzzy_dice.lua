SMODS.Joker {
	key = 'fuzzy_dice',
	loc_txt = {
		name = 'Fuzzy Dice',
		text = {
            "Scored cards gain",
            "{C:chips}+#1#{} Chips {C:attention}permanently{}",
            "Increases by {C:chips}+#2#{} when",
            "shop is {C:attention}rerolled"
		}
	},
	rarity = 3,
	atlas = 'Jokers',
    config = { extra = { chips = 2, chips_mod = 2 } },
	pos = { x = 9, y = 7 },
	cost = 8,
	blueprint_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod } }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
        end
        if context.individual
        and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card,
                colour = G.C.CHIPS
            }
        end
    end,
}