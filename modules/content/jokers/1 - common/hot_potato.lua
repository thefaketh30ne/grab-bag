SMODS.Joker {
	key = 'hot_potato',
	loc_txt = {
		name = 'Hot Potato',
		text = {
			"When {C:attention}Blind{} is skipped,",
			"this Joker gains {C:mult}+#2#{} Mult",
			"{C:green}#3# in #4# chance{} to {C:red}self-destruct{}",
			"at end of round",
			"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
		}
	},
	config = { extra = { mult = 0, mult_mod = 12, odds = 8 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 7, y = 2 },
	cost = 4,
	blueprint_compat = true,
    eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if pseudorandom('gb_hot_potato') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Cooked!'
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.skip_blind and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } }
			}          
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
			}
        end
	end
}