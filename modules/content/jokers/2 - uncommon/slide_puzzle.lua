
SMODS.Joker {
	key = 'slide_puzzle',
	loc_txt = {
		name = 'Slide Puzzle',
		text = {
			"A {C:attention}random{} played card",
            "gives {X:mult,C:white}X#1#{} Mult when scored",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
    config = { extra = { x_mult = 3 } },
    pixel_size = { h = 71 },
	pos = { x = 8, y = 9 },
	cost = 7,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.before then
            pseudorandom_element(context.scoring_hand, pseudoseed("gb_slide_puzzle")).ability.slide_x_mult = true
        end
        if context.individual and context.other_card.ability.slide_x_mult == true then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
        if context.after then
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card.ability.slide_x_mult then
                    playing_card.ability.slide_x_mult = nil
                end
            end
        end
    end
}