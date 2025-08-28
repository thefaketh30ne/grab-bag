SMODS.Enhancement {
    key = 'rotten',
    loc_txt = {
		name = 'Rotten Card',
		text = {
            "{C:red}X#1# {C:attention}Blind{} size",
            "if held in hand"
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 5, y = 0 },
    config = { extra = { blind_size = 0.8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blind_size } }
    end,
    calculate = function(self, card, context)    
        if context.main_scoring and context.cardarea == G.play then
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            play_sound("cancel")
            card:juice_up()
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
