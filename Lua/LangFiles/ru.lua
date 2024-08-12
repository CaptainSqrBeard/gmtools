local lang_files = {}

---- Commands description
lang_files["Help_Help"] = "Выдаёт список команд и информацию о них"
lang_files["Help_AdminChat"] = "Отправляет сообщение в чат админов"
lang_files["Help_AdminPM"] = "Отправляет приватное сообщение указанному игроку. Игроки смогут ответить через \".ahelp\""
lang_files["Help_AHelp"] = "Отправляет приватное сообщение админам. Публична"
lang_files["Help_ToggleAHelp"] = "Переключает работу .ahelp"
lang_files["Help_ToggleBwoink"] = "Переключает включение звука \"Бвонька\" для игроков которые получают сообщения от модератора"
lang_files["Help_SaveData"] = "Сохраняет память GM-Tools"
lang_files["Help_ReloadConfig"] = "Перезагружает конфиг GM-Tools"
lang_files["Help_SeeGhostChat"] = "Позволяет видеть сообщения от мёртвых игроков, даже если вы не призрак"
lang_files["Help_DeadMsg"] = "Отправляет сообщение в чат призраков"
lang_files["Help_NearItems"] = "Выдаёт список всех предметов рядом с курсором"
lang_files["Help_DeleteItem"] = "Удаляет предмет и всё что лежит внутри него"
lang_files["Help_ItemData"] = "Выдаёт информацию о предмете (Состояние, Тэги, и т.д.)"
lang_files["Help_ItemEdit"] = "Изменяет значения компонентов предмета"
lang_files["Help_NearChars"] = "Выдаёт список всех персонажей рядом с курсором"
lang_files["Help_SubmarineData"] = "Выдаёт информацию о подлодке"
lang_files["Help_SubmarineGodmode"] = "Переключает \"режим бога\" у определённой подлодки"
lang_files["Help_SubmarineList"] = "Показывает список подлодок"
lang_files["Help_SubmarineLock"] = "Блокирует позицию определённой подлодки"
lang_files["Help_SubmarineTeleport"] = "Телепортирует определённую подлодку"
lang_files["Help_SubmarineAddTurretAI"] = "Создаёт ИИ турелей на подлодке. Внимание: Это действие перманентно!"
lang_files["Help_SubmarineThrow"] = "Изменяет физический вектор движения у заданной подлодки"
lang_files["Help_HumanList"] = "Выдаёт список всех персонажей-людей на карте"
lang_files["Help_CharData"] = "Выдаёт информацию о персонаже"
lang_files["Help_SpawnChar"] = "Создаёт персонажа с информацией, заданной пользователем"
lang_files["Help_Jobban"] = "Банит профессию у игрока, чтобы он не мог на ней играть"
lang_files["Help_UnJobban"] = "Разбанивает профессии у игрока"
lang_files["Help_GivePerm"] = "Дает разрешение игроку на использование команд GM-Tools"
lang_files["Help_RevokePerm"] = "Забирает у игрока разрешения на использование команд GM-Tools"
lang_files["Help_PermList"] = "Выдаёт список разрешённых команд игроку"
lang_files["Help_Cls"] = "Очищает консоль"
lang_files["Help_Ping"] = "Понг!"
lang_files["Help_List"] = "Выдаёт список игроков на сервере"
lang_files["Help_Smite"] = "Выполняет небольшое количество троллинга по отношению к указанному игроку. Используйте, если хотите наказать нарушителя без банов :)"
lang_files["Help_Lang"] = "Меняет язык мода на указанный"
lang_files["Help_Clock"] = "Просто циферблат"


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

-- ToggleBwoink
lang_files["Args_ToggleBwoink_status"] = "Может быть 'true' (Только включать), 'false' (Только выключать) или 'switch' (Переключать между вкл./выкл.)"

-- SeeGhostChat
lang_files["Args_SeeGhostChat_status"] = "Может быть 'true' (Только включать), 'false' (Только выключать) или 'switch' (Переключать между вкл./выкл.)"
lang_files["Args_SeeGhostChat_target"] = "Игрок для переключения этой способности. Оставьте пустым для применения на себе"

-- DeadMsg
lang_files["Args_DeadMsg_msg"] = "Сообщение для отправки в чат мёртвых"

-- Help
lang_files["Args_Help_command"] = "Введите информацию о команде чтобы получить больше информации о ней, или введите 'all' чтобы получить список команд"

-- NearItems
lang_files["Args_NearItems_size"] = "Радиус поиска, в виде круга. По умолчанию: 100"
lang_files["Args_NearItems_ignorewires"] = "Если 'true', команда будет игнорировать провода на стене. Если 'false', то она не будет. По умолчанию: true"

-- DeleteItem
lang_files["Args_DeleteItem_id"] = "ID предмета для удаления"

-- ItemData
lang_files["Args_ItemData_id"] = "ID предмета"
lang_files["Args_ItemData_data"] = "Тип информации который вы хотите получить. Оставьте пустым для общей информации"

-- ItemEdit
lang_files["Args_ItemEdit_id"] = "ID предмета"
lang_files["Args_ItemEdit_component"] = "Имя компонента или позиция в списке. Оставьте параметр пустым чтобы получить список компонентов предмета"
lang_files["Args_ItemEdit_action"] = "Исполняемое действие с этим компонентом. Оставьте параметр пустым для списка действий"
lang_files["Args_ItemEdit_args"] = "Параметры действия"

-- NearChars
lang_files["Args_NearChars_size"] = "Радиус поиска, в виде круга. По умолчанию: 100"

-- CharData
lang_files["Args_CharData_character"] = "ID/Имя персонажа"

-- SpawnChar
lang_files["Args_SpawnChar_id"] = "ID вида для создания. Используйте \"-h\" или \"-help\" чтобы увидеть список аргументов"
lang_files["Args_SpawnChar_args"] = "Аргументы при создании. Вы можете указать несколько аргументов. Например: \"-skincolor 2 -headtype 14 -haircolor 16\""

