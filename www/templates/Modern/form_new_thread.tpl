[css:posts.css]
[css:postnew.css]
[css:threadnew.css]
[css:navigation.css]

[case:[special:lang]|
  [equ:ttlTitle=Title]
  [equ:phTitle=Thread title]
  [equ:ttlTags=Tags: <span class="small">(max 3, comma separated, no spaces)</span>]
  [equ:phTags=some tags here]
  [equ:ttlLimited=Limited access thread]
  [equ:ttlInvited=Invited users <span class="small">(comma separated list)</span>]
  [equ:phText=Share your thoughts here]
  [equ:ttlAttach=Attach file(s)]
  [equ:phSelect=Select file to attach]
  [equ:btnPreview=Preview]
  [equ:btnSubmit=Submit]
  [equ:btnRevert=Revert]
|
  [equ:ttlTitle=Заглавие]
  [equ:phTitle=Заглавие на темата]
  [equ:ttlTags=Тагове: <span class="small">(макс. 3, разделени със запетаи, без шпации)</span>]
  [equ:phTags=някакви тагове тук]
  [equ:ttlLimited=Тема с ограничен достъп]
  [equ:ttlInvited=Поканени в темата <span class="small">(разделени със запетаи)</span>]
  [equ:phText=Сподели мислите си тук]
  [equ:ttlAttach=Прикачи файл(ове)]
  [equ:phSelect=Избери файл(ове) за прикачане]
  [equ:btnPreview=Преглед]
  [equ:btnSubmit=Запис]
  [equ:btnRevert=Отказ]
|
  [equ:ttlTitle=Название темы]
  [equ:phTitle=Название темы]
  [equ:ttlTags=Ярлыки: <span class="small">(макс. 3, через запятую, без пробелов)</span>]
  [equ:phTags=теги пишутся здесь]
  [equ:ttlLimited=Тема с ограниченным доступом]
  [equ:ttlInvited=Приглашенные участники <span class="small">(список через запятую)</span>]
  [equ:phText=Поделитесь своими мыслями здесь]
  [equ:ttlAttach=Прикрепленные файл(ы)]
  [equ:phSelect=Выберите файл для вложения]
  [equ:btnPreview=Преглед]
  [equ:btnSubmit=Записать]
  [equ:btnRevert=Отказ]
|
  [equ:ttlTitle=Titre]
  [equ:phTitle=Titre du sujet]
  [equ:ttlTags=Mots-clés: <span class="small">(3 maximum, séparés par une virgule t sans espace)</span>]
  [equ:phTags=quelques mots-clés]
  [equ:ttlLimited=Sujet à accès limité]
  [equ:ttlInvited=Inviter des utilisateurs <span class="small">(séparés par une virgule)</span>]
  [equ:phText=Partagez vos idées ici]
  [equ:ttlAttach=Pièce(s) jointe(s)]
  [equ:phSelect=Sélectionner un fichier à attacher]
  [equ:btnPreview=Prévisualiser]
  [equ:btnSubmit=Poster]
  [equ:btnRevert=Annuler]
|
  [equ:ttlTitle=Titel]
  [equ:phTitle=Titel des Themas]
  [equ:ttlTags=Tags: <span class="small">(max. 3, durch Kommas getrennt, keine Leerzeichen)</span>]
  [equ:phTags=hier einige Tags]
  [equ:ttlLimited=Thema mit beschränktem Zugriff]
  [equ:ttlInvited=Eingeladene Mitglieder <span class="small">(durch Kommas getrennt)</span>]
  [equ:phText=Teilen Sie hier Ihre Gedanken mit]
  [equ:ttlAttach=Datei(en) anhängen]
  [equ:phSelect=Wählen Sie eine Datei als Anhang aus]
  [equ:btnPreview=Vorschau]
  [equ:btnSubmit=Absenden]
  [equ:btnRevert=Zurücksetzen]
]

<div class="new_editor">
  <div class="ui">
      <input form="editform" type="hidden" name="ticket" value="[Ticket]" >
      <input form="editform" class="btn" type="submit" name="preview" onclick="this.form.cmd='preview'" value="[const:btnPreview]" >
      <input form="editform" class="btn" type="submit" name="submit" onclick="this.form.cmd='submit'" value="[const:btnSubmit]" >
      <div class="spacer"></div>
      <a class="btn" href=".">
        <svg version="1.1" width="20" viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
         <title>Close</title>
         <rect transform="rotate(45)" x=".635" y="-1.53" width="21.4" height="3.05" rx="1.53" ry="1.53"/>
         <rect transform="rotate(135)" x="-10.7" y="-12.8" width="21.4" height="3.05" rx="1.53" ry="1.53"/>
        </svg>
      </a>
  </div>
  <form id="editform" action="!post" method="post" onsubmit="previewIt(event)" enctype="multipart/form-data">
    <div class="editgroup">
      <div>
        <p>[const:ttlTitle]:</p>
        <input type="text" value="[caption]" placeholder="[const:ttlTitle]" name="title" autofocus>
      </div>
      <div>
        <p>[const:ttlTags] [case:[special:dir]| |+ "[special:dir]"]</p>
        <input type="text" value="[tags]" name="tags" id="tags" placeholder="[const:phTags]" oninput="OnKeyboard(this)" onkeydown="EditKeyDown(event, this)" getlist="/!tagmatch/">
      </div>
    </div>
    <input type="checkbox" id="limited" name="limited" value="1" [case:[limited]||checked]><label for="limited">[const:ttlLimited]</label>
    <div class="editgroup" id="users_invited">
      <div>
        <p>[const:ttlInvited]:</p>
        <input type="text" id="invited" value="[invited]" name="invited" oninput="OnKeyboard(this)" onkeydown="EditKeyDown(event, this)" getlist="/!usersmatch/">
      </div>
    </div>
    [include:edit_toolbar.tpl]
    <textarea class="editor" name="source" id="source" placeholder="[const:phText]">[source]</textarea>
    <div>
      [case:[special:canupload]||<p>[const:ttlAttach]:</p><div class="attach">
      <input type="file" placeholder="[const:phSelect]" name="attach" multiple="multiple" tabindex="-1"></div>]
    </div>
    <div class="attachments">
      [attach_edit:[id]]
    </div>
  </form>
</div>

<script>

function previewIt(e) {

  if (e.target.cmd === "preview") {
    e.preventDefault();

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "!post?cmd=preview");

    xhr.onload = function(event){
      if (event.target.status === 200) {
        var prv = document.getElementById("preview");
        var attch = document.getElementById("attachments");
        var resp = JSON.parse(event.target.response);

        prv.innerHTML = resp.preview;
        attch.innerHTML = resp.attach_del;
      }
      document.getElementById("browse").value = '';
      document.getElementById("source").focus();
    };

    var formData = new FormData(document.getElementById("editform"));
    xhr.send(formData);
  }
}

document.onkeydown = function(e) {
  var key = e.which || e.keyCode;
  var frm = document.getElementById("editform");
  var stop = true;

  if (e.ctrlKey && key == 13) {
    frm.preview.click();
  } else if (key == 27) {
    window.location.href = "!by_id";
  } else if (e.ctrlKey && key == 83) {
    frm.submit.click();
  } else stop = false;

  if (stop) e.preventDefault();
};


</script>


[raw:autocomplete.js]
