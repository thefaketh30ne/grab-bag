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
                "xmult_mod",
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

