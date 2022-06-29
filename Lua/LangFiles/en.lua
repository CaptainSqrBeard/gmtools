local lang_files = {}

---- Commands description
lang_files["Help_Help"] = "Sends information about commands."
lang_files["Help_AdminChat"] = "Sends message in admin chat."
lang_files["Help_AdminPM"] = "Sends private message to specified player"
lang_files["Help_AHelp"] = "Sends private message to admins"
lang_files["Help_ToggleAHelp"] = "Disables/enables .ahelp"
lang_files["Help_SaveData"] = "Saves GM-Tools data"
lang_files["Help_ReloadConfig"] = "Reloads GM-Tools config."
lang_files["Help_SeeGhostChat"] = "Make you see messages from dead, even if you not a ghost"
lang_files["Help_DeadMsg"] = "Sends message in ghost chat"
lang_files["Help_NearItems"] = "Shows information about all items around cursor"
lang_files["Help_DeleteItem"] = "Deletes items and everything inside it"
lang_files["Help_ItemData"] = "Outputs item data (Condition, Tags, etc.)"
lang_files["Help_ItemEdit"] = "Edit values of component"
lang_files["Help_Jobban"] = "Bans job for player, so he can't play on it"
lang_files["Help_UnJobban"] = "Un-Bans job for player"
lang_files["Help_Cls"] = "Clears console"
lang_files["Help_Ping"] = "Pong!"
lang_files["Help_List"] = "Sends list of players on server"
lang_files["Help_Smite"] = "We do a little trolling (Doing funi things with players)"
lang_files["Help_Lang"] = "Globally changes language of mod to specified one"


---- Commands arguments description
-- AdminChat
lang_files["Args_AdminChat_msg"] = "Message to send"

-- AdminPM
lang_files["Args_AdminPM_target"] = "Who will get private message"
lang_files["Args_AdminPM_msg"] = "Private message to send"

-- AHelp
lang_files["Args_AHelp_msg"] = "Message to admins"

-- ToggleAHelp
lang_files["Args_ToggleAHelp_status"] = "Can be 'true' (only enable), 'false' (only disable) or 'switch' (switch between on/off)"

-- SeeGhostChat
lang_files["Args_SeeGhostChat_status"] = "Can be 'true' (only enable), 'false' (only disable) or 'switch' (switch between on/off)"
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

-- ItemEdit
lang_files["Args_ItemEdit_id"] = "ID of item"
lang_files["Args_ItemEdit_component"] = "Name of component or position in list. Leave empty to get list of components"
lang_files["Args_ItemEdit_action"] = "Action to do with this component. Leave empty to get list of actions"
lang_files["Args_ItemEdit_args"] = "Parameters for action"

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

-- Lang
lang_files["Args_Lang_language"] = "Language to change. Use \".lang all\" to get list of languages"

---- Errors
lang_files["Error_NotEnoughPermissions"] = "You don't have permission for this command"
lang_files["Error_TooLongMessage"] = "Message is too big!"
lang_files["Error_NotEnoughArguments"] = "Not Enough Arguments"
lang_files["Error_BadArgument"] = "Bad Argument {1}"
lang_files["Error_PlayerNotFound"] = "Player not found"
lang_files["Error_CharacterNotFound"] = "Character not found"
lang_files["Error_ItemNotFound"] = "Item not found"
lang_files["Error_bad_id"] = "Given ID is not a number"
lang_files["Error_bad_value"] = "Given value is not a number"
lang_files["Error_NoControlledChar"] = "Player doesn't have character under control"
lang_files["Error_bad_boolean"] = "Bad argument. Parameter #1 must be \"true\" or \"false\" or empty"

---- Command output
-- AdminPM & AHelp
lang_files["CMD_AdminPM_con_to_other_L1"] = "ADMINPM {1} --> {2}"
lang_files["CMD_AdminPM_con_to_other_L2"] = "   Private message: \"{1}\""

lang_files["CMD_AdminPM_con_for_admin_L1"] = "ADMINPM {1} (You) --> {2}"
lang_files["CMD_AdminPM_con_for_admin_L2"] = "   Private message: \"{1}\""

