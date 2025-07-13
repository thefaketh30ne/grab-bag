SMODS.Joker{
    key = "storm",
    loc_txt = {
		name = 'The Storm',
		text = {
            "{C:attention}-1 Ante{} for every {C:attention}#2#{} blinds",
            "beaten with {C:attention}no hands remaining{}",
            "{C:inactive}({C:attention}#1#{C:inactive}/#2#)"

		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 4, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blind_tally, card.ability.extra.blinds } }
    end,
    config = { extra = { blind_tally = 0, blinds = 4 } },

    calculate = function(self, card, context)
        if context.end_of_round
        and context.main_eval
        and G.GAME.current_round.hands_left == 0
        and not context.blueprint
        and context.game_over == false then
            card.ability.extra.blind_tally = card.ability.extra.blind_tally + 1
            if card.ability.extra.blind_tally >= card.ability.extra.blinds then
                card.ability.extra.blind_tally = card.ability.extra.blind_tally - card.ability.extra.blinds
                ease_ante(-1)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
            else
                return {
                    message = card.ability.extra.blind_tally .. "/" .. card.ability.extra.blinds,
                    colour = G.C.FILTER
                }
            end
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_storm")
    end
}
