SMODS.Joker {
    key = 'doner',
    loc_txt = {
        name = 'Doner',
        text = {
            "This Joker gains {C:chips}+#1#{} Chips",
            "after hand scored",
            "{C:chips}-#2#{} chips when {C:attention}Blind{} is selected",
            "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
        }
    },
    config = { extra = { chips = 0, chips_gain = 10, chips_loss = 20 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 5 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_gain, card.ability.extra.chips_loss, card.ability.extra.chips } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
            }
        end
        if context.after and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS
            }
        end
        if context.setting_blind and not context.blueprint then
            if card.ability.extra.chips > 0 then
                card.ability.extra.chips = math.max(0, card.ability.extra.chips - card.ability.extra.chips_loss)
                return {
                    message = "Carved!",
                    colour = G.C.CHIPS
                }
            end
        end
    end
}