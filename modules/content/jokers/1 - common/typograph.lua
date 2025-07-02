SMODS.Joker {
    key = 'typograph',
    loc_txt = {
        name = 'Typograph',
        text = {
            "{C:mult}+#1#{} Mult for every letter",
            "in the rightmost Joker's name",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
        }
    },
    config = { extra = { mult = 1 } },
    rarity = 1,
    atlas = 'gb_Jokers',
    pos = { x = 2, y = 1 },
    cost = 4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local letter_count = 0
        if G.jokers and G.jokers.cards[#G.jokers.cards] then
            local joker_name = G.localization.descriptions.Joker[G.jokers.cards[#G.jokers.cards].config.center.key].name
            if joker_name then
                for i = 1, #joker_name do
                    local c = joker_name:sub(i,i)
                    if c ~= " " then
                        letter_count = letter_count + 1
                    end
                end
            end
        end
        return { vars = { card.ability.extra.mult, letter_count * card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local letter_count = 0
            if G.jokers and G.jokers.cards[#G.jokers.cards] then
                local joker_name = G.localization.descriptions.Joker[G.jokers.cards[#G.jokers.cards].config.center.key].name
                if joker_name then
                    for i = 1, #joker_name do
                        local c = joker_name:sub(i,i)
                        if c ~= " " then
                            letter_count = letter_count + 1
                        end
                    end
                end
            end
            return {
                mult = letter_count * card.ability.extra.mult
            }
        end
    end
}