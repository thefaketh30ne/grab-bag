SMODS.Joker {
	key = 'escape_velocity',
	loc_txt = {
		name = 'Escape Velocity',
		text = {
            "Level up played {C:attention}poker hand{}",
            "if it has been played",
            "{C:attention}#1#{} or fewer times this run"
		}
	},
	config = { extra = { play_threshold = 3 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 3, y = 5 },
	cost = 5,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.play_threshold } }
	end,
    calculate = function(self, card, context)
	    if context.before then
            if G.GAME.hands[context.scoring_name].played <= card.ability.extra.play_threshold then
                return {
                    level_up = true
                }
            end
        end
    end
}