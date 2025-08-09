SMODS.Joker{
    key = "hell_trees",
    loc_txt = {
        name = 'Hell Trees',
		text = {
            "Create an {V:1}Ephemeral{} card",
            "when a hand is drawn",
            "with {C:attention}no hands remaining{}"
		}
    },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 6, y = 2 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { HEX("8EA4B3") }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and G.GAME.current_round.hands_left == 1 then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Ephemeral',
                                key_append = 'gb_hell_trees'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ 
                        message = "+1 Ephemeral",
                        colour = HEX("8EA4B3")
                    },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end
}