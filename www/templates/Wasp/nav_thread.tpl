[css:navigation.css]
[css:posts.css]
[css:markdown.css]

[case:[special:lang]|
  [equ:btnCats=Categories]
  [equ:btnList=Threads]
  [equ:btnNewPost=Answer]
  [equ:btnSettings=Settings]
  [equ:btnConsole=SQL console]
  [equ:ttlEditThread=Edit the thread attributes.]
  [equ:altEdit=Edit]
|
  [equ:btnCats=Категории]
  [equ:btnList=Теми]
  [equ:btnNewPost=Отговор]
  [equ:btnSettings=Настройки]
  [equ:btnConsole=SQL конзола]
  [equ:ttlEditThread=Редактиране на атрибутите на темата.]
  [equ:altEdit=Редактиране]
|
  [equ:btnCats=Категории]
  [equ:btnList=Темы]
  [equ:btnNewPost=Ответить]
  [equ:btnSettings=Настройки]
  [equ:btnConsole=SQL конзоль]
  [equ:ttlEditThread=Редакция атрибутов темы]
  [equ:altEdit=Редакция]
|
  [equ:btnCats=Catégories]
  [equ:btnList=Liste des sujets]
  [equ:btnNewPost=Répondre]
  [equ:btnSettings=Paramètres]
  [equ:btnConsole=Console SQL]
  [equ:ttlEditThread=Éditer le titre du sujet et les mots-clés.]
  [equ:altEdit=Éditer]
]

<div class="ui">
  <a class="ui left" href="/!categories">[const:btnCats]</a>
  <a class="ui left" href="..">[const:btnList]</a>
  [case:[special:canpost]| |<a class="ui left" href="!post">[const:btnNewPost]</a>]
  <span class="spacer"></span>
  [case:[special:isadmin] | |
    <a class="ui right" href="/!settings[special:urltag]">[const:btnSettings]</a>
    <a class="ui right" href="/!sqlite">[const:btnConsole]</a>
  ]
</div>
<h1 class="thread_caption">[caption] [case:[special:canedit]| |<a href="!edit_thread" title="[const:ttlEditThread]"><img src="[special:skin]/_images/edit.svg" alt="[const:altEdit]"></a>]</h1>
<ul class="thread_tags">[special:threadtags=[id]]</ul>
