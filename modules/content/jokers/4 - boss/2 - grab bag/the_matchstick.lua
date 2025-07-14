SMODS.Joker{
    key = "matchstick",
    loc_txt = {
		name = 'The Matchstick',
		text = {
            "When a {C:attention}Blind{} is selected,",
            "{C:attention}double{} either {C:blue}Hands{} or {C:red}Discards",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 6, y = 3 },
    rarity = "gb_boss",
    cost = 6,

    calculate = function(self, card, context)
        if context.setting_blind then
            if pseudorandom("gb_matchstick") > 0.5 then
                ease_hands_played(G.GAME.current_round.hands_left)
            else
                ease_discard(G.GAME.current_round.discards_left)
            end
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_matchstick")
    end
}

