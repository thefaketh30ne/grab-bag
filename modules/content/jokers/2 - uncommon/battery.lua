SMODS.Joker {
	key = 'battery',
	loc_txt = {
		name = 'Battery',
		text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult",
            "if a hand is played with a",
            "{C:attention}Gold{} or {C:attention}Steel{} card held in hand",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 8, y = 7 },
	cost = 5,
    enhancement_gate = "m_gb_charge",
	blueprint_compat = true,
    config = { extra = { xmult = 1, xmult_mod = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.xmult_mod,
            card.ability.extra.xmult,
        } }
    end,
    calculate = function(self, card, context)
        if context.before
        and not context.blueprint
        and card.ability.extra.locked == false then
            local active = false
            for _, playing_card in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(playing_card, 'm_gold')
                or SMODS.has_enhancement(playing_card, 'm_steel') then
                    active = true
                    break
                end
            end
            if active == true then
                SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_colour = G.C.MULT
                })
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}