lang_files["CMD_AdminPM_con_for_player_L1"] = "ADMINPM {1} --> {2} (You)"
lang_files["CMD_AdminPM_con_for_player_L2"] = "   Private message: {1}"
lang_files["CMD_AdminPM_con_for_player_L3"] = "For anwser type \".ahelp <msg>\" in console or chat"
lang_files["CMD_AdminPM_msg_for_player_name"] = "ADMIN PM from {1}"
lang_files["CMD_AdminPM_msg_for_player_text"] = "\n‖metadata:{1}‖{2}‖end‖ --> ‖metadata:{3}‖{4} (You)‖end‖\n   ‖color:#fcf0f0‖Private message: \"{5}\"‖end‖\n‖color:#8a8a8a‖For anwser type \".ahelp <msg>\" in console or chat‖end‖"

--‖color:#ffffff;metadata:1234‖my name is Joe‖end‖
lang_files["CMD_AHelp_con_for_admin_L1"] = "AHELP {1} --> ADMINS (Include you)"
lang_files["CMD_AHelp_con_for_admin_L2"] = "   Private message: {1}"
lang_files["CMD_AHelp_con_for_admin_L3"] = "For anwser type \".adminpm {1} <msg>\" in console"
lang_files["CMD_AHelp_msg_for_admin_name"] = "ADMIN HELP"
lang_files["CMD_AHelp_msg_for_admin_text"] = "\nFrom ‖metadata:{1}‖{2}‖end‖ to ‖color:#e1a1a3‖ADMINS (Include you)‖end‖\n   ‖color:#fcf0f0‖Private message: \"{3}\"‖end‖\n‖color:#8a8a8a‖For anwser type \".adminpm {4} <msg>\" in console‖end‖"

lang_files["CMD_AHelp_con_for_player_L1"] = "AHELP {1} (You) --> ADMINS"
lang_files["CMD_AHelp_con_for_player_L2"] = "   Private message: {1}"
lang_files["CMD_AHelp_msg_for_player_name"] = "ADMIN HELP"
lang_files["CMD_AHelp_msg_for_player_text"] = "\nFrom ‖metadata:{1}‖{2} (You)‖end‖ to ‖color:#e1a1a3‖ADMINS‖end‖\n   ‖color:#fcf0f0‖Private message: \"{3}\"‖end‖"

lang_files["CMD_AHelp_disabled"] = "AHelp is currently disabled"
lang_files["CMD_AdminPM_NoMessage"] = "No message provided"


-- ToggleAHelp
lang_files["CMD_ToggleAHelp_enabled"] = ".ahelp now ENABLED"
lang_files["CMD_ToggleAHelp_disabled"] = ".ahelp now DISABLED"
lang_files["CMD_ToggleAHelp_badargument"] = "Bad argument. Argument #1 accepts only these values: 'true', 'false' or 'switch'."


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
lang_files["CMD_NearItems_badwires"] = "Wrong value in second argument. Type 'true' or 'false'"
lang_files["CMD_NearItems_nearitems"] = "Items near cursor (Range: {1})"
lang_files["CMD_NearItems_unknown"] = "Unknown"
lang_files["CMD_NearItems_item"] = "* Item: \'{1}\' ID {2} ({3}%)"
lang_files["CMD_NearItems_contained_item"] = "* {1} Item(s) in container with ID {2} ({3})"

-- DeleteItem
lang_files["CMD_DeteteItem_deleted"] = "Succesfully deleted item '{1}' with ID {2}"

-- ItemData
lang_files["CMD_ItemData_header"] = "Item [ID: {1}] \"{2}\" data:"
lang_files["CMD_ItemData_main_condition"] = "* Condition: {1}%"
lang_files["CMD_ItemData_main_tags"] = "* Tags: \"{1}\""
lang_files["CMD_ItemData_main_has_inv"] = "* Has own inventory  -  Use \".item {1} see_inv\" to check"
lang_files["CMD_ItemData_main_contained"] = "* Contained in inventory: {1} [ID: {2}]"

lang_files["CMD_ItemData_condition"] = "Item \"{1}\" [ID: {2}] condition is {3}%"

lang_files["CMD_ItemData_tags"] = "Item [ID: {1}] \"{2}\" tags:"
lang_files["CMD_ItemData_rawtags"] = "Raw: \"{1}\""
lang_files["CMD_ItemData_onetag"] = "* {1}. \"{2}\""

