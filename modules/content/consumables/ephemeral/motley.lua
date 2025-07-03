SMODS.Consumable {
    key = "motley",
    set = "Ephemeral",
    loc_txt = {
        name = 'Motley',
        text = {
            "Adds {C:attention}#1#{} {C:dark_edition}Temporary{}",
            "{C:common}Common {C:attention}Jokers{} to Jokers",
        }
    },
    config = {extra = { cards_to_create = 3 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 3, y = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        for k = 1, self.config.extra.cards_to_create do
            local playing_card = SMODS.add_card {
                set = "Joker",
                rarity = 'Common',
                edition = 'e_gb_temporary',
                key_append = 'gb_motley'
            }
            G.GAME.joker_buffer = 0
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