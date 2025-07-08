SMODS.Joker{
    key = "ox",
    loc_txt = {
		name = 'The Ox',
		text = {
			"Earn {C:money}$#1#{} at end of round",
			"{C:red}Lose $#2#{} if played hand is",
            "your {C:attention}most played poker hand{}",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 1, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { money = 10, dollars_loss = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.dollars_loss } }
    end,

    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local lower = false
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                    lower = true
                    break
                end
            end
            if not lower then
                return {
                    dollars = -dollars_loss
                }
            end
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_ox")
    end
}