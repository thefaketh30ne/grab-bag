SMODS.Joker{
    key = "hook",
    loc_txt = {
		name = 'The Hook',
		text = {
			"When a {C:blue}Hand{} is played,",
			"{C:attention}#1#{} random card {C:attention}permanently",
            "gains {C:mult}+#2#{} Mult and is {C:attention}discarded",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 4, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { mult = 10, cards_discarded = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards_discarded, card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.press_play and #G.hand.cards - #G.hand.highlighted > 0 then
            local selected_card = nil
            G.E_MANAGER:add_event(Event({
                func = function()
                    selected_card = pseudorandom_element(G.hand.cards, pseudoseed('gb_hook'))
                    G.hand:add_to_highlighted(selected_card, true)
                    play_sound('card1', 1)
                    selected_card.ability.perma_mult = (selected_card.ability.perma_mult or 0) + card.ability.extra.mult
                    SMODS.calculate_effect( {
                        message = localize('k_upgrade_ex'),
                        message_card = selected_card,
                        colour = G.C.MULT
                    }, card)
                    G.FUNCS.discard_cards_from_highlighted(nil, true)
                    return true
                end
            }))
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_hook")
    end
}