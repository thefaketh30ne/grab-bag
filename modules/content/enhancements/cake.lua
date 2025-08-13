SMODS.Enhancement {
    key = 'cake',
    loc_txt = {
		name = 'Cake Card',
        -- TODO: make these lines not show up if they're not doing anything
		text = {
			"{C:chips}+#1#{} extra chips",
            "{C:mult}+#2#{} Mult",
            "{X:mult,C:white}X#3#{} Mult",
            "{C:attention}Remove{} an effect on play",
            "Eaten in {C:attention}#4#{} plays",
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 2, y = 0 },
    config = { extra = {
        chips = 25,
        mult = 5,
        xmult = 1.25,
        effects_left = {"chips", "mult", "xmult"},
        progress = 0
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.chips,
            card.ability.extra.mult,
            card.ability.extra.xmult,
            #card.ability.extra.effects_left,
        } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
            chips = card.ability.extra.chips,
            mult = card.ability.extra.mult,
            xmult = card.ability.extra.xmult,
            }
        end
        if context.destroy_card 
        and context.destroy_card == card
        and context.cardarea == G.play
        and #card.ability.extra.effects_left <= 1 then
            return {
                message = 'Eaten!',
                remove = true
            }
        end
        if context.after
        and not context.repetition
        and context.cardarea == G.play then
            local index_to_remove = pseudorandom("gb_cake", 1, #card.ability.extra.effects_left)
            local effect_to_remove = card.ability.extra.effects_left[index_to_remove]
            table.remove(card.ability.extra.effects_left, index_to_remove)
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.ability.extra.progress = math.min(card.ability.extra.progress + 1, 2)
                    return true
                end
            }))
            if effect_to_remove == "chips" then
                card.ability.extra.chips = 0
                return {
                    message = "Chips Eaten!",
                    colour = G.C.CHIPS
                } 
            elseif effect_to_remove == "mult" then
                card.ability.extra.mult = 0
                return {
                    message = "Mult Eaten!",
                    colour = G.C.MULT
                } 
            else 
                card.ability.extra.xmult = 1
                return {
                    message = "XMult Eaten!",
                    colour = G.C.MULT
                } 
            end
        end
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') then
            card.children.center:set_sprite_pos({ x = 2 + card.ability.extra.progress, y = 0 })
        end
    end
}
