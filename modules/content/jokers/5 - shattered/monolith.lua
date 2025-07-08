SMODS.Joker {
    key = "monolith",
    loc_txt = {
		name = 'Monolith',
		text = {
			"{X:mult,C:white}X#2#{} Mult, loses {X:mult,C:white}X#1#{} Mult",
			"if played hand is not ",
            "{C:attention}most played poker hand{}",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 0, y = 0 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { xmult_loss = 0.25, xmult = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_loss, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local lower = false
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                    lower = true
                    break
                end
            end
            if lower then
                card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_loss
                if card.ability.extra.xmult <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    card:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return {
                    message = "Shattered!",
                    colour = G.C.RED
                    }
                else
                    return {
                        message = "Downgraded!",
                        colour = G.C.MULT
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}