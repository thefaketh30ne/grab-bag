SMODS.Rarity {
    key = "shattered",
    loc_txt = {name = "Shattered"},
    badge_colour = HEX("834896")
}

SMODS.Rarity {
    key = "boss",
    loc_txt = {name = "Boss"},
    badge_colour = HEX("EFC03C"),
	pools = { ["Joker"] = { rate = 0.02 } },
    default_weight = 0.02,
	get_weight = function(self, weight, object_type)
		if G.GAME.GB_DEFEATED_BLINDS and G.GAME.GB_DEFEATED_BLIND_COUNT >= 1 then
			return 0.02
		else
			return 0
		end
	end
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
    }
}

SMODS.ConsumableType {
    key = 'Hex',
    shader = 'spectral',
    primary_colour = HEX('4f5767'),
    secondary_colour = HEX('807ead'),
    collection_rows = { 7, 6 },
    default = 'c_gb_nihilism',
	shop_rate = 0.5,
    cards = {
        ['c_gb_apparition'] = true,
		['c_gb_conceit'] = true,
		['c_gb_nihilism'] = true,
		['c_gb_pestilence'] = true,
		['c_gb_tyranny'] = true,
		['c_gb_war'] = true,
        },
    loc_txt = {
        name = "Hex",
        collection = "Hex Cards",
        undiscovered = {
            name = "Not Discovered",
            text = {
                "Purchase or use",
                "this card in an",
                "unseeded run to",
                "learn what it does"
            }
        }
    }
}

SMODS.Suit {
	key = 'Eyes',
	card_key = 'EYES',

	lc_atlas = 'gb_Suits',
	lc_ui_atlas = 'gb_SuitUI',
	lc_colour = HEX("673E79"),

	hc_atlas = 'gb_Suits_HC',
	hc_ui_atlas = 'gb_SuitUI_HC',
	hc_colour = HEX("9448A4"),

	pos = { y = 0 },
	ui_pos = { x = 0, y = 0 },

	in_pool = function(self, args)
		return gb_is_suit_in_deck("gb_Eyes")
	end
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

GB_SHATTERED_TABLE = {}
GB_SHATTERED_TABLE["j_obelisk"] = "j_gb_monolith"
GB_SHATTERED_TABLE["j_flower_pot"] = "j_gb_ornate_vase"
GB_SHATTERED_TABLE["j_rough_gem"] = "j_gb_cosmic_diamond"
GB_SHATTERED_TABLE["j_splash"] = "j_gb_purple_rain"
GB_SHATTERED_TABLE["j_gb_polariser"] = "j_gb_supercharger"
GB_SHATTERED_TABLE["j_joker"] = "j_gb_jimbo"
GB_SHATTERED_TABLE["j_invisible"] = "j_gb_pure_essence"
GB_SHATTERED_TABLE["j_fibonnaci"] = "j_gb_golden_ratio"
GB_SHATTERED_TABLE["j_scary_face"] = "j_gb_melting_face"
GB_SHATTERED_TABLE["j_smiley"] = "j_gb_melting_face"
GB_SHATTERED_TABLE["j_loyalty_card"] = "j_gb_phase_charts"
GB_SHATTERED_TABLE["j_gb_torchlight"] = "j_gb_lighthouse"
GB_SHATTERED_TABLE["j_hallucination"] = "j_gb_divination"
GB_SHATTERED_TABLE["j_gb_bait"] = "j_gb_lure"
GB_SHATTERED_TABLE["j_clever_joker"] = "j_gb_the_clever"
GB_SHATTERED_TABLE["j_crafty_joker"] = "j_gb_the_crafty"
GB_SHATTERED_TABLE["j_devious_joker"] = "j_gb_the_devious"
GB_SHATTERED_TABLE["j_sly_joker"] = "j_gb_the_sly"
GB_SHATTERED_TABLE["j_wily_joker"] = "j_gb_the_wily"
GB_SHATTERED_TABLE["j_crazy_joker"] = "j_gb_the_crazy"
GB_SHATTERED_TABLE["j_droll_joker"] = "j_gb_the_droll"
GB_SHATTERED_TABLE["j_jolly_joker"] = "j_gb_the_jolly"
GB_SHATTERED_TABLE["j_mad_joker"] = "j_gb_the_mad"
GB_SHATTERED_TABLE["j_zany_joker"] = "j_gb_the_zany"
	-- {"j_dusk", "j_gb_midnight"},
	-- {"j_acrobat", "j_gb_midnight"},
	-- {"j_raised_fist", "j_gb_revolution"},
	-- {"j_shortcut", "j_gb_metro_lines},
	-- {"j_space_joker", "j_gb_parasite"},
	-- {"j_idol", "j_gb_alien_relic"},
	-- {"j_ancient_joker", "j_gb_alien_relic"},
	-- {"j_greedy_joker", "j_gb_sin"},
	-- {"j_wrathful_joker", "j_gb_sin"},
	-- {"j_lusty_joker", "j_gb_sin"},
	-- {"j_gluttenous_joker", "j_gb_sin"},
	-- {"j_gb_lobster_claw", "j_gb_toy_fish"},
	-- {"j_castle", "j_gb_crumbling_castle"},

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
	reset_gb_black_book_rank()
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
	key = "gb_Consumables",
	path = "Consumables.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "gb_Decks",
	path = "Decks.png",
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
	key = "gb_Seals",
	path = "Seals.png",
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

SMODS.Atlas({
	key = "gb_SuitUI",
	path = "Suit_UI.png",
	px = 18,
	py = 18,
})

SMODS.Atlas({
	key = "gb_SuitUI_HC",
	path = "Suit_UI_HC.png",
	px = 18,
	py = 18,
})

SMODS.Atlas({
	key = "gb_Suits",
	path = "Suits.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "gb_Suits_HC",
	path = "Suits_HC.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "gb_HexCards",
	path = "HexCards.png",
	px = 71,
	py = 95,
})

SMODS.Atlas({
	key = "gb_Hexes",
	path = "Hexes.png",
	px = 71,
	py = 95,
})