-- SubData
lang_files["Args_SubmarineData_submarine"] = "ID подлодки"

-- SubData
lang_files["Args_SubmarineTp_submarine"] = "ID подлодки"
lang_files["Args_SubmarineTp_position"] = "Позиция для телепорта. Если не указана, то подлодка телепортируется на курсор. Принимает значения 'cursor', 'start', 'end' или вектор в формате X;Y."

-- SubLock
lang_files["Args_SubmarineLock_submarine"] = "ID подлодки"
lang_files["Args_SubmarineLock_axis"] = "Ось для блокировки. Принимает значения 'x', 'y', 'xy'. По умолчанию: 'xy'"

-- SubGodmode
lang_files["Args_SubmarineGodmode_submarine"] = "ID подлодки"
lang_files["Args_SubmarineGodmode_value"] = "Включает, выключает или переключает \"режим бога\" у подлодки. Принимает значения 'true', 'false' or 'switch'. Если не указано, то \"режим бога\" будет переключаться."

-- SubAddTurretAI
lang_files["Args_SubmarineAddTurretAI_submarine"] = "ID подлодки"

-- SubThrow
lang_files["Args_SubmarineThrow_submarine"] = "ID подлодки"
lang_files["Args_SubmarineThrow_vector"] = "Вектор движения. Принимает значения 'cursor', 'ncursor' или вектор в формате X;Y. 'cursor': Задаёт вектор по направлению курсора. Чем дальше курсор от подлодки, тем выше скорость. 'ncursor': Задаёт вектор по направлению курсора, но с фиксированной скоростью."
lang_files["Args_SubmarineThrow_mode"] = "'set': (По умолчанию) перезаписывает текущий вектор движения новым, 'add': К текущему вектору движения добавится новый."

-- Jobban
lang_files["Args_Jobban_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_Jobban_job"] = "Профессия которая будет заблокирована для игрока"
lang_files["Args_Jobban_duration"] = "Время бана. Оставьте пустым для перманентного бана (Пример: \"6d 23h 59m 59s\")"
lang_files["Args_Jobban_reason"] = "Причина бана"

-- UnJobban
lang_files["Args_UnJobban_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_UnJobban_job"] = "Профессия которая будет разблокирована для игрока. Оставьте пустым чтобы разблокировать все профессии"

-- GivePerm
lang_files["Args_GivePerm_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_GivePerm_commands"] = "Выдать права на команду. Используйте \"all\" для выдачи всех прав. Вы можете указать несколько команд таким образом: \"giveperm 1 .adminpm .adminchat .smite\". Используйте \"all\" чтобы выдать весь доступ"

-- RevokePerm
lang_files["Args_RevokePerm_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_RevokePerm_commands"] = "Забрать права на команду. Вы можете указать несколько команд вот так: \"giveperm 1 .adminpm .adminchat .smite\". Используйте \"all\" чтобы забрать весь доступ"

-- PermList
lang_files["Args_PermList_player"] = "Имя/ID/SteamID игрока. Оставьте поле пустым чтобы применить на себя."

-- GivePerm
lang_files["Args_GivePerm_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_GivePerm_commands"] = "Команды для выдачи. Вы можете указать несколько команд сразу вот так: \"giveperm 1 .adminpm .adminchat .smite\""

-- RevokePerm
lang_files["Args_RevokePerm_player"] = "Имя/ID/SteamID игрока"
lang_files["Args_RevokePerm_commands"] = "Commands to revoke. Вы можете указать несколько команд сразу вот так: \"giveperm 1 .adminpm .adminchat .smite\""

-- PermList
lang_files["Args_PermList_player"] = "Имя/ID/SteamID игрока. Оставьте параметр пустым чтобы просмотреть себя."

-- Smite
lang_files["Args_Smite_smite"] = "Вид наказания. Введите \".smite help\" чтобы получить список наказаний"
lang_files["Args_Smite_character"] = "Персонаж, который будет страдать."

---- Errors
lang_files["Error_NotEnoughPermissions"] = "У вас недостаточно прав для исполнения этой команды"
lang_files["Error_TooLongMessage"] = "Сообщение слишком большое!"
lang_files["Error_LevelIsNotLoaded"] = "Уровень не загружен"
lang_files["Error_NoMessage"] = "Не указано сообщение"
lang_files["Error_NotEnoughArguments"] = "Недостаточно аргументов"
lang_files["Error_BadArgument"] = "Неверный аргумент {1}"
lang_files["Error_PlayerNotFound"] = "Игрок не найден"
lang_files["Error_CharacterNotFound"] = "Персонаж не найден"
lang_files["Error_SubmarineNotFound"] = "Подлодка не найдена"
lang_files["Error_ItemNotFound"] = "Предмет не найден"
lang_files["Error_UnknownJob"] = "Неизвестная профессия"
lang_files["Error_OutOfRange"] = "Указанное число вне диапазона между {1} и {2}"
lang_files["Error_OutOfRange_Less"] = "Указанное число меньше чем {1}"
lang_files["Error_bad_id"] = "Указанный ID не является числом"
lang_files["Error_bad_value"] = "Указанное значение не является числом"
lang_files["Error_NoControlledChar"] = "Игрок не имеет персонажа под контролем"
lang_files["Error_bad_boolean"] = "Неверный аргумент. Параметр #1 должен быть \"true\" или \"false\" или пустым"
lang_files["Error_bad_console"] = "Эта команда не работает в консоле"

---- Misc
lang_files["Console"] = "ХОСТ"
lang_files["Usage"] = "Использование: "

-- Lang
lang_files["Args_Lang_language"] = "Язык для смены. Используйте \".lang all\" чтобы посмотреть список всех языков"

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

