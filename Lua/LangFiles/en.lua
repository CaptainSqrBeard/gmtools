local lang_files = {}

---- Commands description
lang_files["Help_Help"] = "Sends information about commands."
lang_files["Help_AdminChat"] = "Sends message in admin chat."
lang_files["Help_AdminPM"] = "Sends private message to player"
lang_files["Help_AHelp"] = "Sends private message to admins"
lang_files["Help_ToggleAHelp"] = "Disables/enables .ahelp"
lang_files["Help_SaveData"] = "Saves GM-Tools data"
lang_files["Help_ReloadConfig"] = "Reloads GM-Tools config."
lang_files["Help_SeeGhostChat"] = "Make you see messages from dead, even if you not a ghost"
lang_files["Help_DeadMsg"] = "Sends message in ghost chat"
lang_files["Help_NearItems"] = "Shows information about all items around cursor"
lang_files["Help_DeleteItem"] = "Deletes items and everything inside it"
lang_files["Help_ItemData"] = "Outputs item data (Condition, Tags, etc.)"
lang_files["Help_Jobban"] = "Bans job for player, so he can't play on it"
lang_files["Help_UnJobban"] = "Un-Bans job for player"
lang_files["Help_Cls"] = "Clears console"
lang_files["Help_Ping"] = "Pong!"
lang_files["Help_List"] = "Sends list of players on server"
lang_files["Help_Smite"] = "We do a little trolling (Doing funi things with players)"


---- Commands arguments description
-- AdminChat
lang_files["Args_AdminChat_msg"] = "Message to send"

-- AdminPM
lang_files["Args_AdminPM_target"] = "Who will get private message"
lang_files["Args_AdminPM_msg"] = "Private message to send"

-- AHelp
lang_files["Args_AHelp_msg"] = "Message to admins"

-- ToggleAHelp
lang_files["Args_ToggleAHelp_status"] = "Can be true (only enable), false (only disable) or switch (switch between on/off)"

-- SeeGhostChat
lang_files["Args_SeeGhostChat_status"] = "Can be true (only enable), false (only disable) or switch (switch between on/off)"
lang_files["Args_SeeGhostChat_target"] = "Player to toggle this abillity. Leave empty to apply it yourself"

-- DeadMsg
lang_files["Args_DeadMsg_msg"] = "A message to send in ghost chat"

-- Help
lang_files["Args_Help_command"] = "Input name of command to get more info about it, or type 'all' to get command list"

-- NearItems
lang_files["Args_NearItems_size"] = "Searching range, shaped as rectangle. Default: 100"
lang_files["Args_NearItems_ignorewires"] = "If true, command will ignore wires on walls. If false, it will not. Default: true"

-- DeleteItem
lang_files["Args_DeleteItem_id"] = "ID of item to delete"

-- ItemData
lang_files["Args_ItemData_id"] = "ID of item"
lang_files["Args_ItemData_data"] = "Data"

-- Jobban
lang_files["Args_Jobban_player"] = "Name/ID/SteamID of player"
lang_files["Args_Jobban_job"] = "Job that will be banned for this player"
lang_files["Args_Jobban_duration"] = "Duration of job-ban. Leave empty to permanent ban (ex. \"6d 23h 59m 59s\")"
lang_files["Args_Jobban_reason"] = "Reason, why player has been job-banned."

-- UnJobban
lang_files["Args_UnJobban_player"] = "Name/ID/SteamID of player"
lang_files["Args_UnJobban_job"] = "Job that will be unbanned for this player. Leave empty to unban all jobs"

-- Smite
lang_files["Args_Smite_smite"] = "Smite to do. Type \"help\" here to get list of smites"
lang_files["Args_Smite_client"] = "Who will suffer. Leave empty to smite yourself"

---- Errors
lang_files["Error_NotEnoughPermissions"] = "You don't have permission for this command"
lang_files["Error_TooLongMessage"] = "Message is too big!"
lang_files["Error_NotEnoughArguments"] = "Not Enough Arguments"
lang_files["Error_BadArgument"] = "Bad Argument {1}"
lang_files["Error_PlayerNotFound"] = "Player not found"

---- Command output
-- AdminPM & AHelp
lang_files["CMD_AdminPM_from"] = "from"
lang_files["CMD_AdminPM_to"] = "to"
lang_files["CMD_AdminPM_you"] = "You"
lang_files["CMD_AdminPM_include_you"] = "Include you"
lang_files["CMD_AdminPM_admins"] = "Admins"
lang_files["CMD_AdminPM_pm"] = "Private Message"
lang_files["CMD_AdminPM_note"] = "For anwser type \".ahelp <msg>\" in console or chat"
lang_files["CMD_AdminPM_disabled"] = "AHelp is currently disabled"

return lang_files