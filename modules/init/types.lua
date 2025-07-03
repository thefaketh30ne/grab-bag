SMODS.Rarity {
    key = "shattered",
    loc_txt = {name = "Shattered"},
    badge_colour = HEX("673E79")
}

SMODS.ConsumableType {
    key = 'Ephemeral',
    shader = 'spectral',
    primary_colour = HEX('59778c'),
    secondary_colour = HEX('8ea4b3'),
    collection_rows = { 5, 5 },
    default = 'c_gb_sculpture',
    shop_rate = 1,
    cards = {
        ['c_gb_sculpture'] = true,
        ['c_gb_hourglass'] = true,
        ['c_gb_comet'] = true,
        ['c_gb_gold_dust'] = true,
        ['c_gb_magic'] = true,
        ['c_gb_plasma'] = true,
        ['c_gb_rust'] = true,
        ['c_gb_wish'] = true,
        },
    loc_txt = {
        name = "Ephemeral",
        collection = "Ephemeral Cards",
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
                }
            }
        },
    }

SMODS.UndiscoveredSprite {
    key = 'Ephemeral',
    atlas = 'Consumables',
    pos = { x = 3, y = 2 },
}

SMODS.DrawStep {
    key = "Ephemeral",
    order = 0,
    func = function(card, layer)
        if card.ability.set == 'Ephemeral'
        and (layer == 'card' or layer == 'both')
        and card.sprite_facing == 'front'
        and (card.config.center.discovered or card.bypass_discovery_center) then
            card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
        end
    end
}