local lang_files = {}

---- Commands description
lang_files["Help_Help"] = "Выдаёт список команд и информацию о них"
lang_files["Help_AdminChat"] = "Отправляет сообщение в чат админов"
lang_files["Help_AdminPM"] = "Отправляет приватное сообщение указанному игроку"
lang_files["Help_AHelp"] = "Отправляет приватное сообщение админам"
lang_files["Help_ToggleAHelp"] = "Переключает работу .ahelp"
lang_files["Help_SaveData"] = "Сохраняет память GM-Tools"
lang_files["Help_ReloadConfig"] = "Перезагружает конфиг GM-Tools"
lang_files["Help_SeeGhostChat"] = "Позволяет видеть сообщения от мёртвых игроков, даже если вы не призрак"
lang_files["Help_DeadMsg"] = "Отправляет сообщение в чат призраков"
lang_files["Help_NearItems"] = "Выдаёт информацию о всех предметах рядом с курсором"
lang_files["Help_DeleteItem"] = "Удаляет предмет и всё что лежит внутри него"
lang_files["Help_ItemData"] = "Выдаёт информацию о предмете (Состояние, Тэги, и т.д.)"
lang_files["Help_Jobban"] = "Банит профессию у игрока, чтобы он не мог на ней играть"
lang_files["Help_UnJobban"] = "Разбанивает проффесии у игрока"
lang_files["Help_Cls"] = "Очищает консоль"
lang_files["Help_Ping"] = "Понг!"
lang_files["Help_List"] = "Выдаёт список игроков на сервере"
lang_files["Help_Smite"] = "Выполняет небольшое количество троллинга по отношению к указанному игроку :)"
lang_files["Help_Lang"] = "Глобально меняет язык мода на указанный"


---- Commands arguments description
-- AdminChat
lang_files["Args_AdminChat_msg"] = "Сообщение для отправки"

-- AdminPM
lang_files["Args_AdminPM_target"] = "Кто получит приватное сообщение"
lang_files["Args_AdminPM_msg"] = "Приватное ообщение для отправки"

-- AHelp
lang_files["Args_AHelp_msg"] = "Сообщение для админов"

-- ToggleAHelp
lang_files["Args_ToggleAHelp_status"] = "Может быть 'true' (Только включать), 'false' (Только выключать) или 'switch' (Переключать между вкл./выкл.)"

-- SeeGhostChat
lang_files["Args_SeeGhostChat_status"] = "Может быть 'true' (Только включать), 'false' (Только выключать) или 'switch' (Переключать между вкл./выкл.)"
lang_files["Args_SeeGhostChat_target"] = "Игрок для переключения этой способности. Оставьте пустым для применения на себе"

-- DeadMsg
lang_files["Args_DeadMsg_msg"] = "Сообщение для отправки в чат мёртвых"

-- Help
lang_files["Args_Help_command"] = "Введите информацию о команде чтобы получить больше информации о ней, или введите 'all' чтобы получить список команд"

-- NearItems
lang_files["Args_NearItems_size"] = "Радиус поиска, ввиде квадрата. По умолчанию: 100"
lang_files["Args_NearItems_ignorewires"] = "Если 'true', команда будет игнорировать провода на стене. Если 'false', то она не будет. По умолчанию: true"

-- DeleteItem
lang_files["Args_DeleteItem_id"] = "ID предмета для удаления"

-- ItemData
lang_files["Args_ItemData_id"] = "ID предмета"
lang_files["Args_ItemData_data"] = "Тип информации который вы хотите получить. Оставьте пустым для общей информации"

-- Jobban
lang_files["Args_Jobban_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_Jobban_job"] = "Профессия которая будет заблокирована для игрока"
lang_files["Args_Jobban_duration"] = "Время бана. Оставьте пустым для перманентного бана (Пример: \"6d 23h 59m 59s\")"
lang_files["Args_Jobban_reason"] = "Причина бана"

-- UnJobban
lang_files["Args_UnJobban_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_UnJobban_job"] = "Профессия которая будет разблокирована для игрока. Оставьте пустым чтобы разблокировать все профессии"

-- Smite
lang_files["Args_Smite_smite"] = "Вид наказания. Введите \".smite help\" чтобы получить список наказаний"
lang_files["Args_Smite_client"] = "Кто будет страдать. Оставьте поле пустым, если страдать будете вы"

