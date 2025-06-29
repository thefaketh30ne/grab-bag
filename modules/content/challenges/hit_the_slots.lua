SMODS.Challenge {
    key = 'hit_the_slots',
    loc_txt = {
        name = "Hit The Slots!"
    },
    modifiers = {
            { id = 'discards', value = 0 },
        },
    jokers = {
        { id = 'j_gb_jackpot', eternal = true },
        { id = 'j_gb_misfortune', eternal = true },
    },
    rules = {
        modifiers = {
            { id = 'joker_slots', value = 5 },
        }
    },
}