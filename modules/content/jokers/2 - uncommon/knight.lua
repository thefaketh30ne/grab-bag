SMODS.Joker {
	key = 'knight',
	loc_txt = {
		name = 'Knight',
		text = {
            "{C:attention}Steel Cards{} give",
            "{X:mult,C:white}X#1#{} Mult when scored",
		}
	},
	config = { extra = { xmult = 1.5 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 0, y = 2 },
	cost = 5,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_steel') then
            return {
                xmult = card.ability.extra.xmult
			}
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_steel') then
                return true
            end
        end
        return false
    end,
}