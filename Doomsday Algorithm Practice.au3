#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.1
 Author: Kenny Allen Christopher Abrahams

 Script Function: Practice the doomsday algorithm

#ce ----------------------------------------------------------------------------

#include <Date.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

#Region ### START Koda GUI section ### Form=
Global $DoomsdayTrainer = GUICreate("Doomsday Algorithm Practice", 277, 311, 233, 124,$WS_POPUPWINDOW, $WS_EX_CONTROLPARENT)
GUISetFont(27, 400, 0, "Roboto")
GUISetBkColor(0xC0C0C0)
Global $dateLabel = GUICtrlCreateLabel("", 13, 20, 256, 50, $SS_CENTER)
GUICtrlSetFont(-1, 30, 400, 0, "Roboto")
Global $sundayButton = GUICtrlCreateButton("Sunday", 8, 83, 123, 49)
GUICtrlSetFont(-1, 12, 800, 0, "Roboto")
Global $mondayButton = GUICtrlCreateButton("Monday", 144, 83, 123, 49) 
GUICtrlSetFont(-1, 12, 800, 0, "Roboto")
Global $tuesdayButton = GUICtrlCreateButton("Tuesday", 8, 139, 123, 49)
GUICtrlSetFont(-1, 12, 800, 0, "Roboto")
Global $wednesdayButton = GUICtrlCreateButton("Wednesday", 144, 139, 123, 49)
GUICtrlSetFont(-1, 12, 800, 0, "Roboto")
Global $thursdayButton = GUICtrlCreateButton("Thursday", 8, 195, 123, 49)
GUICtrlSetFont(-1, 12, 800, 0, "Roboto")
Global $fridayButton = GUICtrlCreateButton("Friday", 144, 195, 123, 49)
GUICtrlSetFont(-1, 12, 800, 0, "Roboto")
Global $saturdayButton = GUICtrlCreateButton("Saturday", 76, 251, 123, 49)
GUICtrlSetFont(-1, 12, 800, 0, "Roboto")
Global $checkDateButton = GUICtrlCreateButton("?", 8, 251, 59, 49)
Global $randomDateButton = GUICtrlCreateButton("Q", 207, 251, 59, 49)
GUICtrlSetFont(-1, 27, 400, 0, "Wingdings 3")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $randomDayOfWeek = 0

GenerateRandomDate()

While 1
  $nMsg = GUIGetMsg()
  Switch $nMsg
    Case $GUI_EVENT_CLOSE
      Exit
    Case $randomDateButton
      GenerateRandomDate()
      ResetButtonColors()
    Case $checkDateButton
      CheckDayOfWeek()
    Case $sundayButton To $saturdayButton
      CheckSelectedDay($nMsg)
  EndSwitch
WEnd

Func GenerateRandomDate()
  Global $randomDay, $randomMonth, $randomYear, $randomDate

  $randomDay = StringFormat("%02d", Random(1, 31, 1))
  $randomMonth = StringFormat("%02d", Random(1, 12, 1))
  $randomYear = Random(1800, 2100, 1)

  $randomDate = $randomDay & "/" & $randomMonth & "/" & $randomYear

  $validateDate = _DateIsValid($randomYear & "/" & $randomMonth & "/" & $randomDay) 

  if $validateDate = 1 then
  GUICtrlSetData($dateLabel, $randomDate)
  ; Get the day of the week for the generated date
  Local $date = StringSplit($randomDate, "/")
  $randomDayOfWeek = _DateToDayOfWeek($date[3], $date[2], $date[1])
  Else
    GenerateRandomDate()
  Endif
EndFunc

Func CheckDayOfWeek()
  Local $ranGenDate = GUICtrlRead($dateLabel)
  If $ranGenDate <> "" Then
    Local $date = StringSplit($ranGenDate, "/")
    Local $dayOfWeek = _DateToDayOfWeek($date[3], $date[2], $date[1])
    Local $dayName = ""
    Switch $dayOfWeek
      Case 1 
        $dayName = "Sunday"
      Case 2
        $dayName = "Monday"
      Case 3
        $dayName = "Tuesday"
      Case 4
        $dayName = "Wednesday"
      Case 5
        $dayName = "Thursday"
      Case 6
        $dayName = "Friday"
      Case 7
        $dayName = "Saturday"
    EndSwitch
    $nextDate = MsgBox(0, "Day of the Week", $ranGenDate & " - " & $dayName,4)
      GenerateRandomDate()
      ResetButtonColors()
  EndIf
EndFunc

Func CheckSelectedDay($btn)
  Local $date = GUICtrlRead($dateLabel)
  Local $selectedDayOfWeek
  Switch $btn
    Case $sundayButton
      $selectedDayOfWeek = 1
    Case $mondayButton
      $selectedDayOfWeek = 2
    Case $tuesdayButton
      $selectedDayOfWeek = 3
    Case $wednesdayButton
      $selectedDayOfWeek = 4
    Case $thursdayButton
      $selectedDayOfWeek = 5
    Case $fridayButton
      $selectedDayOfWeek = 6
    Case $saturdayButton
      $selectedDayOfWeek = 7
  EndSwitch

  If $selectedDayOfWeek = $randomDayOfWeek Then
    GUICtrlSetBkColor($btn, 0x00FF00) ; Green if correct
    CheckDayOfWeek()
  Else
    GUICtrlSetBkColor($btn, 0xFF0000) ; Red if wrong
  EndIf
  
EndFunc

Func ResetButtonColors()
  local $dayButtons[7] = [$sundayButton,$mondayButton,$tuesdayButton,$wednesdayButton,$thursdayButton,$fridayButton,$saturdayButton]

  For $i = 0 to Ubound($dayButtons) - 1
    GUICtrlSetStyle($dayButtons[$i],$GUI_SS_DEFAULT_BUTTON)
  Next  

EndFunc