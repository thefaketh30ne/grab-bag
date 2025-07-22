SMODS.Joker{
    key = "the_bends",
    loc_txt = {
        name = 'The Bends',
		text = {
            "This Joker gains {C:mult}+#2#{} Mult",
            "if played hand contains a {C:attention}Straight",
            "{C:attention}Resets{} if played hand",
            "is a {C:attention}High Card",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
		}
    },
    config = { extra = { mult = 0, mult_mod = 4 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 7, y = 5 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            if context.scoring_name == "High Card" and card.ability.extra.mult > 0 then
                card.ability.extra.mult = 0
                return {
                    message = localize("k_reset"),
                    colour = G.C.FILTER
                }
            end
            if next(context.poker_hands["Straight"]) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                }
            end
        end
    end
}