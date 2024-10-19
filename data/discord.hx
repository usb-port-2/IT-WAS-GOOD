import funkin.backend.utils.DiscordUtil;

function onGameOver() {
	DiscordUtil.changePresence('Game Over', "");
}

function onDiscordPresenceUpdate(e) {
	var data = e.presence;

	if(data.largeImageText == null)
		data.largeImageText = "Balls";
}

function onPlayStateUpdate() {
	DiscordUtil.changeSongPresence(
		"",
		(PlayState.instance.paused ? "Paused: " : "Playing: ") + PlayState.SONG.meta.displayName.toUpperCase(),
		PlayState.instance.inst.length,
		PlayState.instance.getIconRPC()
	);
}

function onMenuLoaded(name:String) {
	DiscordUtil.changePresenceSince("", null);
}