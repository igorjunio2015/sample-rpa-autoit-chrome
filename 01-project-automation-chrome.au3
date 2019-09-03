#include "wd_core.au3"
#include "wd_helper.au3"
Local $sDesiredCapabilities, $sSession

SetupChrome()

_WD_Startup()
$sSession = _WD_CreateSession($sDesiredCapabilities)
_WD_Navigate($sSession, "#")

Sleep(4000)

_ChromeSetInputValueById($sSession,'user','#')
_ChromeSetInputValueById($sSession,'password','#')
$sButton = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//button[@id='loginButton']")
_WD_ElementAction($sSession, $sButton, 'click')

Sleep(1000)
$sButton = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//button[@id='disconnectConfirm']")
_WD_ElementAction($sSession, $sButton, 'click')

Sleep(1000)
$sButton = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//li[@id='myTasks']")
_WD_ElementAction($sSession, $sButton, 'click')

Sleep(1000)
_ChromeSetInputValueById($sSession,'searchInput','Execução de atividade')
Send("{ENTER}")

Sleep(2000)
$sFrame = _WD_FrameEnter($sSession, 0)
$sButton = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//span[@title='#']")
MsgBox(0,"","Achou" & $sButton & @CRLF)
_WD_ElementAction($sSession, $sButton, 'click')


Sleep(1000)
$sButton = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//a[@id='btncheck']")
_WD_ElementAction($sSession, $sButton, 'click')
Send("{ENTER}")


_WD_Shutdown()
Func SetupChrome()
	_WD_Option('Driver', 'chromedriver.exe')
	_WD_Option('Port', 9515)
	_WD_Option('DriverParams', '--log-path="' & @ScriptDir * '\chrome.log"')

	$sDesiredCapabilities = '{"capabilities": {"alwaysMatch": {"chromeOptions": {"w3c": true, "args":['& """start-maximized"","&" ""disable-infobars""" & "" & '] }}}}'
 EndFunc

Func _ChromeSetInputValueById($sSession, $Id, $Value)
	$sButton = _WD_FindElement($sSession, $_WD_LOCATOR_ByXPath, "//input[@id='"&$Id&"']")
	_WD_ElementAction($sSession, $sButton, 'value', $Value)
EndFunc