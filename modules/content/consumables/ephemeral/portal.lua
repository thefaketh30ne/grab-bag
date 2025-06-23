SMODS.Consumable {
    key = "portal",
    set = "Ephemeral",
    loc_txt = {
        name = 'Portal',
        text = {
            "Adds {C:attention}#1#{} {C:dark_edition}Temporary{}",
            "{C:attention}numbered{} cards to hand",
        }
    },
    config = {extra = { cards_to_create = 4 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        for k = 1, self.config.extra.cards_to_create do
            local playing_card = SMODS.create_card {
                set = "Base",
                edition = "e_gb_temporary",
                rank = pseudorandom_element(
                    {"2", "3", "4", "5", "6", "7", "8", "9", "10"},
                    pseudoseed("gb_portal")
                ),
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