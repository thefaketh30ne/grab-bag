if Blockbuster then
    Blockbuster.ValueManipulation.CompatStandard{
        key = "grabbag",
        loc_txt = {
            name = "Grabbag",
            text = {
                "This card uses",
                "the Grab Bag",
                "Value Manipulation"
            },
        },
        source_mod = "GrabBag", -- prevent actual grab bag compat
        variable_conventions = {
            full_vars = {
                "odds",
                "threshold",
                "hands_required",
                "rank_count",
                "id",
                "suits",
                "cards_discarded", -- The hook
                "cards_played",
                "chosen_index",
                "faces", -- melting faces

                -- only for storm
                "blinds",

                -- the wall
                "boss_blind_size",

                -- the water
                "discards",

                -- For speculative bubble, mostly
                "base_numerator",
                "numerator_increase",

                -- yellow pages related
                "scoring_tally",

                -- memory leak
                "xmult_min",
                "xmult_max"
            },
            ends_on = {
                "_threshold",
                "_tally",
                "_loss"
            },
            starts_with = {
                "current_",
            }
        },
        integer_only_variable_conventions = {
            full_vars = {
                "copies",
                "retriggers",
                "cards_to_save",
                "cards_to_trigger",
                "hand_size",
                "cards_to_draw"
            },
            ends_on = {},
            starts_with = {},
        },
        variable_caps = {
            copies = 10,
            retriggers = 25,
            cards_to_save = 25,
            hand_size = 25,
            cards_to_draw = 25,
        },
        exempt_jokers = {
            j_gb_alien_joker = true,
            j_gb_coupon = true,
            j_gb_mugshot = true,
            j_gb_secret_box = true,
            j_gb_buffet_ticket = true,
            j_gb_hell_trees = true,
            j_gb_little_timbo = true, -- Could work, would just not personal standard to not accidentally mess with future jokers
            j_gb_patchwork = true,
            j_gb_ten_bob = true, -- Hardcoded values, but also would thematically be ruined </3
            j_gb_d20 = true,
            j_gb_lobster_claw = true,
            j_gb_flint = true,
            j_gb_mouth = true, -- no config to manipulate
            j_gb_psychic = true,
            j_gb_matchstick = true,
            j_gb_piper = true,
            j_gb_shame = true,
            j_gb_divination = true,
            j_gb_pure_essence = true,
        },
        redirect_objects = {
            gb_grabbag_scaling = {
                -- stacking xmult
                j_gb_hadal_zone = true,

                -- stacking xchips,

                -- mult/chips stacking
                j_gb_binman = true,
                j_gb_doner = true,
                j_gb_hot_potato = true,
                j_gb_patience = true,
                j_gb_receipt = true,
                j_gb_sketchy_joker = true,
                j_gb_torchlight = true,
                j_gb_battery = true,
                j_gb_brass_horseshoe = true,
                j_gb_calculator = true,
                j_gb_first_strike = true,
                j_gb_taxman = true,
                j_gb_double_king = true,
                j_gb_pentagram = true,
                j_gb_eye = true,
                j_gb_wheel = true,
                j_gb_mystic = true,
                j_gb_trident = true,
                j_gb_cosmic_diamond = true,
                j_gb_lighthouse = true,
                j_gb_lovecraftian_horror = true,
                j_gb_ornate_vase = true,
                j_gb_phase_charts = true,

                -- Technically not stacking but happens to be set up to fit
                j_gb_paint_the_town_red = true,

            },
            gb_grabbag_reverse_scaling = {
                j_gb_golden_cookie = true,
            }
        }, 
        
    }

    -- Notes on Jokers
    -- Bad Trip: my own design choices would make the -10 exempt, but that'd need joker-specific exemption.
    -- counterfeit Joker: money ideally doesn't scale down
    -- Joker Boy: Disproportionally benefits from value manip, but should work fine with it
    -- The needle would need its own standard to not let the -hands be affected
end