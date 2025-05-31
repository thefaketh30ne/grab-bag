SMODS.Consumable {
    key = "shatter",
    set = "Spectral",
    loc_txt = {
        name = 'Shatter',
        text = {
            "{C:attention}Shatters{} one random eligible Joker",
        }
    },
    hidden = true,
    soul_set = "Tarot",
    soul_rate = 0.07,
    atlas = 'Consumables',
    pos = { x = 0, y = 0 },
    can_use = function(self, card)
        -- Check if the player has any eligible jokers to shatter
        for i, joker in ipairs(G.jokers.cards) do
            for i = 1, #GB.G.SHATTERED_TABLE do
                if GB.G.SHATTERED_TABLE[i][1] == joker.config.center.key then
                    return true
                end
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        local eligible_jokers = {}
        -- Check currently owned Jokers for eligibility
        for i, joker in ipairs(G.jokers.cards) do
            for i = 1, #GB.G.SHATTERED_TABLE do
                if GB.G.SHATTERED_TABLE[i][1] == joker.config.center.key then
                    table.insert(eligible_jokers, GB.G.SHATTERED_TABLE[i][1])
                end
            end
        end
        -- Randomly select a joker to shatter
        local outgoing_joker_key = eligible_jokers[math.random(#eligible_jokers)]
        local outgoing_joker = SMODS.find_card(outgoing_joker_key)[1]
        -- Find the corresponding shattered joker
        for i = 1, #GB.G.SHATTERED_TABLE do
            if GB.G.SHATTERED_TABLE[i][1] == outgoing_joker_key then
                local incoming_joker_key = GB.G.SHATTERED_TABLE[i][2]
                -- Remove the original joker and add the shattered one
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
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                        outgoing_joker:start_dissolve()
                        SMODS.add_card{
                        set = 'Joker',
                        key = incoming_joker_key,
                        no_edition = true
                        }
                        return true
                        end
                    }))
                    card:juice_up(0.3, 0.5)
                    return true
                end
                }))
                break
            end
        end
    end,
    in_pool = function(self, args)
        local eligible_jokers = {}
        -- Check currently owned Jokers for eligibility
        for i, joker in ipairs(G.jokers.cards) do
            for i = 1, #GB.G.SHATTERED_TABLE do
                if GB.G.SHATTERED_TABLE[i][1] == joker.config.center.key then
                    table.insert(eligible_jokers, GB.G.SHATTERED_TABLE[i][1])
                end
            end
        end
        if #eligible_jokers > 0 then
            return true
        else
            return false
        end
    end
}