---- Errors
lang_files["Error_NotEnoughPermissions"] = "У вас недостаточно прав для исполнения этой команды"
lang_files["Error_TooLongMessage"] = "Сообщение слишком большое!"
lang_files["Error_NotEnoughArguments"] = "Недостаточно аргументов"
lang_files["Error_BadArgument"] = "Неверный аргумент {1}"
lang_files["Error_PlayerNotFound"] = "Игрок не найден"
lang_files["Error_ItemNotFound"] = "Предмет не найден"
lang_files["Error_bad_id"] = "Указанный ID не является числом"
lang_files["Error_NoControlledChar"] = "Игрок не имеет персонажа под контролем"

-- Lang
lang_files["Args_Lang_language"] = "Language to change. Use \".lang all\" to get list of languages"

---- Command output
-- AdminPM & AHelp
lang_files["CMD_AdminPM_con_to_other_L1"] = "ADMINPM {1} --> {2}"
lang_files["CMD_AdminPM_con_to_other_L2"] = "   Приватное сообщение: \"{1}\""

lang_files["CMD_AdminPM_con_for_admin_L1"] = "ADMINPM {1} (Вы) --> {2}"
lang_files["CMD_AdminPM_con_for_admin_L2"] = "   Приватное сообщение: \"{1}\""

lang_files["CMD_AdminPM_con_for_player_L1"] = "ADMINPM {1} --> {2} (Вы)"
lang_files["CMD_AdminPM_con_for_player_L2"] = "   Приватное сообщение: {1}"
lang_files["CMD_AdminPM_con_for_player_L3"] = "Для ответа введите \".ahelp <сообщение>\" в консоль или чат"
lang_files["CMD_AdminPM_msg_for_player_name"] = "ADMIN PM от {1}"
lang_files["CMD_AdminPM_msg_for_player_text"] = "\n‖metadata:{1}‖{2}‖end‖ --> ‖metadata:{3}‖{4} (Вы)‖end‖\n   ‖color:#fcf0f0‖Приватное сообщение: \"{5}\"‖end‖\n‖color:#8a8a8a‖Для ответа введите \".ahelp <сообщение>\" в консоль или чат‖end‖"

--‖color:#ffffff;metadata:1234‖my name is Joe‖end‖
lang_files["CMD_AHelp_con_for_admin_L1"] = "AHELP {1} --> Админы (Включая вас)"
lang_files["CMD_AHelp_con_for_admin_L2"] = "   Приватное сообщение: {1}"
lang_files["CMD_AHelp_con_for_admin_L3"] = "Для ответа введите \".adminpm {1} <сообщение>\" в консоль"
lang_files["CMD_AHelp_msg_for_admin_name"] = "ADMIN HELP"
lang_files["CMD_AHelp_msg_for_admin_text"] = "\nОт ‖metadata:{1}‖{2}‖end‖ для ‖color:#e1a1a3‖Админов (Включая вас)‖end‖\n   ‖color:#fcf0f0‖Приватное сообщение: \"{3}\"‖end‖\n‖color:#8a8a8a‖Для ответа введите \".adminpm {4} <сообщение>\" в консоль‖end‖"

lang_files["CMD_AHelp_con_for_player_L1"] = "AHELP {1} (Вы) --> Админы"
lang_files["CMD_AHelp_con_for_player_L2"] = "   Приватное сообщение: {1}"
lang_files["CMD_AHelp_msg_for_player_name"] = "ADMIN HELP"
lang_files["CMD_AHelp_msg_for_player_text"] = "\nОт ‖metadata:{1}‖{2} (Вы)‖end‖ для ‖color:#e1a1a3‖Админов‖end‖\n   ‖color:#fcf0f0‖Приватное сообщение: \"{3}\"‖end‖"

lang_files["CMD_AHelp_disabled"] = "Команда .aHelp в данный момент отключена"
lang_files["CMD_AdminPM_NoMessage"] = "Не указано сообщение для отправки"


-- ToggleAHelp
lang_files["CMD_ToggleAHelp_enabled"] = ".ahelp теперь включён!"
lang_files["CMD_ToggleAHelp_disabled"] = ".ahelp теперь отключен!"
lang_files["CMD_ToggleAHelp_badargument"] = "Неверный аргумент. Параметр #1 принимает только эти значения: 'true', 'false' или 'switch'."


