SMODS.Joker {
	key = 'fudge',
	loc_txt = {
		name = 'Fudge',
		text = {
            "Rounds {C:chips}Chips{} up to {C:attention}#1#",
            "{C:chips}-#2# Chips{} after hand played",
		}
	},
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 1, y = 10 },
	cost = 5,
	blueprint_compat = true,
    config = { extra = { chips = 200, chips_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod } }
	end,
    calculate = function(self, card, context)
	    if context.joker_main then
            local new_chips = card.ability.extra.chips
            if hand_chips < new_chips then
                return {
                    message = "Fudged!",
                    chip_mod = new_chips - hand_chips,
                    colour = G.C.CHIPS
                }
            end
        end
        if context.after and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chips_mod",
                operation = "-",
                no_message = true
            })
            if card.ability.extra.chips <= 0 then
                SMODS.destroy_cards(card, {
                    pinch_anim = true
                })
                return {
                    message = "Eaten!"
                }
            end
        end
    end
}