SMODS.Joker {
    key = 'mystery_man',
	loc_txt = {
		name = 'Mystery Man',
		text = {
			"If played hand contains {C:attention}#1#{} {C:attention}6{}s,",
            "{C:attention}6{}s gain {C:mult}+#2#{} Mult when scored and",
            "all cards held in hand",
            "are {C:attention}destroyed{} after scoring"
            
		}
	},
    config = { extra = { threshold = 3, mult = 6, active = false } },
    rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 3 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.threshold, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            local sixes = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 6 then
                    sixes = sixes + 1
                end
            end
            card.ability.extra.active = ((sixes >= card.ability.extra.threshold) and true or false)

        end
        if context.individual
        and context.cardarea == G.play
        and card.ability.extra.active == true
        and context.other_card:get_id() == 6 then
            context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card,
                colour = G.C.MULT
            }
        end
        if context.destroy_card
        and context.cardarea == G.hand
        and card.ability.extra.active == true
        and not context.blueprint then
            return {
                remove = true
            }
        end
    end
}