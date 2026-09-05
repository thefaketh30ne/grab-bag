SMODS.Joker {
	key = 'fire_exit',
	loc_txt = {
		name = 'Fire Exit',
		text = {
            "{C:green}#1# in #2# chance{} chance to",
            "create a random {C:attention}Tag",
            "when score {C:attention}catches fire"
		}
	},
	config = { extra = { odds = 2 } },
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 5 },
	cost = 8,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
        if context.end_of_round
        and context.main_eval
        and SMODS.last_hand_oneshot
        and SMODS.pseudorandom_probability(card, 'gb_fire_exit', 1, card.ability.extra.odds)
        and not context.blueprint then
            local tag_pool = get_current_pool('Tag')
            local selected_tag = pseudorandom_element(tag_pool, pseudoseed('gb_fire_exit'))
            local it = 1
            while selected_tag == 'UNAVAILABLE' do
                it = it + 1
                selected_tag = pseudorandom_element(tag_pool, pseudoseed('gb_fire_exit' .. it))
            end
            add_tag(Tag(selected_tag, false, 'Small'))
            card:juice_up()
            return {
                message = "Tag Created!",
                colour = G.C.FILTER
            }
        end
    end
}