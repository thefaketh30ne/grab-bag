SMODS.Joker{
    key = "creepy_painting",
    loc_txt = {
        name = 'Creepy Painting',
		text = {
            "After {C:attention}#1#{} playing cards",
            "are destroyed, create",
            "a random {V:1}Hex{} card",
            "{C:inactive}(Must have room, {C:attention}#2#{C:inactive}/#1#)"

		}
    },
    config = { extra = { counter = 0, threshold = 3 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 5 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.threshold,
            card.ability.extra.counter,
            colours = { HEX("807ead") }
        } }
	end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for _, _ in pairs(context.removed) do
                card.ability.extra.counter = card.ability.extra.counter + 1
                if card.ability.extra.counter == card.ability.extra.threshold then
                    card.ability.extra.counter = 0
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            SMODS.add_card {
                                                set = 'Hex',
                                                key_append = 'gb_hell_trees'
                                            }
                                            G.GAME.consumeable_buffer = 0
                                            return true
                                        end
                                    }))
                                    SMODS.calculate_effect({
                                        message = "+1 Hex",
                                        colour = HEX("807ead")
                                    },
                                    context.blueprint_card or card)
                                    return true
                                end)
                            }))
                        return nil, true
                    end
                end
            end
        end
    end
}