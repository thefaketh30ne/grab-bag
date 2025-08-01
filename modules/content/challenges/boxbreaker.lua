SMODS.Challenge {
    key = 'boxbreaker',
    loc_txt = {
        name = "Boxbreaker"
    },
    jokers = {
        { id = 'j_gb_secret_box' },
        { id = 'j_gb_secret_box' },
        { id = 'j_gb_secret_box' },
        { id = 'j_gb_secret_box' },
        { id = 'j_gb_secret_box' },
        { id = 'j_gb_secret_box' },
        { id = 'j_gb_secret_box' },
        { id = 'j_gb_secret_box' },
    },
    rules = {
        modifiers = {
            { id = 'joker_slots', value = 8 },
        },
        custom = {
            { id = 'no_shop_jokers' },
        },
    },
    restrictions = {
        banned_cards = {
            { id = 'c_judgement' },
            { id = 'c_wraith' },
            { id = 'c_soul' },
            { id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1', 'p_buffoon_normal_2',
                'p_buffoon_normal_3', 'p_buffoon_normal_4',
                'p_buffoon_jumbo_1', 'p_buffoon_jumbo_2',
                'p_buffoon_mega_1', 'p_buffoon_mega_2' }
            },
        },
        banned_tags = {
            { id = 'tag_uncommon' },
            { id = 'tag_rare' },
            { id = 'tag_negative' },
            { id = 'tag_foil' },
            { id = 'tag_holographic' },
            { id = 'tag_polychrome' },
            { id = 'tag_buffoon' },
            { id = 'tag_top_up' },
        },
    }
}