
SMODS.Joker {
	key = 'isometric_joker',
	loc_txt = {
		name = 'Isometric Joker',
		text = {
            {"Can play {C:attention}1{} extra card"},
            {"This Joker gains {C:chips}+#1#{} Chips",
            "if {C:attention}6{} cards are played at once",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"}
		}
	},
	config = { extra = { chips = 0, chips_mod = 6 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 8, y = 3 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
		if context.before and #context.full_hand >= 6 and not context.blueprint then
			SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                message_colour = G.C.CHIPS
            })
        end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-1)
    end
}