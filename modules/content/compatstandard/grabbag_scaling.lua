if Blockbuster then
    Blockbuster.ValueManipulation.CompatStandard{
        key = "grabbag_scaling",
        loc_txt = {
            name = "Grabbag",
            text = {
                "This card uses",
                "the Grab Bag",
                "Value Manipulation"
            },
        },
        variable_conventions = {
            full_vars = {
                "odds",
                "threshold",
                "hands_required",
                "mult",
                "xmult",
                "chips",
                "chips_loss",
                "xmult_lock", -- keeps the max value for Battery set at x3
                "dollars",
                -- for Calculator
                "scored_cards",
                "cards_to_score"
            },
            ends_on = {
            },
            starts_with = {
            }
        },
        integer_only_variable_conventions = {
            full_vars = {
                "copies"
            },
            ends_on = {},
            starts_with = {},
        },
        variable_caps = {
            copies = 10
        },
        exempt_jokers = {
        },
        redirect_objects = {
        }, 
    }
end