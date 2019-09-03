#include "wd_core.au3"
#include "wd_helper.au3"
Local $sDesiredCapabilities, $sSession
SetupChrome()

_WD_Startup()
$sSession = _WD_CreateSession($sDesiredCapabilities)
_WD_Navigate($sSession, "https://www.facebook.com")
_ChromeSetInputValueById($sSession,'email','abc')
_ChromeSetInputValueById($sSession,'pass','xyz')
_WD_Shutdown()

Func SetupChrome()
    _WD_Option('Driver', 'chromedriver.exe')
    _WD_Option('Port', 9515)
    _WD_Option('DriverParams', '--log-path="' & @ScriptDir & '\chrome.log"')

    $sDesiredCapabilities = '{"capabilities": {"alwaysMatch": {"chromeOptions": {"w3c": true, "args":[' & """start-maximized""," & " ""disable-infobars""" & "" & '] }}}}'
EndFunc   ;==>SetupChrome
Func _ChromeSetInputValueById($sSession,$Id,$Value)
 $sButton = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//input[@id='"&$Id&"']")
 _WD_ElementAction($sSession,$sButton,'value', $Value)
EndFunc
