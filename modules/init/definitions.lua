SMODS.Rarity {
    key = "shattered",
    loc_txt = {name = "Shattered"},
    badge_colour = HEX("673E79")
}

SMODS.Rarity {
    key = "boss",
    loc_txt = {name = "Boss"},
    badge_colour = HEX("EFC03C"),
	pools = { ["Joker"] = { rate = 0.02 } },
    default_weight = 0.02
}

SMODS.ConsumableType {
    key = 'Ephemeral',
    shader = 'spectral',
    primary_colour = HEX('59778c'),
    secondary_colour = HEX('8ea4b3'),
    collection_rows = { 5, 5 },
    default = 'c_gb_sculpture',
    shop_rate = 1,
    cards = {
        ['c_gb_chain'] = true,
		['c_gb_collapse'] = true,
		['c_gb_comet'] = true,
		['c_gb_diffusion'] = true,
		['c_gb_gold_dust'] = true,
		['c_gb_group'] = true,
		['c_gb_harlequin'] = true,
		['c_gb_hourglass'] = true,
		['c_gb_incense'] = true,
		['c_gb_magic'] = true,
		['c_gb_mirage'] = true,
		['c_gb_motley'] = true,
		['c_gb_plasma'] = true,
		['c_gb_portal'] = true,
		['c_gb_rust'] = true,
		['c_gb_sculpture'] = true,
		['c_gb_spark'] = true,
		['c_gb_spirit'] = true,
		['c_gb_vanish'] = true,
		['c_gb_wish'] = true,
        },
    loc_txt = {
        name = "Ephemeral",
        collection = "Ephemeral Cards",
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
                }
            }
        },
    }

SMODS.UndiscoveredSprite {
    key = 'Ephemeral',
    atlas = 'Consumables',
    pos = { x = 3, y = 2 },
}

SMODS.DrawStep {
    key = "Ephemeral",
    order = 0,
    func = function(card, layer)
        if card.ability.set == 'Ephemeral'
        and (layer == 'card' or layer == 'both')
        and card.sprite_facing == 'front'
        and (card.config.center.discovered or card.bypass_discovery_center) then
            card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
        end
    end
}

GB.G.SHATTERED_TABLE = {
	{"j_obelisk", "j_gb_monolith"},
	{"j_flower_pot", "j_gb_ornate_vase"},
	{"j_rough_gem", "j_gb_cosmic_diamond"},
	{"j_splash", "j_gb_purple_rain"},
    {"j_gb_polariser", "j_gb_supercharger"},
    {"j_joker", "j_gb_jimbo"},
	{"j_invisible", "j_gb_pure_essence"},
	{"j_fibonnaci", "j_gb_golden_ratio"},
	{"j_scary_face", "j_gb_melting_face"},
	{"j_smiley_face", "j_gb_melting_face"},
	{"j_loyalty_card", "j_gb_phase_charts"},
	{"j_gb_torchlight", "j_gb_lighthouse"},
	{"j_hallucination", "j_gb_divination"},
	{"j_gb_bait", "j_gb_lure"},
	-- {"j_gb_lobster_claw", "j_gb_toy_fish"},
	-- {"j_castle", "j_gb_crumbling_castle"},
	-- {"j_dusk", "j_gb_midnight"},
	-- {"j_acrobat", "j_gb_midnight"},
	-- {"j_raised_fist", "j_gb_revolution"},
	-- {"j_misprint", "j_gb_memory_leak"},
	-- {"j_shortcut", "j_gb_metro_lines},
	-- {"j_space_joker", "j_gb_parasite"},
	-- {"j_idol", "j_gb_alien_relic"},
	-- {"j_ancient_joker", "j_gb_alien_relic"},
	-- {"j_greedy_joker", "j_gb_sin"},
	-- {"j_wrathful_joker", "j_gb_sin"},
	-- {"j_lusty_joker", "j_gb_sin"},
	-- {"j_gluttenous_joker", "j_gb_sin"},
}

SMODS.current_mod.set_ability_reset_keys = function() return
{
	"discarded_this_ante",
	"honey_drawn"
} 
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_gb_goad_card()
	reset_gb_head_card()
	reset_gb_club_card()
	reset_gb_window_card()
end

-- atlas definitions

SMODS.Atlas({
    key = 'gb_Blinds',
    path = 'Blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Atlas {
	key = "gb_Boosters",
	path = "Boosters.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_Cards",
	path = "Cards.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_Consumables",
	path = "Consumables.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_Ephemerals",
	path = "Ephemerals.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_Enhancements",
	path = "Enhancements.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_Jokers",
	path = "Jokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_ShatteredJokers",
	path = "ShatteredJokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_BossJokers",
	path = "BossJokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas({
	key = "gb_modicon",
	path = "icon.png",
	px = 34,
	py = 34,
})