SMODS.Back {
    key = "airline",
    atlas = "gb_Decks",
    pos = { x = 2, y = 1 },
    loc_txt = {
        name = "Airline Deck",
        text = {
            "{C:attention}Big Blinds{} do not appear",
            "Start with an extra {C:money}$#1#{},",
            "{T:v_reroll_surplus,C:green}Reroll Surplus{} and {T:v_seed_money,C:money}Seed Money{}"
        },
    },
    config = { vouchers = {"v_reroll_surplus", "v_seed_money"}, dollars = 10 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.dollars } }
    end,
    apply = function(self, back)
        G.GAME.round_resets.blind_states.Big = "Hide"
    end
}