-- SaveData
lang_files["CMD_SaveData_init"] = "Сохранение памяти GM-Tools..."
lang_files["CMD_SaveData_end"] = "Память GM-Tools сохранена!"

-- ReloadConfig
lang_files["CMD_ReloadConfig_init"] = "Перезагрузка конфигурации..."
lang_files["CMD_ReloadConfig_end"] = "Конфиг перезагружен!"

-- DeadMsg
lang_files["CMD_DeadMsg_cantspeak"] = "Ваш персонаж умер или не умеет говорить. Используйте чат по обычному"
lang_files["CMD_DeadMsg_inround"] = "Эта команда работает только во-время раунда"

-- SeeGhostChat
lang_files["CMD_SeeGhostChat_alive"] = "Жив"
lang_files["CMD_SeeGhostChat_forced"] = "Призрачный чат"

-- Help
lang_files["CMD_Help_desc"] = "Описание"
lang_files["CMD_Help_args"] = "Аргументы"
lang_files["CMD_Help_unknown"] = "Неизвестная команда \"{1}\"!"
lang_files["CMD_Help_list"] = "Список"
lang_files["CMD_Help_chatlist"] = "Список (Чат)"

lang_files["CMD_Help_help"] = "Хелп"
lang_files["CMD_Help_line"] = "* Этот сервер запущен с модом \"GM-Tools\"\n* Введите \".help all\" если хотите получить список команд\n* Или введите \".help all chat\" чтобы получить список команд в чате."
lang_files["CMD_Help_gmt"] = "Game Master Tools"

-- Near Items
lang_files["CMD_NearItems_badrange"] = "Указанный размер не является числом"
lang_files["CMD_NearItems_badwires"] = "Неверное значение во втором аргументе. Введите 'true' или 'false'"
lang_files["CMD_NearItems_nearitems"] = "Предметы у курсора (Range: {1})"
lang_files["CMD_NearItems_unknown"] = "Неизвестно"
lang_files["CMD_NearItems_item"] = "* Предмет: \'{1}\' ID {2} ({3}%)"
lang_files["CMD_NearItems_contained_item"] = "* {1} Предмет(ов) в контейнере с ID {2} ({3})"

-- DeleteItem
lang_files["CMD_DeteteItem_deleted"] = "Успешно удалён предмет '{1}' с ID {2}"

-- ItemData
lang_files["CMD_ItemData_header"] = "Предмет [ID: {1}] \"{2}\" data:"
lang_files["CMD_ItemData_main_condition"] = "* Состояние: {1}%"
lang_files["CMD_ItemData_main_tags"] = "* \"Тэги: {1}\""
lang_files["CMD_ItemData_main_has_inv"] = "* Имеет свой инвентарь  -  Use \".item {1} see_inv\" to check"
lang_files["CMD_ItemData_main_contained"] = "* Находится в инвентаре: {1} [ID: {2}]"

lang_files["CMD_ItemData_condition"] = "Предмет \"{1}\" [ID: {2}] имеет состояние {3}%"

lang_files["CMD_ItemData_tags"] = "Тэги предмета [ID: {1}] \"{2}\":"
lang_files["CMD_ItemData_rawtags"] = "Изначально: \"{1}\""
lang_files["CMD_ItemData_onetag"] = "* {1}. \"{2}\""

lang_files["CMD_ItemData_UnknownInput"] = "Неизвестный параметр во втором аргументе"

-- Ping
lang_files["CMD_Ping_pong"] = "Понг!"

-- ClientList
lang_files["CMD_ClientList_header"] = "Список клиентов:"
lang_files["CMD_ClientList_client"] = "* Имя: {1}, ID: {2}, Персонаж: {3}, SteamID: {4}"

-- Smite
lang_files["CMD_Smite_gib"] = "Убивает игрока мега кроваво и эпично :sunglasses:"
lang_files["CMD_Smite_gigacancer"] = "Даёт игроку сильное облучение радиацией"
lang_files["CMD_Smite_drunk"] = "Делает игрока пьяным"
lang_files["CMD_Smite_orangeboy"] = "Превращает игрока в \"оранжевого парня\""
lang_files["CMD_Smite_longstun"] = "Станит игрока на 30 секунд"
lang_files["CMD_Smite_help"] = "Выдаёт список наказаний"

