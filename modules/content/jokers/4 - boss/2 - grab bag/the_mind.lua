SMODS.Joker{
    key = "mind",
    loc_txt = {
		name = 'The Mind',
		text = {
			"When hand is played, {C:attention}flips{} all {C:attention}face-up{}",
            "{C:hearts}Hearts{} and {C:diamonds}Diamonds{} held in hand",
            "Cards flipped by this Joker",
            "{C:attention}permanently{} gain {C:mult}+#1#{} Mult",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 4, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { mult = 6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.before then
            for _, playing_card in ipairs(G.hand.cards) do
                if (playing_card:is_suit("Hearts")
                or playing_card:is_suit("Diamonds"))
                and not context.blueprint
                and playing_card.facing == "front" then
                    playing_card.ability.perma_mult = (playing_card.ability.perma_mult or 0) + card.ability.extra.mult
                    playing_card:flip()
                    SMODS.calculate_effect( {
                        message = localize('k_upgrade_ex'),
                        message_card = playing_card,
                        colour = G.C.MULT
                    }, card)
                end
            end
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_mind")
    end
}