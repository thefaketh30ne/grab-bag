SMODS.Back {
    key = "memphis",
    loc_txt = {
        name = "Memphis Deck",
        text = {
            "Create an additional random {C:attention}Tag{}",
            "when a {C:attention}Blind{} is skipped"
        }
    },
    atlas = "gb_Decks",
    pos = { x = 3, y = 0 },
    calculate = function(self, back, context)
        if context.skip_blind then
            local tag_pool = get_current_pool('Tag')
            local selected_tag = pseudorandom_element(tag_pool, pseudoseed('ortalab_hoarder'))
            local it = 1
            while selected_tag == 'UNAVAILABLE' do
                it = it + 1
                selected_tag = pseudorandom_element(tag_pool, pseudoseed('ortalab_hoarder_resample' .. it))
            end
            add_tag(Tag(selected_tag, false, 'Small'))
        end
    end
}  
