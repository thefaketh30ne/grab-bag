SMODS.Joker {
	key = 'mugshot',
	loc_txt = {
		name = 'Mugshot',
		text = {
            "{C:attention}Face{} cards give {C:mult}Mult{} equal to",
            "the rank of a random",
            "scoring {C:attention}numbered{} card"
		}
	},
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 6, y = 6 },
	cost = 4,
	blueprint_compat = true,
	calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.play
        and context.other_card:is_face()
        and not context.end_of_round then
            local numbered_cards = {}
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() >= 2
                and playing_card:get_id() <= 10 then
                    table.insert(numbered_cards, playing_card)
                end
            end
            if #numbered_cards > 0 then
                local selected_card = pseudorandom_element(numbered_cards, pseudoseed("gb_mugshot"))
                return {
                    mult = selected_card.base.nominal
                }
            end
        end
    end
}