GB.Hex {
    key = 'decaying_hex',
    atlas = 'gb_Hexes',
    pos = { x = 3, y = 0 },
    badge_colour = HEX("4F7917"),
    loc_txt = {
        name = "Decaying",
        text = {
            "Permanently debuffed",
            "in {C:attention}#1#{} rounds"
        },
        label = "Decaying",
    },
    config = { extra = { rounds_left = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rounds_left } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            card.ability.extra.rounds_left = math.max(0, card.ability.extra.rounds_left - 1)
            if card.ability.extra.rounds_left <= 0 then
                card.ability.perma_debuff = true
            end
        end
    end
}