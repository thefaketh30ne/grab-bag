SMODS.Joker {
    key = 'mystery_man',
	loc_txt = {
		name = 'Mystery Man',
		text = {
            "Played {C:attention}6{}s permanently",
            "gain {C:mult}+#1#{} Mult if scoring",
            
		}
	},
    config = { extra = { mult = 6} },
    rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 3 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for _, v in ipairs(context.scoring_hand) do
                if v:get_id() == 6 then
                    v.ability.perma_mult = (v.ability.perma_mult or 0) + card.ability.extra.mult
                    SMODS.calculate_effect({message = localize('k_upgrade_ex'), colour = G.C.MULT}, v)
                end
            end
        end
    end
}
