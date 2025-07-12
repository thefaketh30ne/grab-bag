SMODS.Joker{
    key = "cross",
    loc_txt = {
		name = 'The Cross',
		text = {
            "Sets all {C:green}listed probabilities{} to {C:attention}0{}",
            "Jokers with {C:green}listed probabilities{}",
            "give {X:mult,C:white}X#1#{} Mult when scored",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 2, y = 3 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult = 1.75 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.xmult
        } }
    end,
    calculate = function(self, card, context)
        if context.other_joker then
            if context.other_joker.ability.extra and type(context.other_joker.ability.extra) == "table" then
                if context.other_joker.ability.extra.odds then
                    return {
                        xmult = card.ability.extra.xmult,
                        message_card = context.other_joker
                    }
                end
            elseif type(context.other_joker.ability.extra) == "number" then
                return {
                    xmult = card.ability.extra.xmult,
                    message_card = context.other_joker
                }
            end
        end
        if context.fix_probability then
            return {
                numerator = 0
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_cross")
    end
}
