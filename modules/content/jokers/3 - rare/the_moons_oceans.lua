SMODS.Joker {
    key = 'the_moons_oceans',
    loc_txt = {
        name = 'The Moon\'s Oceans',
        text = {
            "Scored {C:attention}Aces{} retrigger once",
            "and give {X:mult,C:white}X#1#{} Mult",
        }
    },
    config = { extra = { xmult = 1.5, retriggers = 1} },
    rarity = 3,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 2 },
    cost = 9,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 14 then
                return {
                    repetitions = card.ability.extra.retriggers,
                }
            end
            
        end
        if context.individual and context.cardarea == G.play and
            context.other_card:get_id() == 14 then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
        
    end
}