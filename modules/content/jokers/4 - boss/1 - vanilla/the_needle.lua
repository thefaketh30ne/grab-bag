SMODS.Joker{
    key = "needle",
    loc_txt = {
		name = 'The Needle',
		text = {
			"{X:mult,C:white}X#1#{} on first hand of round",
			"{C:blue}#2#{} hand per round",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 0, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult = 3, hands = -1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.hands } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
           ease_hands_played(card.ability.extra.hands)
        end
        if context.joker_main
        and context.main_eval
        and G.GAME.current_round.hands_played == 0 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_needle")
    end
}