lang_files["CMD_AHelp_con_for_admin_L1"] = "AHELP {1} --> Админы (Включая вас)"
lang_files["CMD_AHelp_con_for_admin_L2"] = "   Приватное сообщение: {1}"
lang_files["CMD_AHelp_con_for_admin_L3"] = "Для ответа введите \".adminpm {1} <сообщение>\" в консоль"
lang_files["CMD_AHelp_msg_for_admin_name"] = "ADMIN HELP"
lang_files["CMD_AHelp_msg_for_admin_text"] = "\nОт ‖metadata:{1}‖{2}‖end‖ для ‖color:#e1a1a3‖Админов (Включая вас)‖end‖\n   ‖color:#fcf0f0‖Приватное сообщение: \"{3}\"‖end‖\n‖color:#8a8a8a‖Для ответа введите \".adminpm {4} <сообщение>\" в консоль‖end‖"

lang_files["CMD_AHelp_con_for_player_L1"] = "AHELP {1} (Вы) --> Админы"
lang_files["CMD_AHelp_con_for_player_L2"] = "   Приватное сообщение: {1}"
lang_files["CMD_AHelp_msg_for_player_name"] = "ADMIN HELP"
lang_files["CMD_AHelp_msg_for_player_text"] = "\nОт ‖metadata:{1}‖{2} (Вы)‖end‖ для ‖color:#e1a1a3‖Админов‖end‖\n   ‖color:#fcf0f0‖Приватное сообщение: \"{3}\"‖end‖"

lang_files["CMD_AHelp_disabled"] = "Команда .ahelp в данный момент отключена"
lang_files["CMD_AdminPM_NoMessage"] = "Не указано сообщение для отправки"


-- ToggleAHelp
lang_files["CMD_ToggleAHelp_enabled"] = ".ahelp теперь включён!"
lang_files["CMD_ToggleAHelp_disabled"] = ".ahelp теперь отключен!"
lang_files["CMD_ToggleAHelp_badargument"] = "Неверный аргумент. Параметр #1 принимает только эти значения: 'true', 'false' или 'switch'."

-- ToggleBwoink
lang_files["CMD_ToggleBwoink_enabled"] = "Звук \"Бвонька\" теперь включён!"
lang_files["CMD_ToggleBwoink_disabled"] = "Звук \"Бвонька\" теперь отключен!"
lang_files["CMD_ToggleBwoink_badargument"] = "Неверный аргумент. Параметр #1 принимает только эти значения: 'true', 'false' или 'switch'."

-- SaveData
lang_files["CMD_SaveData_init"] = "Сохранение памяти GM-Tools..."
lang_files["CMD_SaveData_end"] = "Память GM-Tools сохранена!"

-- ReloadConfig
lang_files["CMD_ReloadConfig_init"] = "Перезагрузка конфигурации..."
lang_files["CMD_ReloadConfig_end"] = "Конфиг перезагружен!"

-- SeeGhostchat
lang_files["CMD_SeeGhostchat_badargument"] = "Неверный аргумент. Параметр #1 принимает только эти значения: 'true', 'false' или 'switch'."

-- DeadMsg
lang_files["CMD_DeadMsg_inround"] = "Эта команда работает только во-время раунда"

-- Help
lang_files["CMD_Help_desc"] = "Описание"
lang_files["CMD_Help_args"] = "Аргументы"
lang_files["CMD_Help_unknown"] = "Неизвестная команда \"{1}\"!"
lang_files["CMD_Help_list"] = "Список"
lang_files["CMD_Help_chatlist"] = "Список (Чат)"

lang_files["CMD_Help_help"] = "Хелп"
lang_files["CMD_Help_line"] = "* Этот сервер запущен с модом \"GM-Tools\"\n* Введите \".help all\" если хотите получить список команд\n* Введите \".help all chat\" чтобы получить список команд в чате.\n* Введите \".help <command>\" (без точки) чтобы получить больше информации об указанной команде."
lang_files["CMD_Help_gmt"] = "Game Master Tools"

-- NearChars
lang_files["CMD_NearChars_badrange"] = "Указанный размер не является числом"
lang_files["CMD_NearChars_nearchars"] = "Персонажи у курсора (Радиус: {1})"
lang_files["CMD_NearChars_char"] = "* \"{1}\", ID {2}, Команда: {3}"

-- Near Items
lang_files["CMD_NearItems_badrange"] = "Указанный размер не является числом"
lang_files["CMD_NearItems_badwires"] = "Неверное значение во втором аргументе. Введите 'true' или 'false'"
lang_files["CMD_NearItems_nearitems"] = "Предметы у курсора (Радиус: {1})"
lang_files["CMD_NearItems_unknown"] = "Неизвестно"
lang_files["CMD_NearItems_item"] = "* Предмет: \'{1}\' ID {2} ({3}%)"
lang_files["CMD_NearItems_contained_item"] = "* {1} Предмет(ов) в контейнере с ID {2} ({3})"

-- DeleteItem
lang_files["CMD_DeteteItem_deleted"] = "Успешно удалён предмет '{1}' с ID {2}"

-- ItemData
lang_files["CMD_ItemData_header"] = "Информация предмета [ID: {1}] \"{2}\":"
lang_files["CMD_ItemData_main_condition"] = "* Состояние: {1}%"
lang_files["CMD_ItemData_main_tags"] = "* Тэги: \"{1}\""
lang_files["CMD_ItemData_main_has_inv"] = "* Имеет свой инвентарь  - Используйте \".itemdata {1} see_inv\" чтобы просмотреть"
lang_files["CMD_ItemData_main_contained"] = "* Находится в инвентаре: {1} [ID: {2}]"

lang_files["CMD_ItemData_condition"] = "Предмет \"{1}\" [ID: {2}] имеет состояние {3}%"

lang_files["CMD_ItemData_tags"] = "Тэги предмета [ID: {1}] \"{2}\":"
lang_files["CMD_ItemData_rawtags"] = "Изначально: \"{1}\""
lang_files["CMD_ItemData_onetag"] = "* {1}. \"{2}\""

