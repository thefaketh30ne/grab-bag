SMODS.Joker{
    key = "manacle",
    loc_txt = {
		name = 'The Manacle',
		text = {
            "{C:attention}+#1#{{} hand size this round",
            "after hand played",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 7, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { hand_size_mod = 1, hand_size_tally = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_size_mod } }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and G.GAME.chips >= G.GAME.blind.chips then
            G.hand:change_size(card.ability.extra.hand_size_mod)
            card.ability.extra.hand_size_tally = card.ability.extra.hand_size_tally + card.ability.extra.hand_size_mod
            return {
                message = "+" .. card.ability.extra.hand_size_mod,
                colour = G.C.FILTER
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint and card.ability.extra.hand_size_tally > 0 then
            G.hand:change_size(-card.ability.extra.hand_size_tally)
            card.ability.extra.hand_size_tally = 0
            return {
                message = localize("k_reset"),
                colour = G.C.FILTER
            }
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size_tally)
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_manacle")
    end
}