music_pitch = 1

SMODS.Sound({
    vol = 0.45,
    pitch = music_pitch,
    key = "gb_music1",
    path = "gb_music1.ogg",
    select_music_track = function()
        return (gb_config.custom_music) and 10 or false
    end,
})

SMODS.Sound({
    vol = 0.45,
    pitch = music_pitch,
    key = "gb_music2",
    path = "gb_music2.ogg",
    select_music_track = function()
        return (gb_config.custom_music and G.booster_pack_sparkles and not G.booster_pack_sparkles.REMOVED) and 11 or false
    end,
})

SMODS.Sound({
    vol = 0.45,
    pitch = music_pitch,
    key = "gb_music3",
    path = "gb_music3.ogg",
    select_music_track = function()
        return (gb_config.custom_music and G.booster_pack_meteors and not G.booster_pack_meteors.REMOVED) and 11 or false
    end,
})

SMODS.Sound({
    vol = 0.45,
    pitch = music_pitch,
    key = "gb_music4",
    path = "gb_music4.ogg",
    select_music_track = function()
        return (gb_config.custom_music and G.shop and not G.shop.REMOVED) and 11 or false
    end,
})

SMODS.Sound({
    vol = 0.45,
    pitch = music_pitch,
    key = "gb_music5",
    path = "gb_music5.ogg",
    select_music_track = function()
        return (gb_config.custom_music and G.GAME.blind and G.GAME.blind.boss) and 11 or false
    end,
})

G.FUNCS.change_music = function(args)
	G.ARGS.music_vals = G.ARGS.music_vals or { "GrabBag", "balatro" }
	G.SETTINGS.QUEUED_CHANGE.music_change = G.ARGS.music_vals[args.to_key]
	G.SETTINGS.music_selection = G.ARGS.music_vals[args.to_key]
end