SMODS.Blind {
    key = "hearth",
    loc_txt = {
        name = "The Hearth",
        text = {
            "Destroy a random Joker",
            "if score catches fire"

        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 27 },
    boss = { min = 3 },
    boss_colour = HEX("6be4b8"),
    calculate = function(self, blind, context)
        if context.final_hand_oneshot and not blind.disabled then
            local valid_targets = {}
            for _, joker in pairs(G.jokers.cards) do
                if not joker.ability.eternal
                and not joker.getting_sliced then
                    valid_targets[#valid_targets + 1] = joker
                end
            end
            local joker_to_destroy = pseudorandom_element(valid_targets, pseudoseed('gb_hearth'))
            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
            
        end
    end,
}