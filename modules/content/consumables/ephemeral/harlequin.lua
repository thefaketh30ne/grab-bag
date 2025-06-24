SMODS.Consumable {
    key = "harlequin",
    set = "Ephemeral",
    loc_txt = {
        name = 'Harlequin',
        text = {
            "Adds a {C:dark_edition}Temporary{}",
            "{C:rare}Rare {C:attention}Joker{} to Jokers",
        }
    },
    config = {extra = { cards_to_create = 3 }},
    atlas = 'gb_Ephemerals',
    pos = { x = 2, y = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.cards_to_create } }
    end,
    use = function(self, card, area, copier)
        SMODS.add_card {
            set = "Joker",
            rarity = 'Rare',
            edition = 'e_gb_temporary',
            key_append = 'gb_harlequin'
        }
        G.GAME.joker_buffer = 0
    end,
    can_use = function(self, card)
        if G.hand and G.GAME.blind.in_blind then
            return true
        else
            return false
        end
    end,
}