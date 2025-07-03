SMODS.Consumable {
    key = "plasma",
    set = "Ephemeral",
    loc_txt = {
        name = 'Plasma',
        text = {
            "Adds {C:attention}#1#{} {C:dark_edition}Temporary{} cards",
            "with {C:purple}Purple Seals{} to hand",
        }
    },
    config = {extra = { cards_to_create = 2 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 2, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        for k = 1, self.config.extra.cards_to_create do
            local playing_card = SMODS.create_card {
                set = "Base",
                seal = "Purple",
                edition = "e_gb_temporary",
                area = G.discard
            }
            G.E_MANAGER:add_event(Event({
                func = function()
                    playing_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.hand:emplace(playing_card)
                    SMODS.debuff_card(playing_card, "prevent_debuff", "source")
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