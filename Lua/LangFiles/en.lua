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
lang_files["Args_Smite_smite"] = "Smite to do. Type \".smite help\" to get list of smites"
lang_files["Args_Smite_client"] = "Who will suffer. Leave empty to smite yourself"

---- Errors
lang_files["Error_NotEnoughPermissions"] = "You don't have permission for this command"
lang_files["Error_TooLongMessage"] = "Message is too big!"
lang_files["Error_NotEnoughArguments"] = "Not Enough Arguments"
lang_files["Error_BadArgument"] = "Bad Argument {1}"
lang_files["Error_PlayerNotFound"] = "Player not found"
lang_files["Error_ItemNotFound"] = "Player not found"
lang_files["Error_bad_id"] = "Given ID is not a number"
lang_files["Error_NoControlledChar"] = "Player doesn't have character under control"

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

-- SaveData
lang_files["CMD_SaveData_init"] = "Saving GM-Tools data..."
lang_files["CMD_SaveData_end"] = "Saved GM-Tools data!"

-- ReloadConfig
lang_files["CMD_ReloadConfig_init"] = "Reloading config..."
lang_files["CMD_ReloadConfig_end"] = "Config reloaded!"

-- DeadMsg
lang_files["CMD_DeadMsg_cantspeak"] = "You character already can't speak or dead. Just use chat normally"
lang_files["CMD_DeadMsg_inround"] = "This command work only in round"

-- SeeGhostChat
lang_files["CMD_SeeGhostChat_alive"] = "Alive"
lang_files["CMD_SeeGhostChat_forced"] = "Forced GhostChat"

-- Help
lang_files["CMD_Help_desc"] = "Description"
lang_files["CMD_Help_args"] = "Arguments"
lang_files["CMD_Help_unknown"] = "Unknown command \"{1}\"!"
lang_files["CMD_Help_list"] = "Help"
lang_files["CMD_Help_chatlist"] = "Chat Help"

lang_files["CMD_Help_help"] = "Help"
lang_files["CMD_Help_line"] = "* This server runned with mod \"GM-Tools\"\n* Type \".help all\" if you want get all command list\n* Or type \".help all chat\" to get list of chat commands."
lang_files["CMD_Help_gmt"] = "Game Master Tools"

-- Near Items
lang_files["CMD_NearItems_badrange"] = "Given size is not a number"
lang_files["CMD_NearItems_badwires"] = "Wrong value in second argument"
lang_files["CMD_NearItems_nearitems"] = "Items near cursor (Range: {1})"
lang_files["CMD_NearItems_unknown"] = "Unknown"
lang_files["CMD_NearItems_item"] = "* Item: \'{1}\' ID {2} ({3}%)"
lang_files["CMD_NearItems_contained_item"] = "* {1} Item(s) in container with ID {2} ({3})"

-- DeleteItem
lang_files["CMD_DeteteItem_deleted"] = "Succesfully deleted item '{1}' with ID {2}"

-- ItemData
lang_files["CMD_ItemData_header"] = "Item [ID: {1}] \"{2}\" data:"
lang_files["CMD_ItemData_main_condition"] = "* Condition: {1}%"
lang_files["CMD_ItemData_main_tags"] = "* \"Tags: {1}\""
lang_files["CMD_ItemData_main_has_inv"] = "* Has own inventory  -  Use \".item {1} see_inv\" to check"
lang_files["CMD_ItemData_main_contained"] = "* Parent Inventory: {1} [ID: {2}]"

lang_files["CMD_ItemData_condition"] = "Item \"{1}\" [ID: {2}] condition is {3}%"

lang_files["CMD_ItemData_tags"] = "Item [ID: {1}] \"{2}\" tags:"
lang_files["CMD_ItemData_rawtags"] = "Raw: \"{1}\""
lang_files["CMD_ItemData_onetag"] = "* {1}. \"{2}\""

lang_files["CMD_ItemData_UnknownInput"] = "Unknown parameter at argument #2"

-- Ping
lang_files["CMD_Ping_pong"] = "Pong!"

-- ClientList
lang_files["CMD_ClientList_header"] = "Client list:"
lang_files["CMD_ClientList_client"] = "* Name: {1}, ID: {2}, Character: {3}, SteamID: {4}"

-- Smite
lang_files["CMD_Smite_gib"] = "Kills players in a bloody epic way :sunglasses:"
lang_files["CMD_Smite_gigacancer"] = "Gives player giant radiation sickness"
lang_files["CMD_Smite_drunk"] = "Makes player drunk"
lang_files["CMD_Smite_orangeboy"] = "Turns player in orangeboy"
lang_files["CMD_Smite_longstun"] = "Stuns player for 30 seconds"
lang_files["CMD_Smite_help"] = "Gives list of smites"

lang_files["CMD_Smite_SmiteList"] = "Smite List:"

lang_files["CMD_Smite_Unknown"] = "Unknown smite"

-- Jobban & Unjobban
lang_files["CMD_Jobban_BanLowest"] = "You can't job-ban the lowest job"
lang_files["CMD_Jobban_UnknownJob"] = "Unknown job"
lang_files["CMD_Jobban_NoReason"] = "No reason"
lang_files["CMD_Jobban_ConsoleOut"] = "Job-banned \"{1}\" for \"{2}\".\nReason: {3}\nDuration: {4}"

lang_files["CMD_UnJobban_All"] = "Removed all job-bans from player {1}"
lang_files["CMD_UnJobban_Job"] = "Removed job-ban on \"{1}\" for {2}"
lang_files["CMD_UnJobban_NoBan"] = "Player didn't had job-ban on this job"

lang_files["CMD_Jobban_Box"] = "You have been job-banned!\n\nJob: \"{1}\"\nExpires in: {2}\nReason: \"{3}\"\n"

return lang_files