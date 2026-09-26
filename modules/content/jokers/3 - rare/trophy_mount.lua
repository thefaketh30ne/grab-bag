SMODS.Joker {
    key = "trophy_mount",
    loc_txt = {
		name = 'Trophy Mount',
		text = {
			"Defeat {C:attention}#1# Boss Blinds{} to",
            "create the current",
            "{C:attention}Boss Blind\'s {C:gb_boss}Boss{} Joker",
            "{C:inactive}(Must have room, {C:attention}#2#{C:inactive}/#1#)"
		}
	},
    blueprint_compat = true,
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    pixel_size = { h = 88 },
    pos = { x = 9, y = 9 },
    config = { extra = { counter = 0, threshold = 2, boss_joker_key = "gb_j_hook" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.threshold, card.ability.extra.counter } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round
        and context.game_over == false
        and context.main_eval
        and G.jokers.config.card_limit > (#G.jokers.cards + G.GAME.joker_buffer)
        and G.GAME.blind.boss then
            card.ability.extra.counter = card.ability.extra.counter + 1
            local boss_joker_key = gb_get_boss_joker_key(G.GAME.blind.config.blind.key)
            if G.P_CENTERS[boss_joker_key] then
                card.ability.extra.boss_joker_key = boss_joker_key
            end
            if card.ability.extra.counter == card.ability.extra.threshold then
                card.ability.extra.counter = 0
                SMODS.add_card{
                    set = "Joker",
                    key = card.ability.extra.boss_joker_key,
                    key_append = 'gb_trophy_mount',
                }
            end
        end
    end
}
