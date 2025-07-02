SMODS.Joker {
    key = 'patchwork',
    loc_txt = {
        name = 'Patchwork',
        text = {
            "At start of shop,",
            "create a random {C:dark_edition}Temporary{} Joker",
        }
    },
    rarity = 2,
    atlas = 'gb_Jokers',
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.starting_shop then
            SMODS.add_card {
                set = "Joker",
                edition = 'e_gb_temporary',
                key_append = 'gb_patchwork'
            }
            card:juice_up()
        end
    end
}