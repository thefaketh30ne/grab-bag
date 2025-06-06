SMODS.Back {
    key = "negative",
    atlas = "gb_Cards",
    pos = { x = 4, y = 0 },
    loc_txt = {
        name = "Negative Deck",
        text = {
            "After defeating each",
            "{C:attention}Boss Blind{}, gain a",
            "{C:attention,T:tag_negative}#1#",
            "{C:red}#2#{} Joker slots",
        },
    },
    config = { extra = { joker_slot = -2 } },
    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = 'tag_negative', set = 'Tag' }, self.config.extra.joker_slot }}
    end,
    apply = function(self, back)
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.extra.joker_slot
    end,
    calculate = function(self, back, context)
        if context.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_negative'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end
}

SMODS.DrawStep({
    key = "negative_deck",
    order = 5,
    func = function(self)
        if self.area and self.area.config and self.area.config.type == "deck" then
            -- following here is a horrendous mod compatability line
            local currentBack = not self.params.galdur_selector
                    and ((Galdur and Galdur.config.use and type(self.params.galdur_back) == "table" and self.params.galdur_back) or type(
                        self.params.viewed_back
                    ) == "table" and self.params.viewed_back or (self.params.viewed_back and G.GAME.viewed_back or G.GAME.selected_back))
                or Back(G.P_CENTERS["b_red"])
            if currentBack.effect.center.key == 'b_gb_negative' then
                self.children.back:draw_shader(
                    'negative',
                    nil,
                    self.ARGS.send_to_shader,
                    true
                )
                self.children.back:draw_shader(
                    'negative_shine',
                    nil,
                    self.ARGS.send_to_shader,
                    true
                )
            end
        end
    end
})