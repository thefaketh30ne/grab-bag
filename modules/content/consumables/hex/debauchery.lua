SMODS.Consumable {
    key = "debauchery",
    set = "Hex",
    loc_txt = {
        name = 'Superstition',
        text = { {
            "For each selected card,",
            "{C:green}#1# in #2# chance{} to",
            "create a {C:attention}Tag",
        },
        {
            "An equal number of cards",
            "in {C:attention}full deck{} become {C:attention}Slothful"
        } }
    },
    config = { extra = { odds = 2, hex_to_apply = "slothful" } },
    atlas = 'gb_HexCards',
    pos = { x = 0, y = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = GB.hex_tooltip(card.ability.extra.hex_to_apply)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { new_numerator, new_denominator } }
    end,
    use = function(self, card, area, copier)
        for i = 1, #G.hand.highlighted do
            if SMODS.pseudorandom_probability(card, 'debauchery', 1, card.ability.extra.odds) then
                local tag_pool = get_current_pool('Tag')
                local selected_tag = pseudorandom_element(tag_pool, pseudoseed('gb_memphis'))
                local it = 1
                while selected_tag == 'UNAVAILABLE' do
                    it = it + 1
                    selected_tag = pseudorandom_element(tag_pool, pseudoseed('gb_memphis' .. it))
                end
                add_tag(Tag(selected_tag, false, 'Small'))
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                gb_apply_hex(G.playing_cards, card.ability.extra.hex_to_apply, #G.hand.highlighted)
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0
    end
}