lang_files["CMD_ItemData_no_inv"] = "Item doesn't have own inventory"
lang_files["CMD_ItemData_inventory"] = "Items in '{1}' [ID {2}]"
lang_files["CMD_ItemData_inv_item"] = "* \"{1}\" ID {2} ({3}%)"

lang_files["CMD_ItemData_UnknownInput"] = "Unknown parameter at argument #2"

-- ItemEdit
lang_files["CMD_ItemEdit_c_header"] = "Components of item \"{1}\" ID {2}"
lang_files["CMD_ItemEdit_c_element"] = "{1}. \"{2}\""
lang_files["CMD_ItemEdit_badindex"] = "Given index is not a value"
lang_files["CMD_ItemEdit_nocomponent"] = "Component not found. Type name of component or position in list"
lang_files["CMD_ItemEdit_noactions"] = "This component doesn't have any actions"
lang_files["CMD_ItemEdit_act_header"] = "Actions of component \"{1}\""
lang_files["CMD_ItemEdit_act_element"] = "* {1}  >  \"{2}\""
lang_files["CMD_ItemEdit_badaction"] = "Unknown action"


lang_files["CMD_ItemEdit_Quality_level_Help"] = "Changes level of item (Small Desync)"
lang_files["CMD_ItemEdit_Quality_level_info"] = "Level of item is {1}/{2}"
lang_files["CMD_ItemEdit_Quality_level_badlevel"] = "Given level is not a number"
lang_files["CMD_ItemEdit_Quality_level_outofrange"] = "Given level is out of range. Use value in range 0-3"
lang_files["CMD_ItemEdit_Quality_level_warn"] = "Desync warning! Clients will see original quality of item"

lang_files["CMD_ItemEdit_Holdable_pick_Help"] = "Makes character pick up item"

lang_files["CMD_ItemEdit_Holdable_attach_Help"] = "Attaches or unattaches items from wall"
lang_files["CMD_ItemEdit_Holdable_attach_unable"] = "Item can't be attached to wall"
lang_files["CMD_ItemEdit_Holdable_attach_attached"] = "Item now attached to wall"
lang_files["CMD_ItemEdit_Holdable_attach_deattached"] = "Item now deattached from wall"

lang_files["CMD_ItemEdit_PowerContainer_power_Help"] = "Changes power inside batteries"
lang_files["CMD_ItemEdit_PowerContainer_power_info"] = "Contained power is {1} kW / {2} kW"
lang_files["CMD_ItemEdit_PowerContainer_power_set"] = "Contained power now is {1} kW/ {2} kW"

lang_files["CMD_ItemEdit_PowerContainer_capacity_Help"] = "Changes batteries capacity (Small Desync)"
lang_files["CMD_ItemEdit_PowerContainer_capacity_info"] = "Max capacity is {1} kW"
lang_files["CMD_ItemEdit_PowerContainer_capacity_set"] = "Max capacity now is {1} kW"
lang_files["CMD_ItemEdit_PowerContainer_capacity_warn"] = "Desync warning! Clients will see original capacity of item"

lang_files["CMD_ItemEdit_PowerContainer_speed_Help"] = "Changes power inside batteries"
lang_files["CMD_ItemEdit_PowerContainer_speed_info"] = "Recharge speed is {1} kW / min"
lang_files["CMD_ItemEdit_PowerContainer_speed_set"] = "Recharge speed now is {1} kW / min"

lang_files["CMD_ItemEdit_PowerTransfer_canoverload_Help"] = "Toggles damage from overload"
lang_files["CMD_ItemEdit_PowerTransfer_canoverload_on"] = "Now item can be overloaded"
lang_files["CMD_ItemEdit_PowerTransfer_canoverload_off"] = "Now item can't be overloaded"

lang_files["CMD_ItemEdit_Engine_force_Help"] = "Changes how hard engine will work"
lang_files["CMD_ItemEdit_Engine_force_info"] = "Current engine force is {1}%"
lang_files["CMD_ItemEdit_Engine_force_set"] = "Now current engine force is {1}%"

