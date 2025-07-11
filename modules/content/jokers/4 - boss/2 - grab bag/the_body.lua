SMODS.Joker{
    key = "body",
    loc_txt = {
		name = 'The Body',
		text = {
			"{X:mult,C:white}X#1#{} Mult for every {C:attention}Enhanced{} card",
            "in full deck below {C:attention}#3#{}",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",

		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 8, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult_mod = 0.5, threshold = 12 } },
    loc_vars = function(self, info_queue, card)
        local enhanced_tally = 0
        if G.playing_cards then
            for _, playing_card in pairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(playing_card)) then
                    enhanced_tally = enhanced_tally + 1
                end
            end
        end
		return { vars = { 
            card.ability.extra.xmult_mod,
            1 + (math.max(0, card.ability.extra.threshold - enhanced_tally) * card.ability.extra.xmult_mod),
            card.ability.extra.threshold
        } }
	end,
    calculate = function(self, card, context)
        if context.joker_main and context.main_eval then
            local enhanced_tally = 0
            for _, playing_card in pairs(G.playing_cards or {}) do
                if next(SMODS.get_enhancements(playing_card)) then
                    enhanced_tally = enhanced_tally + 1
                end
            end
            if enhanced_tally < card.ability.extra.threshold then
                return {
                    xmult = 1 + (math.max(0, card.ability.extra.threshold - enhanced_tally) * card.ability.extra.xmult_mod)
                }
            end    
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_body")
    end
}