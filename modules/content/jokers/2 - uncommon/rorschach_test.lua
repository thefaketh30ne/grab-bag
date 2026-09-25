SMODS.Joker {
	key = 'rorschach_test',
	loc_txt = {
		name = 'Rorshach Test',
		text = {
            "Playing cards with",
            "a {V:1}Hex {C:attention}retrigger once",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 10 },
	cost = 8,
	blueprint_compat = true,
    config = { extra = { retriggers = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, colours = { HEX("807ead") } } }
    end,
    calculate = function(self, card, context)
        if context.repetition and
        GB.get_hex(context.other_card) then
            return {
                repetitions = card.ability.extra.retriggers
            }
        end
    end,
    in_pool = function(self, args)
        return gb_get_number_of_hexes(G.playing_cards) > 1
    end
}
