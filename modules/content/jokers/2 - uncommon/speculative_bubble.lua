SMODS.Joker{
    key = "speculative_bubble",
    loc_txt = {
        name = 'Speculative Bubble',
		text = {
            "{C:green}#1# in #2# chance{} to set money to {C:money}$0",
            "when sold or destroyed",
            "Scored cards earn {C:money}$#3#",
            "and increase this {C:green}probability{} by {C:attention}#4#",
            "{C:inactive,s:0.85}(Self destructs at {C:green,s:0.85}#2# in #2# chance{C:inactive,s:0.85})"
		}
    },
    config = { extra = {
        base_numerator = 0,
        numerator_increase = 1,
        odds = 100,
        money = 1,
        popped = false
    } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 8, y = 0 },
	cost = 7,
	blueprint_compat = false,
        loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.base_numerator, card.ability.extra.odds)
        return {
            vars = {
                new_numerator,
                new_denominator,
                card.ability.extra.money,
                card.ability.extra.numerator_increase
            },
        }
    end,
    calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.play
        and not context.blueprint
        and not card.ability.extra.popped == true then
            if card.ability.extra.base_numerator < 100 then
                card.ability.extra.base_numerator = card.ability.extra.base_numerator + card.ability.extra.numerator_increase
                return {
                    dollars = card.ability.extra.money,
                    message_card = context.other_card
                }
            else
                card.ability.extra.popped = true
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
                    message = 'Popped!',
                    colour = G.C.FILTER,
                    message_card = card
                }
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff and SMODS.pseudorandom_probability(card, 'gb_speculative_bubble', card.ability.extra.base_numerator, card.ability.extra.odds) then
            ease_dollars(-G.GAME.dollars, true)
        end
    end
}