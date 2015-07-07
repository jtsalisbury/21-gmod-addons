report = {};

report.ReportCoolDown = 30 //minutes; how many a player must way before reporting again
report.Refresh = 30 //in seconds
report.GeneralReasons = { //reason that are general.
	"Random Death Match",
	"Hurting me :(",
	"Being a general asshat",
	"Scrub"
}
report.AdminGroups = { //put other non-admin groups here that should have access to the admin menu.
	"admin",
	"moderator"
}
report.SuperAdminGroups = { //put other non-super-admin groups here that should be able to delete reports.
	"superadmin",
	"owner",
	"server_director"
}

report.BracketColor = Color(0, 0, 0, 255); //color of the brackets in a chat message.
report.ReportTextColor = Color(255, 25, 25, 255); //color of the "Reports" text in a chat message.
report.MsgColor = Color(255, 255, 255, 255); //general text color of a message.

report.ChatCommand = "!report"
report.AdminChatCommand = "!reporta"

report.Version = "7-13-14"; //don't edit this.