lang_files["CMD_ItemData_no_inv"] = "У предмета нету своего инвентаря"
lang_files["CMD_ItemData_container"] = "Контейнер {1}:"
lang_files["CMD_ItemData_inventory"] = "Предметы в '{1}' [ID {2}]"
lang_files["CMD_ItemData_inv_item"] = "* \"{1}\" ID {2} ({3}%)"
lang_files["CMD_ItemData_inv_item_winv"] = "* \"{1}\" ID {2} ({3}%) - Имеет свой инвентарь (.itemdata {2} see_inv)"

lang_files["CMD_ItemData_UnknownInput"] = "Неизвестный параметр во втором аргументе"

-- HumanList
lang_files["CMD_HumanList_header"] = "Список людей:"
lang_files["CMD_HumanList_char"] = "* \"{1}\", ID {2}, Команда: {3}"

-- CharData
lang_files["CMD_CharData_header"] = "Информация персонажа [ID: {1}] \"{2}\":"
lang_files["CMD_CharData_main_species"] = "* Вид: \"{1}\""
lang_files["CMD_CharData_main_health"] = "* Здоровье: {1}/{2}"
lang_files["CMD_CharData_main_team"] = "* Команда: {1}"
lang_files["CMD_CharData_main_has_inv"] = "* Имеет инвентарь - Используйте \".chardata {1} see_inv\" чтобы проверить"
lang_files["CMD_CharData_main_controlled"] = "* Контроллируется игроком \"{1}\" ID {2}"
lang_files["CMD_CharData_main_uncontrolled"] = "* Никем не контролируется"

lang_files["CMD_CharData_inv_header"] = "Предметы у персонажа \"{1}\" [ID {2}] в инвентаре:"
lang_files["CMD_CharData_no_inv"] = "Character doesn't have own inventory"
lang_files["CMD_CharData_inv_item"] = "* Предмет \'{1}\' ID {2}"
lang_files["CMD_CharData_inv_iteminv"] = "* Предмет \'{1}\' ID {2} - Имеет свой инвентарь (.itemdata {2} see_inv)"

lang_files["CMD_CharData_UnknownInput"] = "Неизвестный параметр во втором аргументе"

-- SpawnChar
lang_files["CMD_SpawnChar_help_header"] = "Список аргументов:"
lang_files["CMD_SpawnChar_help_entry"] = "* -{1} {2}     >     {3}"
lang_files["CMD_SpawnChar_help_entry_no_args"] = "* -{1}     >     {2}"

lang_files["CMD_SpawnChar_result"] = "Создан персонаж \"{1}\" с ID {2}"

lang_files["CMD_SpawnChar_error_unknown_species"] = "Неизвестные вид \"{1}\""
lang_files["CMD_SpawnChar_error_bad_beginning"] = "Неверное начало аргументов"
lang_files["CMD_SpawnChar_error_unknown_argument"] = "Неизвестный аргумент: {1}"
lang_files["CMD_SpawnChar_in_argument"] = "Argument \"{1}\": {2}"
lang_files["CMD_SpawnChar_no_character_info"] = "Сущность не имеет информации персонажа"
lang_files["CMD_SpawnChar_unknown_type"] = "Неизвестный тип"
lang_files["CMD_SpawnChar_no_pos"] = "Позиция не указана; Создание отменено"
lang_files["CMD_SpawnChar_no_cursor"] = "Позиция курсора не может быть использована из консоли"
lang_files["CMD_SpawnChar_spawn_cancelled"] = "Создание отменено"
lang_files["CMD_SpawnChar_color_error"] = "Произошла ошибка при получении цвета"
lang_files["CMD_SpawnChar_no_heads"] = "Вид не имеет разновидностей головы"
lang_files["CMD_SpawnChar_no_color_skin"] = "Вид не имеет разновидностей цвета кожи"
lang_files["CMD_SpawnChar_no_color_hair"] = "Вид не имеет разновидностей цвета волос"
lang_files["CMD_SpawnChar_no_color_facial_hair"] = "Вид не имеет разновидностей цвета лицевой растительности"

lang_files["CMD_SpawnChar_no_description"] = "Нет описания"
lang_files["CMD_SpawnChar_desc_name"] = "Меняет имя персонажа."
lang_files["CMD_SpawnChar_desc_addhumandata"] = "Добавляет персонажу информацию персонажа. Люди и заражённые хаском имеют эту информацию по умолчанию. Работает необычно с нечеловеческими видами."
lang_files["CMD_SpawnChar_desc_ai_seed"] = "Меняет сид ИИ у персонажа в случае если вы хотите чтобы ваши персонажи вели себя немного одинаково"
lang_files["CMD_SpawnChar_desc_hairtype"] = "Вид причёски который будет у персонажа"
lang_files["CMD_SpawnChar_desc_beardtype"] = "Вид лицевой растительности который будет у персонажа"
lang_files["CMD_SpawnChar_desc_headtype"] = "Вид головы который будет у персонажа. Также влияет на пол персонажа."
lang_files["CMD_SpawnChar_desc_accessorytype"] = "Аксессуар который будет иметь персонаж."
lang_files["CMD_SpawnChar_desc_moustachetype"] = "Вид усов который будет у персонажа. Имейте ввиду, что усов нету в ванильном наборе контента так, как они устарели"
lang_files["CMD_SpawnChar_desc_skincolor"] = "Меняет цвет кожи."
lang_files["CMD_SpawnChar_desc_haircolor"] = "Меняет цвет волос."
lang_files["CMD_SpawnChar_desc_beardcolor"] = "Меняет цвет лицевой растительности."
lang_files["CMD_SpawnChar_desc_jobloadout"] = "Выдаёт набор предметов указанной профессии. Имейте ввиду что в ванилле, только видимые профессии имеют набор предметов"
lang_files["CMD_SpawnChar_desc_job"] = "Выдаёт персонажу указанную профессию. Используйте -jobloadout для выдачи предметов профессии."
lang_files["CMD_SpawnChar_desc_team"] = "Команда, в которой будет этот персонаж. 0 - Нету; 1 - Команда 1; 2 - Команда 2; 3 - Дружелюбные NPC."
lang_files["CMD_SpawnChar_desc_cancel"] = "Вручную отменяет создание персонажа."
lang_files["CMD_SpawnChar_desc_pos"] = "Изменяет место появления."

