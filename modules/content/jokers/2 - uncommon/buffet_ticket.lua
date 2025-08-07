SMODS.Joker {
	key = 'buffet_ticket',
	loc_txt = {
		name = 'Buffet Ticket',
		text = {
            "Upon defeating a {C:attention}Boss Blind{},",
            "create a {C:attention}Coupon Tag",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 3, y = 4 },
    pixel_size = { w = 63 },
	cost = 8,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_coupon', set = 'Tag' }
    end,
    calculate = function(self, card, context)
        if context.end_of_round
        and context.game_over == false
        and context.main_eval
        and not context.blueprint
        and G.GAME.blind.boss then
            add_tag(Tag('tag_coupon'))
            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        end
    end
}
