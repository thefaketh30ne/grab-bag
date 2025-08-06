SMODS.Joker {
    key = 'double_gulp',
    loc_txt = {
        name = 'Double Gulp',
        text = {
            "Creates {C:attention}#2#{} copies of",
            "the next {C:attention}#1#{} cards destroyed",
        }
    },
    config = { extra = { copies = 2, cards_left = 5 } },
    rarity = 2,
    atlas = 'gb_Jokers',
    pos = { x = 8, y = 2 },
    cost = 5,
    blueprint_compat = false,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards_left, card.ability.extra.copies } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for _, removed_card in ipairs(context.removed) do
                card.ability.extra.cards_left = card.ability.extra.cards_left - 1
                for i = 1, card.ability.extra.copies do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(removed_card, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                end
                if card.ability.extra.cards_left <= 0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    card:remove()
                                    return true
                                end
                            }))
                        return true
                    end
                }))
                    return {
                        message = 'Drank!',
                        colour = G.C.FILTER
                    }
                end
            end
            return {
                message = card.ability.extra.cards_left .. '',
                colour = G.C.FILTER
            }
        end
    end
}