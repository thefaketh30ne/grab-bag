SMODS.Joker{
    key = "creepy_painting",
    loc_txt = {
        name = 'Creepy Painting',
		text = {
            "{X:mult,C:white}X#1#{} Mult",
            "When {C:attention}Blind{} is selected, {C:green}#2# in #3# chance{}",
            "to {C:attention}destroy{} a random Joker",
            "and create a {C:spectral}Spectral{} card",
            "{C:inactive}(Must have room)"
		}
    },
    config = { extra = { xmult = 2, odds = 2 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 5 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { card.ability.extra.xmult, new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.setting_blind 
            and not context.blueprint 
            and SMODS.pseudorandom_probability(card, 'gb_creepy_painting', 1, card.ability.extra.odds) then
            local valid_targets = {}
            for _, joker in pairs(G.jokers.cards) do
                if joker ~= card
                    and not joker.ability.eternal
                    and not joker.getting_sliced then
                    valid_targets[#valid_targets + 1] = joker
                end
            end
            local joker_to_destroy = pseudorandom_element(valid_targets, pseudoseed('gb_creepy_painting'))
            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'gb_creepy_painting'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                        remove = true
                    }
                end
            end
            return {}
        end
    end
}