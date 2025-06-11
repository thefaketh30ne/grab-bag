SMODS.Joker {
	key = 'wild_joker',
	loc_txt = {
		name = 'Wild Joker',
		text = {
            "Gives {C:mult}+#1#{} Mult for",
            "each {C:attention}Wild Card",
            "in your {C:attention}full deck",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 2 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild

        local wild_tally = 0
        if G.playing_card then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_wild') then wild_tally = wild_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * wild_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local wild_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_wild') then wild_tally = wild_tally + 1 end
            end
            return {
                mult = card.ability.extra.mult * wild_tally
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}