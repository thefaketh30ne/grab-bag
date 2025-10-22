SMODS.Joker {
    key = 'd20',
    loc_txt = {
        name = 'D20',
        text = {
            "Whenever a card is drawn,",
            "{C:green}#1# in #2#{} chance to",
            "add a random {C:attention}Seal{}",
            "{C:green}#1# in #2#{} chance to",
            "temporarily debuff it",
        }
    },
    config = { extra = { odds = 20 } },
    rarity = 3,
    cost = 8,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 4 },
    blueprint_compat = true,
    soul_pos = { x = 8, y = 4 },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn or context.other_drawn then
		    for _, playing_card in ipairs(context.hand_drawn or context.other_drawn) do
			    if SMODS.pseudorandom_probability(
                    card, 
                    'gb_d20_success',
                    G.GAME.probabilities.normal,
                    card.ability.extra.odds
                ) then
                    playing_card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'gb_d20' }))
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_effect({ message = "Critical Success!", colour = G.C.GREEN, message_card = card })
                            return true
                        end
                    }))
                elseif SMODS.pseudorandom_probability(
                    card,
                    'gb_d20_failure',
                    G.GAME.probabilities.normal,
                    card.ability.extra.odds - G.GAME.probabilities.normal
                ) then
                    SMODS.debuff_card(playing_card, true, "gb_d20")
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_effect({ message = "Critical Failure!", colour = G.C.RED, message_card = card })
                            return true
                        end
                    }))
                end
		    end
        end
        if context.end_of_round and context.main_eval then
            for _, playing_card in ipairs(G.playing_cards) do
                SMODS.debuff_card(playing_card, "reset", "gb_d20")
            end
        end
    end
}