lang_files["CMD_ItemEdit_Engine_maxforce_Help"] = "Changes engine max speed"
lang_files["CMD_ItemEdit_Engine_maxforce_info"] = "Engine max force is {1}"
lang_files["CMD_ItemEdit_Engine_maxforce_set"] = "Now engine max force is {1}"

lang_files["CMD_ItemEdit_Deconstructor_speed_Help"] = "Changes speed multiplier (Medium Desync)"
lang_files["CMD_ItemEdit_Deconstructor_speed_info"] = "Deconstructor speed multiplier is x{1}"
lang_files["CMD_ItemEdit_Deconstructor_speed_set"] = "Deconstructor speed multiplier now is x{1}"
lang_files["CMD_ItemEdit_Deconstructor_speed_warn"] = "Desync warning! Clients will see that progress bar fills with original speed"

lang_files["CMD_ItemEdit_Fabricator_skill_Help"] = "Changes required skill multiplier (Medium Desync)"
lang_files["CMD_ItemEdit_Fabricator_skill_info"] = "Fabricator skill multiplier is x{1}"
lang_files["CMD_ItemEdit_Fabricator_skill_set"] = "Fabricator skill multiplier now is x{1}"
lang_files["CMD_ItemEdit_Fabricator_skill_warn"] = "Desync warning! Clients will see that they need original skill to craft (Time while crafting will be synced)"

lang_files["CMD_ItemEdit_OxygenGenerator_produce_Help"] = "Changes oxygen produce"
lang_files["CMD_ItemEdit_OxygenGenerator_produce_info"] = "Oxygen produce is {1}"
lang_files["CMD_ItemEdit_OxygenGenerator_produce_set"] = "Oxygen produce now is {1}"

lang_files["CMD_ItemEdit_Pump_maxflow_Help"] = "Changes pump max flow"
lang_files["CMD_ItemEdit_Pump_maxflow_info"] = "Max flow is {1}"
lang_files["CMD_ItemEdit_Pump_maxflow_set"] = "Max flow now is {1}"
lang_files["CMD_ItemEdit_Pump_maxflow_warn"] = "Desync warning! Clients will see that item will pump with original speed and sometimes pumped hulls will change water level"

lang_files["CMD_ItemEdit_Pump_percentage_Help"] = "Changes how hard pump will work"
lang_files["CMD_ItemEdit_Pump_percentage_info"] = "Flow percentage is {1}%"
lang_files["CMD_ItemEdit_Pump_percentage_set"] = "Flow percentage now is {1}%"

lang_files["CMD_ItemEdit_Reactor_toggle_Help"] = "Toggles reactor"
lang_files["CMD_ItemEdit_Reactor_toggle_on"] = "Reactor is now enabled"
lang_files["CMD_ItemEdit_Reactor_toggle_off"] = "Reactor is now disabled"

lang_files["CMD_ItemEdit_Reactor_maxpower_Help"] = "Changes reactor max power"
lang_files["CMD_ItemEdit_Reactor_maxpower_info"] = "Max power is {1} kW"
lang_files["CMD_ItemEdit_Reactor_maxpower_set"] = "Max power is now {1} kW"

lang_files["CMD_ItemEdit_Reactor_meltdowndelay_Help"] = "Changes reactor meltdown delay"
lang_files["CMD_ItemEdit_Reactor_meltdowndelay_info"] = "Meltdown delay is {1} seconds"
lang_files["CMD_ItemEdit_Reactor_meltdowndelay_set"] = "Meltdown delay is now {1} seconds"

lang_files["CMD_ItemEdit_Reactor_firedelay_Help"] = "Changes reactor fire delay"
lang_files["CMD_ItemEdit_Reactor_firedelay_info"] = "Fire delay is {1} seconds"
lang_files["CMD_ItemEdit_Reactor_firedelay_set"] = "Fire delay is now {1} seconds"

lang_files["CMD_ItemEdit_Reactor_fissionrate_Help"] = "Changes reactor current fission rate"
lang_files["CMD_ItemEdit_Reactor_fissionrate_info"] = "Fission rate is {1}%"
lang_files["CMD_ItemEdit_Reactor_fissionrate_set"] = "Fission rate is now {1}%"

