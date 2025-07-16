SMODS.Consumable {
    key = "shatter",
    set = "Spectral",
    loc_txt = {
        name = 'Shatter',
        text = {
            "{C:attention}Shatters{} one random",
            "{C:attention}eligible{} Joker",
        }
    },
    hidden = true,
    soul_set = "Tarot",
    soul_rate = 0.04,
    atlas = 'gb_Consumables',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX("6A4C77") } } }
    end,

    can_use = function(self, card)
        return (#gb_find_eligible_shatters() > 0)
    end,
    
    use = function(self, card, area, copier)
        local outgoing_joker_key = pseudorandom_element(gb_find_eligible_shatters(), "gb_shatter")
        local outgoing_joker = SMODS.find_card(outgoing_joker_key)[1]
        -- Find the corresponding shattered joker
        local incoming_joker_key = GB_SHATTERED_TABLE[outgoing_joker_key]
                -- Remove the original joker and add the shattered one
        outgoing_joker:start_dissolve()
        SMODS.add_card{
            set = 'Joker',
            key = incoming_joker_key,
            edition = (outgoing_joker.edition and outgoing_joker.edition.key) or nil
        }
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            attention_text({
                text = "Shatter!",
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = HEX("673E79"),
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                    'tm' or 'cm',
                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                silent = true
            })
            card:juice_up(0.3, 0.5)
            return true
            end
        }))
    end,
    in_pool = function(self, args)
        return (#gb_find_eligible_shatters() > 0)
    end
}