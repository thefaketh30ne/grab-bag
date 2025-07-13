SMODS.Joker{
    key = "flag",
    loc_txt = {
		name = 'The Flag',
		text = {
            "Cards held in hand at end of round",
            "{C:attention}permanently{} gain {X:mult,C:white}X#1#{} Mult"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 0, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult = 0.25 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { 
            card.ability.extra.xmult
        } }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            for _, playing_card in pairs(G.hand.cards) do
                if not playing_card.debuff then
                    playing_card.ability.perma_x_mult = (playing_card.ability.perma_x_mult or 0) + card.ability.extra.xmult
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
        return gb_is_blind_defeated("bl_gb_flag")
    end
}