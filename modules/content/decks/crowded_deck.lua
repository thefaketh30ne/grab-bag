SMODS.Back {
    key = "crowded",
    atlas = "gb_Decks",
    pos = { x = 7, y = 0 },
    loc_txt = {
        name = "Crowded Deck",
        text = {
            "{C:attention}3{} random {C:attention}numbered{} ranks",
            "are converted to {C:attention}face{} cards",
            "Start with {C:blue,T:v_magic_trick}Magic Trick",
            "and {C:attention,T:v_overstock_norm}Overstock"
        },
    },
    config = { vouchers = {"v_magic_trick", "v_overstock_norm"} },
    apply = function(self, back)
        local valid_ranks = {}
        for i = 2, 10 do
            table.insert(valid_ranks, i)
        end
        pseudorandom('gb_crowded', 2, 10)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, suit in ipairs({"Jack", "Queen", "King"}) do
                    local chosen_rank = pseudorandom_element(valid_ranks, pseudoseed('gb_crowded'))
                    table.remove(valid_ranks, chosen_rank - 1)
                    for _, playing_card in ipairs(G.playing_cards) do
                        if playing_card:get_id() == chosen_rank then
                            assert(SMODS.change_base(playing_card, nil, suit))
                        end
                    end
                end
                return true
            end
        }))
    end
}