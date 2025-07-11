SMODS.Joker{
    key = "shame",
    loc_txt = {
		name = 'The Shame',
		text = {
            "If both {C:attention}Small{} and {C:attention}Big Blind{} are skipped,",
            "{C:attention}-1 Ante{} upon defeating {C:attention}Boss Blind{}",
            "{C:inactive,s:0.85}(Only works once every {C:attention,s:0.85}Ante{C:inactive,s:0.85} number)"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 1, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { antes_rewinded = {} } },

    calculate = function(self, card, context)
        if context.end_of_round
        and context.main_eval
        and G.GAME.GB_BLINDS_SKIPPED_THIS_ANTE
        and G.GAME.blind.boss
        and context.game_over == false
        and not card.ability.extra.antes_rewinded[G.GAME.round_resets.ante] then
            if G.GAME.GB_BLINDS_SKIPPED_THIS_ANTE >= 2  then
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
