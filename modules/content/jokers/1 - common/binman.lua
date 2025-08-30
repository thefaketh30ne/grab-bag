SMODS.Joker {
    key = 'binman',
    loc_txt = {
        name = 'Binman',
        text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "when {C:attention}#3#{} cards are",
            "discarded at once",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
        }
    },
    config = { extra = { threshold = 5, mult = 0, mult_mod = 1 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 0, y = 5 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.mult_mod,
            card.ability.extra.mult,
            card.ability.extra.threshold
        } }
	end,
    calculate = function(self, card, context)
        if context.pre_discard and not context.blueprint then
            if #G.hand.highlighted >= card.ability.extra.threshold then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_mod"
                })
            end
		end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}