-- ItemEdit
lang_files["CMD_ItemEdit_c_header"] = "Компоненты \"{1}\" ID {2}"
lang_files["CMD_ItemEdit_c_element"] = "{1}. \"{2}\""
lang_files["CMD_ItemEdit_c_basic"] = "0. \"Basic\""
lang_files["CMD_ItemEdit_badindex"] = "Указанный индекс не является числом"
lang_files["CMD_ItemEdit_nocomponent"] = "Компонент не найден. Введите имя компонента или его позицию в списке"
lang_files["CMD_ItemEdit_noactions"] = "Этот компонент не имеет никаких действий"
lang_files["CMD_ItemEdit_act_header"] = "Действия для компонента \"{1}\""
lang_files["CMD_ItemEdit_act_element"] = "* {1}  >  \"{2}\""
lang_files["CMD_ItemEdit_badaction"] = "Неизвестное действие"
lang_files["CMD_ItemEdit_basic_header"] = "Базовые действия для \'{1}\' ID {2}"
lang_files["CMD_ItemEdit_basic_element"] = "* {1}  >  \"{2}\""

lang_files["CMD_ItemEdit_Basic_condition_Help"] = "Изменяет состояние предмета"
lang_files["CMD_ItemEdit_Basic_condition_info"] = "Состояние {1}%"
lang_files["CMD_ItemEdit_Basic_condition_set"] = "Теперь состояние {1}%"

lang_files["CMD_ItemEdit_Basic_tags_Help"] = "Изменяет теги предмета"
lang_files["CMD_ItemEdit_Basic_tags_info"] = "Теги \"{1}\""
lang_files["CMD_ItemEdit_Basic_tags_set"] = "Теперь теги \"{1}\""

lang_files["CMD_ItemEdit_Basic_colorsprite_Help"] = "Изменяет цвет спрайта предмета"
lang_files["CMD_ItemEdit_Basic_colorsprite_info"] = "Цвет {1}"
lang_files["CMD_ItemEdit_Basic_colorsprite_set"] = "Теперь цвет {1}"

lang_files["CMD_ItemEdit_Basic_colorinv_Help"] = "Изменяет цвет предмета в инвентаре"
lang_files["CMD_ItemEdit_Basic_colorinv_info"] = "Цвет {1}"
lang_files["CMD_ItemEdit_Basic_colorinv_set"] = "Теперь цвет {1}"

lang_files["CMD_ItemEdit_Basic_color_Help"] = "Изменяет цвет предмета"
lang_files["CMD_ItemEdit_Basic_color_info"] = "Цвет {1}"
lang_files["CMD_ItemEdit_Basic_color_set"] = "Теперь цвет {1}"

lang_files["CMD_ItemEdit_Basic_scale_Help"] = "Изменяет размер предмета"
lang_files["CMD_ItemEdit_Basic_scale_info"] = "Размер {1}x"
lang_files["CMD_ItemEdit_Basic_scale_set"] = "Теперь размер {1}"

lang_files["CMD_ItemEdit_Basic_interactable_Help"] = "Делает предмет неинтерактивным и наоборот. Предметы внутри хранилищ становятся заблокированными"
lang_files["CMD_ItemEdit_Basic_interactable_on"] = "Теперь предмет интерактивен"
lang_files["CMD_ItemEdit_Basic_interactable_off"] = "Теперь предмет неинтерактивен"

lang_files["CMD_ItemEdit_Quality_level_Help"] = "Изменяет уровень предмета (Небольшой рассинхрон)"
lang_files["CMD_ItemEdit_Quality_level_info"] = "Уровень предмета {1}/{2}"
lang_files["CMD_ItemEdit_Quality_level_badlevel"] = "Указанный уровень не является числом"
lang_files["CMD_ItemEdit_Quality_level_outofrange"] = "Указанный уровень выходит за диапазон. Используйте числа в диапазоне 0-3"
lang_files["CMD_ItemEdit_Quality_level_warn"] = "Внимание, рассинхронизация! Клиенты будут видеть исходный уровень предмета"

lang_files["CMD_ItemEdit_Holdable_pick_Help"] = "Заставляет персонажа поднять предмет"

lang_files["CMD_ItemEdit_Holdable_attach_Help"] = "Прикрепляет или открепляет предмет от стены"
lang_files["CMD_ItemEdit_Holdable_attach_unable"] = "Предмет не может быть прикреплён"
lang_files["CMD_ItemEdit_Holdable_attach_attached"] = "Предмет теперь прикреплён к стене"
lang_files["CMD_ItemEdit_Holdable_attach_deattached"] = "Предмет теперь откреплён от стены"

lang_files["CMD_ItemEdit_PowerContainer_power_Help"] = "Изменяет кол-во энергии внутри батареи"
lang_files["CMD_ItemEdit_PowerContainer_power_info"] = "Внутри батареи {1} кВ / {2} кВ"
lang_files["CMD_ItemEdit_PowerContainer_power_set"] = "Теперь внутри батареи {1} кВ/ {2} кВ"

lang_files["CMD_ItemEdit_PowerContainer_capacity_Help"] = "Изменяет вместительность батареи (Небольшой рассинхрон)"
lang_files["CMD_ItemEdit_PowerContainer_capacity_info"] = "Вместительность батареи {1} кВ"
lang_files["CMD_ItemEdit_PowerContainer_capacity_set"] = "Теперь местительность батареи {1} кВ"
lang_files["CMD_ItemEdit_PowerContainer_capacity_warn"] = "Внимание, рассинхронизация! Клиенты будут видеть оригинальную вместительность предмета"

lang_files["CMD_ItemEdit_PowerContainer_speed_Help"] = "Изменяет скорость зарядки"
lang_files["CMD_ItemEdit_PowerContainer_speed_info"] = "Текущая скорость зарядки {1} kW / мин."
lang_files["CMD_ItemEdit_PowerContainer_speed_set"] = "Скорость зарядки теперь {1} kW / мин."

