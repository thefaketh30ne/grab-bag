SMODS.Joker {
	key = 'battery',
	loc_txt = {
		name = 'Battery',
		text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult",
            "when a {C:attention}Charge{} card charges",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
            "{C:inactive,s:0.85}(Locks at {X:mult,C:white,s:0.85}X#3#{C:inactive,s:0.85} Mult)"
		}
	},
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 8, y = 7 },
	cost = 5,
    enhancement_gate = "m_gb_charge",
	blueprint_compat = true,
    config = { extra = { xmult = 1, xmult_mod = 0.1, xmult_lock = 3, locked = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
             card.ability.extra.xmult_mod,
             card.ability.extra.xmult,
             card.ability.extra.xmult_lock,
            } }
    end,
    calculate = function(self, card, context)
        if context.charge_card_charged
        and not context.blueprint
        and card.ability.extra.locked == false then
            card.ability.extra.xmult = math.min(
                card.ability.extra.xmult + card.ability.extra.xmult_mod,
                card.ability.extra.xmult_lock
            )
            if card.ability.extra.xmult >= card.ability.extra.xmult_lock then
                card.ability.extra.locked = true
                return {
                    message = "Fully Charged!",
                    colour = G.C.MULT
                }
            else
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}