lang_files["CMD_Smite_SmiteList"] = "Виды наказаний:"

lang_files["CMD_Smite_Unknown"] = "Неизвестный вид наказания"

-- Jobban & Unjobban
lang_files["CMD_Jobban_BanLowest"] = "Вы не можете забанить самую низкую профессию"
lang_files["CMD_Jobban_UnknownJob"] = "Неизвестная профессия"
lang_files["CMD_Jobban_NoReason"] = "Без причины"
lang_files["CMD_Jobban_ConsoleOut"] = "Забанена профессия \"{1}\" для игрока \"{2}\".\nПричина: {3}\nДлительность: {4}"

lang_files["CMD_UnJobban_All"] = "Разблокированы все профессии у игрока {1}"
lang_files["CMD_UnJobban_Job"] = "Разблокирована профессия \"{1}\" у игрока {2}"
lang_files["CMD_UnJobban_NoBan"] = "Игрок не имел блокировки на этой профессии"

lang_files["CMD_Jobban_Box"] = "Вы были забанены по профессии!\n\nПрофессия: \"{1}\"\nОкончание через: {2}\nПричина: \"{3}\"\n"
lang_files["CMD_Jobban_Reminder"] = "Вы не можете играть на этой профессии, потому-что у вас есть блокировка на ней\n\nОкончание через: {1}\nПричина: \"{2}\"\n\nЕсли вы всё-равно выберете эту профессию, вы будете играть на \"{3}\""
lang_files["CMD_Jobban_ForcedPlay"] = "Вы имеете блокировку на профессии, которую выбрали. Вы будете играть на \"{1}\""

-- Lang
lang_files["CMD_Lang_changed"] = "Язык изменён на \"{1}\". Используйте команду \"reloadlua\" чтобы принять изменения"
lang_files["CMD_Lang_unknown"] = "Неизвестный язык. Введите \".lang all\" чтобы получить список доступных языков."
lang_files["CMD_Lang_header"] = "Список языков:"
lang_files["CMD_Lang_element"] = "* {1}"
lang_files["CMD_Lang_suggest"] = "Вы можете предложить свой перевод в дискорде GM-Tools"

---- Chat commands
lang_files["Chat_Error_UnknownCommand"] = "Неизвестная команда \"‖color:#ff9c9c‖{1}‖end‖\". Введите \"‖color:#ff9c9c‖.help all chat‖end‖\" в консоль для получения списка команд в чате."

-- FixMe
lang_files["HelpChat_FixMe"] = "Создаёт информацию о вас в моде, если она по какой-то причине не создалась автоматически"
lang_files["Chat_FixMe_success"] = "Ваша информация в моде была создана"
lang_files["Chat_FixMe_fail"] = "Мод уже имеет вашу информацию"

-- RestorePerms
lang_files["HelpChat_RestorePerms"] = "Восстанавливает права на команды"
lang_files["Chat_RestorePerms_restored"] = "Ваши права были восстановлены!"

lang_files["Chat_Help_help"] = "Почти все команды в GM-Tools исполняются из консоли (F3).\n\nИспользуйте эту команду в консоле, чтобы получить помощь по моду"

-- Help
lang_files["HelpChat_Help"] = "Говорит, что вам нужно использовать эту команду в консоли"

-- Cls
lang_files["HelpChat_Cls"] = "Чистит чат"

---- Cooldown warnings
lang_files["CD_Warn"] = "Внимание:\n\"{1}\"\n\nПожалуйста остановитесь."
lang_files["CD_Warn_CMDSpam"] = "Вы используете команды слишком быстро"
lang_files["CD_Warn_CMDSpam_Kick"] = "Исключён за быстрое использование команд"

lang_files["CD_Warn_NameChanging"] = "Вы меняете имя слишком быстро"
lang_files["CD_Warn_NameChanging_Kick"] = "Исключён за быстрое изменение имени"

-- Time
lang_files["Permanent"] = "Навсегда"
lang_files["Days"] = "дней"
lang_files["Hours"] = "часов"
lang_files["Minutes"] = "минут"
lang_files["Seconds"] = "секунд"
return lang_files