lang_files["CMD_ItemEdit_PowerTransfer_canoverload_Help"] = "Переключает повреждения от перенапряжения"
lang_files["CMD_ItemEdit_PowerTransfer_canoverload_on"] = "Теперь предмет может быть перегружен"
lang_files["CMD_ItemEdit_PowerTransfer_canoverload_off"] = "Теперь предмет не может быть перегружен"

lang_files["CMD_ItemEdit_Engine_force_Help"] = "Изменяет силу с которой будет работать двигатель"
lang_files["CMD_ItemEdit_Engine_force_info"] = "Текущая сила двигателя {1}%"
lang_files["CMD_ItemEdit_Engine_force_set"] = "Теперь сила двигателя {1}%"

lang_files["CMD_ItemEdit_Engine_maxforce_Help"] = "Изменяет максимальную силу двигателя"
lang_files["CMD_ItemEdit_Engine_maxforce_info"] = "Максимальная сила двигателя {1}"
lang_files["CMD_ItemEdit_Engine_maxforce_set"] = "Теперь максимальная сила двигателя {1}"

lang_files["CMD_ItemEdit_Deconstructor_speed_Help"] = "Изменяет множитель скорости (Средний рассинхрон)"
lang_files["CMD_ItemEdit_Deconstructor_speed_info"] = "Множитель скорости деконструктора x{1}"
lang_files["CMD_ItemEdit_Deconstructor_speed_set"] = "Множитель скорости деконструктора теперь x{1}"
lang_files["CMD_ItemEdit_Deconstructor_speed_warn"] = "Внимание, рассинхронизация! Клиенты будут видеть, что прогресс-бар будет заполнятся с обычной скоростью"

lang_files["CMD_ItemEdit_Fabricator_skill_Help"] = "Изменяет множитель требуемого навыка (Средний рассинхрон)"
lang_files["CMD_ItemEdit_Fabricator_skill_info"] = "Множитель требуемого навыка x{1}"
lang_files["CMD_ItemEdit_Fabricator_skill_set"] = "Теперь множитель требуемого навыка x{1}"
lang_files["CMD_ItemEdit_Fabricator_skill_warn"] = "Внимание, рассинхронизация! Клиенты будут видеть что им нужен исходное кол-во навыка для крафта (Время во-время крафта будет синхронизировано)"

lang_files["CMD_ItemEdit_OxygenGenerator_produce_Help"] = "Изменяет производительность кислорода"
lang_files["CMD_ItemEdit_OxygenGenerator_produce_info"] = "Производительность кислорода {1}"
lang_files["CMD_ItemEdit_OxygenGenerator_produce_set"] = "Теперь производительность кислорода {1}"

lang_files["CMD_ItemEdit_Pump_maxflow_Help"] = "Изменяет максимальную пропускную способность насоса"
lang_files["CMD_ItemEdit_Pump_maxflow_info"] = "Максимальная пропускную способность насоса {1}"
lang_files["CMD_ItemEdit_Pump_maxflow_set"] = "Теперь максимальная пропускную способность насоса {1}"
lang_files["CMD_ItemEdit_Pump_maxflow_warn"] = "Внимание, рассинхронизация! Клиенты будут видеть что насос будет качать с исходной скоростью, а комнаты будут переодически менять свой уровень воды"

lang_files["CMD_ItemEdit_Pump_percentage_Help"] = "Меняет как сильно помпа будет работать"
lang_files["CMD_ItemEdit_Pump_percentage_info"] = "Текущая сила насоса {1}%"
lang_files["CMD_ItemEdit_Pump_percentage_set"] = "Теперь сила насоса {1}%"

lang_files["CMD_ItemEdit_Reactor_toggle_Help"] = "Переключает реактор"
lang_files["CMD_ItemEdit_Reactor_toggle_on"] = "Реактор включён"
lang_files["CMD_ItemEdit_Reactor_toggle_off"] = "Реактор отключён"

lang_files["CMD_ItemEdit_Reactor_maxpower_Help"] = "Изменяет производительность реактора"
lang_files["CMD_ItemEdit_Reactor_maxpower_info"] = "Максимальная производительность {1} кВ"
lang_files["CMD_ItemEdit_Reactor_maxpower_set"] = "Теперь максимальная производительность {1} кВ"

lang_files["CMD_ItemEdit_Reactor_meltdowndelay_Help"] = "Изменяет задержку плавления реактора"
lang_files["CMD_ItemEdit_Reactor_meltdowndelay_info"] = "Задержка плавления реактора {1} секунд"
lang_files["CMD_ItemEdit_Reactor_meltdowndelay_set"] = "Теперь задержка плавления реактора {1} секунд"

lang_files["CMD_ItemEdit_Reactor_firedelay_Help"] = "Изменяет задержку пожара реактора"
lang_files["CMD_ItemEdit_Reactor_firedelay_info"] = "Задержка пожара реактора {1} секунд"
lang_files["CMD_ItemEdit_Reactor_firedelay_set"] = "Теперь задержка пожара реактора {1} seconds"

lang_files["CMD_ItemEdit_Reactor_fissionrate_Help"] = "Изменяет скорость расщепления реактора"
lang_files["CMD_ItemEdit_Reactor_fissionrate_info"] = "Скорость расщепления {1}%"
lang_files["CMD_ItemEdit_Reactor_fissionrate_set"] = "Теперь скорость расщепления {1}%"

lang_files["CMD_ItemEdit_Reactor_turbineoutput_Help"] = "Изменяет выработку электроэнергии реактора"
lang_files["CMD_ItemEdit_Reactor_turbineoutput_info"] = "Выработка электроэнергии {1}%"
lang_files["CMD_ItemEdit_Reactor_turbineoutput_set"] = "Теперь выработка электроэнергии {1}%"

