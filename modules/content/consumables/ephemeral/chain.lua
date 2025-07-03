SMODS.Consumable {
    key = "chain",
    set = "Ephemeral",
    loc_txt = {
        name = 'Chain',
        text = {
            "Adds {C:attention}#1#{} {C:dark_edition}Temporary{}",
            "{C:attention}ascending-rank{} cards to hand",
        }
    },
    config = {extra = { cards_to_create = 5 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 0, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        local starting_id = pseudorandom_element({2, 3, 4, 5, 6, 7, 8, 9, 10}, pseudoseed("gb_group"))
        for k = 1, self.config.extra.cards_to_create do
            local playing_card = SMODS.create_card {
                rank = id_to_rank(starting_id),
                set = "Base",
                edition = "e_gb_temporary",
                area = G.discard
            }
            G.E_MANAGER:add_event(Event({
                func = function()
                    playing_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.hand:emplace(playing_card)
                    return true
                end
            }))
            starting_id = starting_id + 1
        end
    end,
    can_use = function(self, card)
        if G.hand and G.GAME.blind.in_blind then
            return true
        else
            return false
        end
    end,
}

id_to_rank = function(id)
    local conversion = {
        {2, "2"},
        {3, "3"},
        {4, "4"},
        {5, "5"},
        {6, "6"},
        {7, "7"},
        {8, "8"},
        {9, "9"},
        {10, "T"},
        {11, "J"},
        {12, "Q"},
        {13, "K"},
        {14, "A"},
    }
    for k, v in ipairs(conversion) do
        if id == v[1] then
            return conversion[k][2]
        end
    end
end

