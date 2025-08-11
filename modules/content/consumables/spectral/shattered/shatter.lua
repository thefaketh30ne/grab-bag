SMODS.Consumable {
    key = "shatter",
    set = "Spectral",
    loc_txt = {
        name = 'Shatter',
        text = {
            "{V:1}Shatters{} one random",
            "{C:attention}eligible{} Joker",
        }
    },
    hidden = true,
    soul_set = "Tarot",
    soul_rate = 0.04,
    atlas = 'gb_Consumables',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { HEX("834896") } } }
    end,

    can_use = function(self, card)
        return (#gb_find_eligible_shatters() > 0)
    end,

    in_pool = function(self, args)
        return (#gb_find_eligible_shatters() > 0)
    end,
    
    use = function(self, card, area, copier)
        local outgoing_joker_key = pseudorandom_element(gb_find_eligible_shatters(), "gb_shatter")
        local outgoing_joker = SMODS.find_card(outgoing_joker_key)[1]
        -- Find the corresponding shattered joker
        local incoming_joker_key = GB_SHATTERED_TABLE[outgoing_joker_key]
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
                    edition = (outgoing_joker.edition and outgoing_joker.edition.key) or nil
                }
                return true
                end
                    }))
            card:juice_up(0.3, 0.5)
            return true
            end
        }))
    end,

    --thanks to SDM_0 for this
    update = function(self, card, dt)
        if card.gb_shatter_juice == nil then
            card.gb_shatter_juice = false
        end

        if card.highlighted and not card.gb_shatter_juice and (G.jokers and G.jokers.cards) then
            local eligible_jokers = {}
            for _, v in ipairs(G.jokers.cards) do
                if GB_SHATTERED_TABLE[v.config.center.key] then
                    eligible_jokers[#eligible_jokers + 1] = v
                end
            end
            if next(eligible_jokers) then
                for _, v in ipairs(eligible_jokers) do
                    if not v.juice then
                        local eval = function() return (card.highlighted) end
                        juice_card_until(v, eval, true)
                    end
                end
                card.gb_shatter_juice = true
            end
        end

        if not card.highlighted then
            card.gb_shatter_juice = nil
        end
    end
}