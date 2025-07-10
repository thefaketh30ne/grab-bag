SMODS.Joker{
    key = "wheel",
    loc_txt = {
		name = 'The Wheel',
		text = {
			"{C:green}#4# in #3# chance{} to",
            "draw a card {C:attention}face-down{} and",
            "give this Joker {X:mult,C:white}X#2#{} Mult",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",

		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 6, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { odds = 7, xmult = 1, xmult_mod = 0.1, flipped_cards = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            card.ability.extra.xmult,
            card.ability.extra.xmult_mod,
            card.ability.extra.odds,
            G.GAME.probabilities.normal or 1
        } }
    end,

    calculate = function(self, card, context)
        if context.stay_flipped 
        and context.to_area == G.hand 
        and not context.blueprint
        and SMODS.pseudorandom_probability(card, 'gb_wheel', G.GAME.probabilities.normal, card.ability.extra.odds) then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            card.ability.extra.flipped_cards = true
            return {
                stay_flipped = true
            }
        end
        if context.hand_drawn and card.ability.extra.flipped_cards == true then
            card.ability.extra.flipped_cards = false
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_wheel")
    end
}