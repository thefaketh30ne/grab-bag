SMODS.Edition {
    key = 'temporary',
    shader = 'voucher',
    loc_txt = {
        name = "Temporary",
        text = {
            "{C:attention}Destroyed{} at end of round",
            "Cannot be debuffed",
        },
        label = "Temporary",
    },
    prefix_config = {
        -- This allows using the vanilla shader
        -- Not needed when using your own
        shader = false
    },
    in_shop = false,
    weight = 0,
    extra_cost = 0,
    sound = { sound = "foil1", per = 1.2, vol = 0.4 },
    get_weight = function(self)
        return 0
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not card.ability.getting_destroyed then
            card.ability.getting_destroyed = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                blockable = false,
                func = function()
                    card:start_dissolve()
                    return true
                end
            }))
        end
    end,
    on_remove = function(card)
        if card.edition and card.edition.key ~= "e_gb_temporary" then
            card:set_edition("e_gb_temporary")
        end
    end,
    in_pool = function(self, args)
        return false
    end
}

