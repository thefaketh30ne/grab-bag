SMODS.Joker {
    key = 'doner',
    loc_txt = {
        name = 'Doner',
        text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "after hand scored",
            "{C:mult}-#2#{} Mult when {C:attention}Blind{} is selected",
            "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)"
        }
    },
    config = { extra = { mult = 0, mult_gain = 2, mult_loss = 4 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 5 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult_loss, card.ability.extra.mult } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
            }
        end
        if context.after and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
        if context.setting_blind and not context.blueprint then
            if card.ability.extra.mult > 0 then
                card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.mult_loss)
                return {
                    message = "Carved!",
                    colour = G.C.MULT
                }
            end
        end
    end
}