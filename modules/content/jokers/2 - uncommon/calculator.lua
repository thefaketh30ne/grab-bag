SMODS.Joker {
	key = 'calculator',
	loc_txt = {
		name = 'Calculator',
		text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "if round is beaten with",
            "exactly {C:attention}#4#{} played cards",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
            "{C:inactive}({C:attention}#3#/#4#{C:inactive})"
		}
	},
	config = { extra = {
        mult = 0,
        mult_mod = 10,
        scored_cards = 0,
        cards_to_score = 10,
    } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 6, y = 1 },
	cost = 6,
	blueprint_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.mult_mod,
            card.ability.extra.mult,
            card.ability.extra.scored_cards,
            card.ability.extra.cards_to_score
        } }
	end,
	calculate = function(self, card, context)
        if context.before 
        and context.main_eval 
        and not context.blueprint 
        and card.ability.extra.scored_cards <= card.ability.extra.cards_to_score then
            card.ability.extra.scored_cards = card.ability.extra.scored_cards + #context.full_hand
            if card.ability.extra.scored_cards <= card.ability.extra.cards_to_score then
                return {
                    message = card.ability.extra.scored_cards .. "/" .. card.ability.extra.cards_to_score,
                    colour = G.C.FILTER
                }
            else
                return {
                    message = "Bust!",
                    colour - G.C.FILTER
                }
            end
        end
        if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
        if context.end_of_round 
        and context.game_over == false 
        and context.main_eval 
        and not context.blueprint then
            if card.ability.extra.scored_cards == card.ability.extra.cards_to_score then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    message_colour = G.C.MULT
                })
            end
            card.ability.extra.scored_cards = 0
        end
	end
}