lang_files["CMD_ItemEdit_Reactor_fuelrate_Help"] = "Изменяет потребление топлива реактором"
lang_files["CMD_ItemEdit_Reactor_fuelrate_info"] = "Потребление топлива {1}% / сек."
lang_files["CMD_ItemEdit_Reactor_fuelrate_set"] = "Теперь потребление топлива {1}% / сек."

lang_files["CMD_ItemEdit_Reactor_auto_Help"] = "Переключает автоматический контроль реактора"
lang_files["CMD_ItemEdit_Reactor_auto_on"] = "Автоматический контроль включен"
lang_files["CMD_ItemEdit_Reactor_auto_off"] = "Автоматический контроль выключен"

lang_files["CMD_ItemEdit_Vent_oxygen_Help"] = "Изменяет кол-во кислорода внутри"
lang_files["CMD_ItemEdit_Vent_oxygen_info"] = "Вентиляция имеет {1} ед. кислорода"
lang_files["CMD_ItemEdit_Vent_oxygen_set"] = "Теперь вентиляция имеет {1} ед. кислорода"

lang_files["CMD_ItemEdit_DockingPort_dock_Help"] = "Пытается пристыковаться к другому порту рядом"
lang_files["CMD_ItemEdit_DockingPort_dock_error"] = "Нет доступных стыковочный портов"

-- Ping
lang_files["CMD_Ping_pong"] = "Понг!"

-- ClientList
lang_files["CMD_ClientList_header"] = "Список клиентов:"
lang_files["CMD_ClientList_client"] = "* Имя: {1}, ID: {2}, Персонаж: {3}, SteamID: {4}"

-- Sublist
lang_files["CMD_SubmarineList_header"] = "Submarine list:"
lang_files["CMD_SubmarineList_sub"] = "{1}. \"{2}\" ({3})"

lang_files["CMD_SubmarineList_respawn_shuttle"] = "Шаттл возрождения"
lang_files["CMD_SubmarineList_mainsub"] = "Основная подлодка"

-- Subdata
lang_files["CMD_SubmarineData_header"] = "Информация о подлодке #{1}"
lang_files["CMD_SubmarineData_name"] = "* Название: {1}"
lang_files["CMD_SubmarineData_mainsub"] = "* Основная подлодка"
lang_files["CMD_SubmarineData_shuttle"] = "* Шаттл возрождения"
lang_files["CMD_SubmarineData_team"] = "* Команда: {1}"
lang_files["CMD_SubmarineData_type"] = "* Тип: {1}"
lang_files["CMD_SubmarineData_class"] = "* Класс: {1}"
lang_files["CMD_SubmarineData_locked"] = "* Позиция заблокирована по осям: {1}"
lang_files["CMD_SubmarineData_unlocked"] = "* Позиция разблокирована"
lang_files["CMD_SubmarineData_position"] = "* Позиция: ({1}; {2})"
lang_files["CMD_SubmarineData_velocity"] = "* Скорость: ({1}; {2})"
lang_files["CMD_SubmarineData_depth"] = "* Глубина в реальном мире: {1}m/{2}m"

-- Subtp
lang_files["CMD_SubmarineTp_Success"] = "Подлодка {1} телепортирована с позиции ({2}; {3}) на ({4}; {5})"
lang_files["CMD_SubmarineTp_UnknownType"] = "Указан некорректный вектор или позиция для телепортации"
lang_files["CMD_SubmarineTp_NoPosition"] = "Укажите позицию для телепортации (start, end, X;Y)"
lang_files["CMD_SubmarineTp_NoCursor"] = "Позиция курсора не может быть использована с серверной консоли"

-- SubThrow
lang_files["CMD_SubmarineThrow_Set"] = "Задан вектор движения подлодки {1}: {2}; {3}"
lang_files["CMD_SubmarineThrow_Add"] = "Добавлен вектор движения подлодки {1}: {2}; {3}"
lang_files["CMD_SubmarineThrow_UnknownTypeVector"] = "Указан некорректный вектор или позиция"
lang_files["CMD_SubmarineThrow_UnknownTypeMode"] = "Указан некорректный режим"
lang_files["CMD_SubmarineThrow_NoCursor"] = "Позиция курсора не может быть использована с серверной консоли"

-- Sublock
lang_files["CMD_SubmarineLocked_FullLock"] = "Подлодка заблокирована на обеих осях"
lang_files["CMD_SubmarineLocked_FullUnlock"] = "Подлодка разблокирована на обеих осях"
lang_files["CMD_SubmarineLocked_XLock"] = "Подлодка заблокирована по оси X"
lang_files["CMD_SubmarineLocked_XUnlock"] = "Подлодка разблокирована по оси X"
lang_files["CMD_SubmarineLocked_YLock"] = "Подлодка заблокирована по оси Y"
lang_files["CMD_SubmarineLocked_YUnlock"] = "Подлодка разблокирована по оси Y"

-- SubGodmode
lang_files["CMD_SubmarineGodmode_Enabled"] = "Включен \"режим бога\" для подлодки \"{1}\""
lang_files["CMD_SubmarineGodmode_Disabled"] = "Отключен \"режим бога\" для подлодки \"{1}\""
lang_files["CMD_SubmarineGodmode_BadArgument"] = "Неверный аргумент. Параметр #1 принимает только эти значения: 'true', 'false' или 'switch'."

-- SubAddTurretAI
lang_files["CMD_SubmarineAddTurretAI_AlreadyHave"] = "Подлодка \"{1}\" уже имеет турельный ИИ"
lang_files["CMD_SubmarineAddTurretAI_Success"] = "добавлен турельный ИИ для \"{1}\""

-- Smite
lang_files["CMD_Smite_gib"] = "Убивает игрока мега кроваво и эпично :sunglasses:"
lang_files["CMD_Smite_gigacancer"] = "Даёт игроку сильное облучение радиацией"
lang_files["CMD_Smite_drunk"] = "Делает игрока пьяным"
lang_files["CMD_Smite_orangeboy"] = "Превращает игрока в \"оранжевого парня\""
lang_files["CMD_Smite_longstun"] = "Станит игрока на 30 секунд"
lang_files["CMD_Smite_help"] = "Выдаёт список наказаний"

