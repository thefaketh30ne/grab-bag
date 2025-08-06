SMODS.Enhancement {
    key = 'wooden',
    loc_txt = {
		name = 'Wooden Card',
		text = {
			"{X:mult,C:white}X#1#{} Mult",
            "Destroys card if",
            "played hand causes",
            "{C:attention}score to catch fire{}",
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 1, y = 0 },
    config = { Xmult = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card
        and context.cardarea == G.play
        and context.destroy_card == card
        and gb_is_score_on_fire() then
            return { remove = true }
        end
    end
}
