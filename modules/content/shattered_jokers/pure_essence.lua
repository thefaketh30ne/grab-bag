SMODS.Joker {
	key = 'pure_essence',
	loc_txt = {
		name = 'Pure Essence',
		text = {
			"Sell this Joker to create",
            "a random {C:G.C.RARITY.Legendary,E:1}Legendary{} Joker",
		}
	},
	blueprint_compat = false,
	atlas = 'ShatteredJokers',
	pos = { x = 7, y = 0 },
    soul_pos = { x = 7, y = 1 },
    rarity = "gb_shattered",
    cost = 10,
    calculate = function(self, card, context)
        if context.selling_self and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    SMODS.add_card({ set = 'Joker', legendary = true })
                    check_for_unlock { type = 'spawn_legendary' }
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end
}