SMODS.Joker {
	key = 'postage_stamp',
	loc_txt = {
		name = 'Postage Stamp',
		text = {
            "This Joker gains {C:chips}+#2#{} Chips",
            "if played hand has",
            "exactly {C:attention}1{} card",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
		}
	},
	config = { extra = { chips = 0, chip_mod = 6 } },
    pixel_size = { w = 45, h = 57 },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 1 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and #context.full_hand == 1 then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}