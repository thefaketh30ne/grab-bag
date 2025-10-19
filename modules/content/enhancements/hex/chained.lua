SMODS.Enhancement {
    key = 'chained',
    loc_txt = {
		name = 'Chained Card',
		text = {
			"{C:chips}+#1#{} Chips for every",
            "{C:attention}Chained{} card in {C:attention}full deck",
            "{C:inactive}(Currently{C:chips}+#1#{C:inactive} Chips)"
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 1, y = 0 },
    config = { bonus = 0, extra = { chips_mod = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips_mod * gb_tally_enhancements(G.playing_cards, "m_gb_chained") } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.bonus = card.ability.extra.chips_mod * gb_tally_enhancements(G.playing_cards, "m_gb_chained")
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
