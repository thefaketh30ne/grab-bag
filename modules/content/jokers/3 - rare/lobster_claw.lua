SMODS.Joker {
    key = 'lobster_claw',
    loc_txt = {
        name = 'Lobster Claw',
        text = {
            "Jokers give {C:mult}Mult{} equal to",
            "the rank of a random",
            "scoring card",
        }
    },
    rarity = 3,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 1 },
    cost = 7,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.other_joker then
            local random_card = pseudorandom_element(context.scoring_hand, pseudoseed('gb_lobster_claw'))
            G.E_MANAGER:add_event(Event({
                func = function()
                    random_card:juice_up()
                    return true
                end
            }))
            return {
                mult = random_card.base.nominal or 0,
                message_card = context.other_joker
            }
        end
    end,
}