lang_files["CMD_Smite_SmiteList"] = "Виды наказаний:"

lang_files["CMD_Smite_Unknown"] = "Неизвестный вид наказания"
lang_files["CMD_Smite_Applied"] = "Применено наказание \"{1}\" на персонажа \"{2}\""

-- Jobban & Unjobban
lang_files["CMD_Jobban_BanLowest"] = "Вы не можете забанить самую низкую профессию"
lang_files["CMD_Jobban_UnknownJob"] = "Неизвестная профессия"
lang_files["CMD_Jobban_NoReason"] = "Без причины"
lang_files["CMD_Jobban_AdminIssue"] = "Вы не можете забанить профессию игроку с доступом к команде \".jobban\""
lang_files["CMD_Jobban_ConsoleOut"] = "Забанена профессия \"{1}\" для игрока \"{2}\".\nПричина: {3}\nДлительность: {4}"

lang_files["CMD_UnJobban_All"] = "Разблокированы все профессии у игрока {1}"
lang_files["CMD_UnJobban_Job"] = "Разблокирована профессия \"{1}\" у игрока {2}"
lang_files["CMD_UnJobban_NoBan"] = "Игрок не имел блокировки на этой профессии"

lang_files["CMD_Jobban_Box"] = "Вы были забанены по профессии!\n\nПрофессия: \"{1}\"\nОкончание через: {2}\nПричина: \"{3}\"\n"
lang_files["CMD_Jobban_Reminder"] = "Вы не можете играть на этой профессии, потому-что у вас есть блокировка на ней\n\nОкончание через: {1}\nПричина: \"{2}\"\n\nЕсли вы всё-равно выберете эту профессию, вы будете играть на \"{3}\""
lang_files["CMD_Jobban_ForcedPlay"] = "Вы имеете блокировку на профессии, которую выбрали. Вы будете играть на \"{1}\""

-- GivePerm
lang_files["CMD_GivePerm_header"] = "Выдаются права для {1}:"
lang_files["CMD_GivePerm_alreadyhas"] = "* (!) Игрок уже имеет разрешение на команду \"{1}\""
lang_files["CMD_GivePerm_notexists"] = "* (!) Команда \"{1}\" не существует или не является командой GM-Tools"
lang_files["CMD_GivePerm_added"] = "* Выдано право на команду \"{1}\""
lang_files["CMD_GivePerm_all"] = "Выданы все права на команды игроку {1}"

-- RevokePerm
lang_files["CMD_RevokePerm_header"] = "Отбираются права у {1}:"
lang_files["CMD_RevokePerm_donthave"] = "* (!) Игрок итак не имеет разрешения на команду \"{1}\""
lang_files["CMD_RevokePerm_notexists"] = "* (!) Команда \"{1}\" не существует или не является командой GM-Tools"
lang_files["CMD_RevokePerm_revoked"] = "* Отобрано право на команду \"{1}\""
lang_files["CMD_RevokePerm_all"] = "Отобраны все права у игрока {1}"

-- PermList
lang_files["CMD_PermList_header"] = "Доступные команды \"{1}\":"
lang_files["CMD_PermList_item"] = "* {1}"

-- Lang
lang_files["CMD_Lang_changed"] = "Язык изменён на \"{1}\". Используйте команду \"reloadlua\" чтобы принять изменения\nВНИМАНИЕ: Это действие скорей-всего поломает другие Lua моды и сбросит блокировку подлодок."
lang_files["CMD_Lang_unknown"] = "Неизвестный язык. Введите \".lang all\" чтобы получить список доступных языков."
lang_files["CMD_Lang_header"] = "Список языков:"
lang_files["CMD_Lang_element"] = "* {1}"
lang_files["CMD_Lang_suggest"] = "Вы можете предложить свой перевод на странице мода"

---- Chat commands
lang_files["Chat_Error_UnknownCommand"] = "Неизвестная команда \"‖color:#ff9c9c‖{1}‖end‖\". Введите \"‖color:#ff9c9c‖.help all chat‖end‖\" в консоль для получения списка команд в чате."

-- FixMe
lang_files["HelpChat_FixMe"] = "Пытается починить проблемы, которые могли возникнуть правами игрока."
lang_files["Chat_FixMe_attempt"] = "Мы попытались починить ошибки. Надеюсь это помогло."

lang_files["Chat_Help_help"] = "Почти все команды в GM-Tools исполняются из консоли (F3).\n\nИспользуйте эту команду в консоле, чтобы получить помощь по моду.\n\nЕсли она не работает, значит используйте \".fixme\" в чате и попробуйте ещё раз."

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

-- Submarine Types
lang_files["Submarine_types_player"] = "Подлодка игрока"
lang_files["Submarine_types_outpost"] = "Аванпост"
lang_files["Submarine_types_outpostmodule"] = "Модуль аванпоста"
lang_files["Submarine_types_wreck"] = "Обломок"
lang_files["Submarine_types_beaconstation"] = "Станция маяка"
lang_files["Submarine_types_enemysubmarine"] = "Вражеская подлодка"
lang_files["Submarine_types_ruin"] = "Руины"
lang_files["Submarine_types_custom"] = "Кастомная #{1}"

-- Submarine Classes
lang_files["Submarine_classes_undefined"] = "Не указано"
lang_files["Submarine_classes_scout"] = "Разведка"
lang_files["Submarine_classes_attack"] = "Боевая"
lang_files["Submarine_classes_transport"] = "Транспортная"
lang_files["Submarine_classes_custom"] = "Кастомная #{1}"

lang_files["CharacterTeams_none"] = "Нету"
lang_files["CharacterTeams_team1"] = "Команда 1"
lang_files["CharacterTeams_team2"] = "Команда 2"
lang_files["CharacterTeams_friendlynpc"] = "Дружелюбные NPC"
lang_files["CharacterTeams_custom"] = "Кастомная #{1}"

return lang_files