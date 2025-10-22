SMODS.Joker {
	key = 'Cuppa',
	loc_txt = {
		name = 'Cuppa',
		text = {
			"The last scoring card",
            "retriggers {C:attention}#1#{} times",
            "{C:attention}-#2#{} retrigger when",
            "{C:attention}Boss Blind{} is defeated",
		}
	},
	config = { extra = { repetitions = 3, repetitions_mod = 1 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 8 },
	cost = 4,
	blueprint_compat = true,
    eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, card.ability.extra.repetitions_mod } }
	end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
			if context.other_card == context.scoring_hand[#context.scoring_hand] then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
        if context.end_of_round
        and context.game_over == false
        and context.main_eval
        and context.beat_boss
        and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "repetitions",
                scalar_value = "repetitions_mod",
                operation = "-",
                no_message = true
            })
            if card.ability.extra.repetitions <= 0 then
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
                    message = 'Drank!',
                    colour = G.C.FILTER
                }
            else     
                return {
                    message = 'Downgraded!',
                    colour = G.C.FILTER
                }
            end
        end
    end
}