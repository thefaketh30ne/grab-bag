SMODS.Joker{
    key = "water",
    loc_txt = {
		name = 'The Water',
		text = {
            "When {C:attention}Blind{} is selected,",
            "lose all {C:red}discards{}",
            "{C:attention}+#1#{} hand size for",
            "every {C:attention}#4# {C:red}discards{} lost",
            "{C:inactive}(Currently {C:attention}+#3#{C:inactive} hand size)",
            "{C:inactive}({C:attention}#2#{C:inactive}/#4#)"
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 8, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { hand_size_mod = 1, hand_size_tally = 0, discard_tally = 0, discards = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.hand_size_mod,
            card.ability.extra.discard_tally,
            card.ability.extra.hand_size_tally,
            card.ability.extra.discards
        } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            card.ability.extra.discard_tally = card.ability.extra.discard_tally + G.GAME.current_round.discards_left
            ease_discard(-G.GAME.current_round.discards_left, nil, true)
            if card.ability.extra.discard_tally >= card.ability.extra.discards then
                card.ability.extra.discard_tally = card.ability.extra.discard_tally - card.ability.extra.discards
                G.hand:change_size(card.ability.extra.hand_size_mod)
                card.ability.extra.hand_size_tally = card.ability.extra.hand_size_tally + card.ability.extra.hand_size_mod
                return {
                    message = "+" .. card.ability.extra.hand_size_mod,
                    colour = G.C.FILTER
                }
            else
                return {
                    message = card.ability.extra.discard_tally .. "/" .. card.ability.extra.discards,
                    colour = G.C.FILTER
                }
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size_tally)
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_water")
    end
}