SMODS.Joker{
    key = "hand",
    loc_txt = {
		name = 'The Hand',
		text = {
			"{C:attention}Debuffs leftmost{} card",
            "in scoring hand, {C:attention}rightmost{} card",
            "gives {X:mult,C:white}X#1#{} Mult when scored"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 7, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult = 2.5 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
    calculate = function(self, card, context)
        if context.before and context.scoring_hand[1] and not context.blueprint then
            SMODS.debuff_card(context.scoring_hand[1], true, "gb_final_pentacle")
        end
        local index = nil
        if context.individual and context.cardarea == G.play then
            for k, search_card in ipairs(context.scoring_hand) do
                if context.other_card == search_card then
                    index = k
                    break
                end
            end
            if index and index == #context.scoring_hand then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_hand")
    end
}