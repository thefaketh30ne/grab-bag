SMODS.Joker{
    key = "tooth",
    loc_txt = {
		name = 'The Tooth',
		text = {
			"Earn {C:money}$#1#{} for every card played",
            "Lose {C:red}$#2#{} at end of round"
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 1, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { money = 6, dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.dollars,
            card.ability.extra.money
        } }
    end,

    calc_dollar_bonus = function(self, card)
        return -card.ability.extra.money
    end,

    calculate = function(self, card, context)
        if context.press_play and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    for i = 1, #G.play.cards do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.play.cards[i]:juice_up()
                                return true
                            end,
                        }))
                        ease_dollars(card.ability.extra.dollars)
                        delay(0.23)
                    end
                    return true
                end
            }))
            delay(0.4)
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_tooth")
    end
}