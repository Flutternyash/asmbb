[css:thread_list.css]

[case:[special:lang]|
  [equ:btnNewThread=New Thread]
  [equ:btnMarkRead=Mark all as read]
|
  [equ:btnNewThread=Нова тема]
  [equ:btnMarkRead=Маркирай всички]
|
  [equ:btnNewThread=Новая тема]
  [equ:btnMarkRead=Отметить все]
|
  [equ:btnNewThread=Nouveau sujet]
  [equ:btnMarkRead=Tout marquer comme lu]
|
  [equ:btnNewThread=Neues Thema]
  [equ:btnMarkRead=Alle als gelesen kennzeichnen]
]


<table class="toolbar"><tr>
  [case:[special:userid]|<td><a class="btn" href="/!login">[const:btnNewThread]</a></td>|<td><a class="btn" href="!markread">[const:btnMarkRead]</a></td><td><a class="btn" href="!post">[const:btnNewThread]</a></td>]
  <td class="spacer"></td>
</tr></table>