lang_files["CMD_ItemEdit_Reactor_turbineoutput_Help"] = "Changes reactor current turbine output"
lang_files["CMD_ItemEdit_Reactor_turbineoutput_info"] = "Turbine output is {1}%"
lang_files["CMD_ItemEdit_Reactor_turbineoutput_set"] = "Turbine output is now {1}%"

lang_files["CMD_ItemEdit_Reactor_fuelrate_Help"] = "Changes reactor fuel consumption rate"
lang_files["CMD_ItemEdit_Reactor_fuelrate_info"] = "Fuel Consumption rate is {1}% / sec"
lang_files["CMD_ItemEdit_Reactor_fuelrate_set"] = "Fuel Consumption rate is now {1}% / sec"

lang_files["CMD_ItemEdit_Reactor_auto_Help"] = "Toggles reactor automatic control"
lang_files["CMD_ItemEdit_Reactor_auto_on"] = "Automatic control is now enabled"
lang_files["CMD_ItemEdit_Reactor_auto_off"] = "Automatic control is now disabled"

lang_files["CMD_ItemEdit_Vent_oxygen_Help"] = "Changes amount of oxygen inside vent"
lang_files["CMD_ItemEdit_Vent_oxygen_info"] = "Vent has {1} u. oxygen"
lang_files["CMD_ItemEdit_Vent_oxygen_set"] = "Vent now has {1} u. oxygen"

lang_files["CMD_ItemEdit_DockingPort_dock_Help"] = "Tries to dock or undock other docking port near"
lang_files["CMD_ItemEdit_DockingPort_dock_error"] = "No avaible docking ports"

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
lang_files["CMD_Jobban_Reminder"] = "You can't play on this job, because you have Job-Ban on it\n\nExpires in: {1}\"\nReason: \"{2}\"\n\nIf you anyways will pick this job, you will be forced to play on \"{3}\""
lang_files["CMD_Jobban_ForcedPlay"] = "You have job-ban on job that you picked. You forced to play on \"{1}\""

-- Lang
lang_files["CMD_Lang_changed"] = "Language changed to \"{1}\". Type \"reloadlua\" to apply changes"
lang_files["CMD_Lang_unknown"] = "Unknown language. Type \".lang all\" to get list of languages."
lang_files["CMD_Lang_header"] = "List of languages:"
lang_files["CMD_Lang_element"] = "* {1}"
lang_files["CMD_Lang_suggest"] = "You can suggest your translation on GM-Tools discord server"

---- Chat commands
lang_files["Chat_Error_UnknownCommand"] = "Unknown command \"‖color:#ff9c9c‖{1}‖end‖\". Type \"‖color:#ff9c9c‖.help chat‖end‖\" in console for help"

-- FixMe
lang_files["HelpChat_FixMe"] = "Creates your data, if it for some reason was not created automaticly"
lang_files["Chat_FixMe_success"] = "Your data was successfully created"
lang_files["Chat_FixMe_fail"] = "Your data already exists"
--lang_files["Chat_FixMe_epicclownvirus3000"] = "Your data was successfully stolen!!!"

-- RestorePerms
lang_files["HelpChat_RestorePerms"] = "Restores permissions to commands"
lang_files["Chat_RestorePerms_restored"] = "Your permissions has been successfully restored!"

lang_files["Chat_Help_help"] = "Almost all GM-Tools commands executes from console (F3).\n\nYou need use this command in console for actual help"

-- Help
lang_files["HelpChat_Help"] = "Says that you need use this command in console"

-- Cls
lang_files["HelpChat_Cls"] = "Cleans chat"

---- Cooldown warnings
lang_files["CD_Warn"] = "Warning:\n\"{1}\"\n\nPlease stop it."
lang_files["CD_Warn_CMDSpam"] = "You using commands too fast"
lang_files["CD_Warn_CMDSpam_Kick"] = "Kicked for spamming commands"

lang_files["CD_Warn_NameChanging"] = "You changing nickname too fast"
lang_files["CD_Warn_NameChanging_Kick"] = "Changed nicknames too fast"

-- Time
lang_files["Permanent"] = "Permanent"
lang_files["Days"] = "days"
lang_files["Hours"] = "hours"
lang_files["Minutes"] = "minutes"
lang_files["Seconds"] = "seconds"

return lang_files