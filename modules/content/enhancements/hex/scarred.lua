SMODS.Enhancement {
    key = 'scarred',
    loc_txt = {
		name = 'Scarred Card',
		text = {
			"If this card is {C:attention}destroyed{},",
            "{C:attention}duplicate{} it and gain {X:mult,C:white}X#1#{} Mult",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 4, y = 0 },
    config = { x_mult = 1, extra = { x_mult_mod = 0.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult_mod, card.ability.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            local being_removed = false
            for _, playing_card in ipairs(context.removed) do
                if playing_card == card and not (card.edition and card.edition.key ~= "e_gb_temporary") then
                    being_removed = true
                end
            end
            if being_removed then
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "x_mult",
                    scalar_table = card.ability.extra,
                    scalar_value = "x_mult_mod",
                    no_message = true
                })
                SMODS.copy_card(card)
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end
}