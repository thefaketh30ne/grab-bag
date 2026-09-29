SMODS.Joker {
    key = "crumbling_castle",
    loc_txt = {
		name = 'Crumbling Castle',
		text = {
			"Discarded {V:1}#2#{} are destroyed",
            "and this Joker gains {C:chips}+#1#{} Chips",
            "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 2, y = 1 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { chips = 0, chips_mod = 20 } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.castle_card or {}).suit or 'Spades'
        return { vars = { card.ability.extra.chips_mod, localize(suit, 'suits_plural'), card.ability.extra.chips, colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and not context.other_card.debuff and
        context.other_card:is_suit(G.GAME.current_round.castle_card.suit) then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
            SMODS.destroy_cards(context.other_card)
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
