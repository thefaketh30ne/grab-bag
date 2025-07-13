SMODS.Joker{
    key = "shame",
    loc_txt = {
		name = 'The Shame',
		text = {
            "{C:green}#3# in #2# chance{} for {C:attention}-1 Ante{}",
            "upon defeating {C:attention}Boss Blind{}",
            "{C:green}Probability{} increases by {C:green}#1#{} for",
            "every {C:attention}Blind{} skipped this {C:attention}Ante",
            "{C:inactive,s:0.85}(Only works once per {C:attention,s:0.85}Ante{C:inactive,s:0.85})"
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 1, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, self.config.extra.odds)
        return { vars = { new_numerator, new_denominator, (G.GAME.GB_BLINDS_SKIPPED_THIS_ANTE or 0) * new_numerator } }
    end,
    config = { extra = { antes_rewinded = {}, odds = 3 } },

    calculate = function(self, card, context)
        if context.end_of_round
        and context.main_eval
        and G.GAME.GB_BLINDS_SKIPPED_THIS_ANTE
        and context.beat_boss
        and not context.blueprint
        and context.game_over == false
        and not card.ability.extra.antes_rewinded[G.GAME.round_resets.ante] then
            if SMODS.pseudorandom_probability(card, 'gb_shame', G.GAME.GB_BLINDS_SKIPPED_THIS_ANTE, card.ability.extra.odds) then
                card.ability.extra.antes_rewinded[G.GAME.round_resets.ante] = true
                ease_ante(-1)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
            end
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_shame")
    end
}
