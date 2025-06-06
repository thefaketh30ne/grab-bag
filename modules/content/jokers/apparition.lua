SMODS.Joker {
    key = "apparition",
    loc_txt = {
                name = 'Apparition',
                text = {
                    "After {C:attention}#1#{} rounds,",
                    "sell this card to {C:attention}create{}",
                    "a random {C:dark_edition}Negative{} Joker",
                    "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)",
                }
            },
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 3,
    cost = 8,
    atlas = 'gb_Jokers',
    pos = { x = 6, y = 2 },
    config = { extra = { hand_tally = 0, total_hands = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.total_hands, card.ability.extra.hand_tally }}
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.hand_tally >= card.ability.extra.total_hands) and not context.blueprint then
            SMODS.add_card {
                set = 'Joker',
                key_append = 'vremade_riff_raff',
                edition = "e_negative",
            }
        end
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.hand_tally = card.ability.extra.hand_tally + 1
            if card.ability.extra.hand_tally == card.ability.extra.total_hands then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.hand_tally < card.ability.extra.total_hands) and
                    (card.ability.extra.hand_tally .. '/' .. card.ability.extra.total_hands) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end
}