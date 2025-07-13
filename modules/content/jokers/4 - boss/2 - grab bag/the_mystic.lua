SMODS.Joker{
    key = "mystic",
    loc_txt = {
		name = 'The Mystic',
		text = {
            "This Joker gains {X:mult,C:white}X#1#{} Mult",
            "for every {C:attention}consecutive{} hand",
            "with a scoring {C:attention}face{} card",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 9, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult_mod = 0.2, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.xmult_mod,
            card.ability.extra.xmult,
        } }
	end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local has_face = false
            for _, playing_card in pairs(context.scoring_hand) do
                if playing_card:is_face() then
                    has_face = true
                    break
                end
            end
            if has_face == true then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.MULT
                }
            else
                card.ability.extra.xmult = 1
                return {
                    message = localize("k_reset"),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_mystic")
    end
}