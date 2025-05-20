SMODS.Joker {
    key = "ornate_vase",
    loc_txt = {
		name = 'Ornate Vase',
		text = {
			"This Joker gains {X:mult,C:white}X#1#{} Mult if",
			"played hand contains scoring cards",
            "of {C:attention}3 or more{} different suits",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
    blueprint_compat = true,
	atlas = 'ShatteredJokers',
	pos = { x = 1, y = 0 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { xmult_mod = 0.25, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local scored_suits = {}
            for _, c in ipairs(context.scoring_hand) do
                if c.base.suit and not scored_suits[c.base.suit] then scored_suits[c.base.suit] = true end
            end

            local suitamt = 0
            for _, _ in pairs(scored_suits) do
                suitamt = suitamt + 1
            end

            if suitamt >= 3 then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}