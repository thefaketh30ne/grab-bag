SMODS.Consumable {
    key = "portal",
    set = "Ephemeral",
    loc_txt = {
        name = 'Portal',
        text = {
            "Adds {C:attention}#1#{} {C:dark_edition}Temporary{}",
            "same-suited {C:attention}numbered{} cards to hand",
        }
    },
    config = {extra = { cards_to_create = 4 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        local suit = pseudorandom_element({"S", "H", "C", "D"}, pseudoseed("gb_collapse"))
        for k = 1, self.config.extra.cards_to_create do
            local playing_card = SMODS.create_card {
                set = "Base",
                suit = suit,
                edition = "e_gb_temporary",
                rank = pseudorandom_element(
                    {"2", "3", "4", "5", "6", "7", "8", "9", "T"},
                    pseudoseed("gb_portal")
                ),
                area = G.discard
            }
            G.E_MANAGER:add_event(Event({
                func = function()
                    playing_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    playing_card.playing_card = G.playing_card
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