[css:navigation.css]
[css:posts.css]
[css:postnew.css]

[case:[special:lang]|
  [equ:btnList=Thread list]
  [equ:btnThread=Thread]
  [equ:ttlTitle=Thread title]
  [equ:ttlPost=Post content]
  [equ:phText=Someone is wrong on the Internet]
  [equ:ttlAttach=Attach file(s)]
  [equ:phSelect=Select file to attach]
  [equ:btnPreview=Preview]
  [equ:btnSubmit=Submit]
  [equ:btnRevert=Revert]
|
  [equ:btnList=Списък теми]
  [equ:btnThread=Тема]
  [equ:ttlTitle=Заглавие на темата]
  [equ:ttlPost=Съобщение]
  [equ:phText=Някой в Интернет греши]
  [equ:ttlAttach=Прикачи файл(ове)]
  [equ:phSelect=Избери файл(ове) за прикачане]
  [equ:btnPreview=Преглед]
  [equ:btnSubmit=Запис]
  [equ:btnRevert=Отказ]
|
  [equ:btnList=Список тем]
  [equ:btnThread=Тема]
  [equ:ttlTitle=Название темы]
  [equ:ttlPost=Текст сообщения]
  [equ:phText=В Интернете кто-то неправ]
  [equ:ttlAttach=Прикрепленные файл(ы)]
  [equ:phSelect=Выберите файл для вложения]
  [equ:btnPreview=Преглед]
  [equ:btnSubmit=Записать]
  [equ:btnRevert=Отказ]
|
  [equ:btnList=Liste des sujets]
  [equ:btnThread=Sujet]
  [equ:ttlTitle=Titre du sujet]
  [equ:ttlPost=Contenu du message]
  [equ:phText=Someone is wrong on the Internet]
  [equ:ttlAttach=Pièce(s) jointe(s)]
  [equ:phSelect=Select file to attach]
  [equ:btnPreview=Prévisualiser]
  [equ:btnSubmit=Poster]
  [equ:btnRevert=Annuler]
]

<div class="new_editor">
  <div class="ui">
    <a class="ui left" href="[case:[special:page]||../]../">[const:btnList]</a>
    <a class="ui left" href="[case:[special:page]|./|!by_id]">[const:btnThread]</a>
  </div>
  <form id="editform" action="!post#preview" method="post" enctype="multipart/form-data">
    <p>[const:ttlTitle]:</p>
    <h1 class="fakeedit">[caption]</h1>
    [include:edit_toolbar.tpl]
    <p>[const:ttlPost]:</p>
    <textarea class="editor" name="source" id="source" placeholder="[const:phText]">[source]</textarea>
    [case:[special:canupload]||<p class="panel">[const:ttlAttach]:</p><div class="attach"><input type="file" placeholder="[const:phSelect]" name="attach" multiple="multiple" tabindex="-1"></div>]
    <div class="attachments">
      [attach_edit:[id]]
    </div>
    <div class="panel">
      <input type="submit" name="preview" value="[const:btnPreview]" >
      <input type="submit" name="submit" value="[const:btnSubmit]" >
      <input type="hidden" name="ticket" value="[Ticket]" >
      <input type="reset" value="[const:btnRevert]" >
    </div>
  </form>
</div>
