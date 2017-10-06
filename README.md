# MI-3-reset-button-switcher
Script for Xiaomi MI-3 router with padavan firmware.
Gives ability to switch 2.4Ghz AP and 5Ghz WDS+AP setting to 5Ghz AP and 2.4Ghz WDS+AP by short pushing on reset button
with LED indicator confirmation. This need to get WDS only on one wireless interface at a time, in short - you could
switch your WDS bridge from one frequency to another and back by one push (ofcourse, if other side of bridge configured right).

Script check router settings and change mode on opposite. If there is a mess in settings, it enable 5Ghz AP and 2.4Ghz WDS+AP mode by default. This mode submitted by two blinks.Next mode is 2.4Ghz AP and 5Ghz WDS+AP, it submitted by 5 blinks.

PLEASE NOTE:After each mode set, router reboots for clean connection with new settings.

For work as service code could be placed to script body in section "script to run after fully boot".

Used infinity cycle and mtk_gpio utility for checking reset button push (each 100ms) and for lighting up leds,
corresponding the frequency, which have been configured.

Getting right GPIO pins from board.h for Xiaomi MI MINI and MI-3, here is GPIO section:

#define BOARD_GPIO_BTN_RESET	30
#undef  BOARD_GPIO_BTN_WPS
#undef  BOARD_GPIO_LED_ALL
#undef  BOARD_GPIO_LED_WIFI
#define BOARD_GPIO_LED_POWER	24	/* 24: blue, 26: yellow, 29: red */
#define BOARD_GPIO_LED_LAN	29
#undef  BOARD_GPIO_LED_WAN
#define BOARD_GPIO_LED_USB	26
#undef  BOARD_GPIO_LED_ROUTER
#define BOARD_GPIO_PWR_USB	65
#define BOARD_GPIO_PWR_USB_ON	1	/* 1: 5V Power ON, 0: 5V Power OFF */

So reset button pin is 30 and LED's pins is 24,26 and 29 (i've used 29 only to add red color to blue, so it shows violet).

Please note, that GPIO pins value is inverted, so button is always =1 and if pushed =0. 

The frequency changing by pushing nvram commands.

Credits and links:
Homepage of prometheus script to flash MI-3 to padavan firmware: http://prometheus.freize.net/index.html
Padavan's firmware homepage: https://github.com/andy-padavan/rt-n56u
Web pages of internal web-interface: https://github.com/andy-padavan/rt-n56u/tree/master/trunk/user/www/n56u_ribbon_fixed
(here you could see, which consloe nvram commands corresponds your real actions in web-interface) 
Message from russian forum about mtk_gpio: http://forum.ixbt.com/topic.cgi?id=14:63903:3772#3772
Message from russian forum with right board.h: https://4pda.ru/forum/index.php?s=&showtopic=686221&view=findpost&p=56957226

RU

Скрипт для быстрого переключения режима 2.4Ггц AP + 5Ггц WDS+AP в режим 5Ггц AP + 2.4Ггц WDS+AP коротким нажатием на кнопку reset. 
В качестве подтверждения переключения выбранную частоту с WDS "отбивает" светодиод на передней панели.
При нажатии проверяет, что в настройках и меняет режим в зависимости от текущего - на противоположный. Если в настройках ничего нет (что-то поправили сами или чистая прошивка) включает режим 2.4Ггц WDS+AP по-умолчанию. Далее по очереди.
ВНИМАНИЕ: После каждой смены режима происходит перезагрузка для "чистого" соединения с новыми настройками.
Нужно для быстрого "хопа" с 2.4Ггц WDS на 5Ггц WDS.
