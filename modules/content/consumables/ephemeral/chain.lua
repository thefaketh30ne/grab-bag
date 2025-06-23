SMODS.Consumable {
    key = "group",
    set = "Ephemeral",
    loc_txt = {
        name = 'Group',
        text = {
            "Adds {C:attention}#1#{} {C:dark_edition}Temporary{}",
            "same-suited cards to hand",
        }
    },
    config = {extra = { cards_to_create = 5 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 6, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        local suit = pseudorandom_element({"S", "H", "C", "D"}, pseudoseed("gb_collapse"))
        for k = 1, self.config.extra.cards_to_create do
            local playing_card = SMODS.create_card {
                suit = suit,
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
        {10, "10"},
        {11, "J"},
        {12, "Q"},
        {13, "K"},
        {14, "A"},
    }
    for k, v in ipairs(t) do
        if id == v then
            return conversion[k][2]
        end
    end
end

