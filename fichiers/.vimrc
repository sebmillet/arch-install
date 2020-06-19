" ~/.vimrc ou ~/_vimrc de Sébastien Millet

let mapleader='&'
set encoding=utf-8

" Pour Windows
filetype plugin indent on
set runtimepath+=~/_vim
set viewdir=~/_vim/view

syntax on

hi Normal guibg=palegreen1
" palegreen1
" lightgreen
" lavender
" lavenderblush1
" thistle2
" paleturquoise1
if has('gui_running')
"    color peachpuff
else
    color blue
endif
" hi Normal guibg=#ffebd9

set lines=30 columns=100

hi Pmenu guibg=white guifg=black ctermbg=white ctermfg=black
hi PmenuSel guibg=darkred guifg=white gui=bold ctermbg=darkred ctermfg=white
hi PmenuSbar guibg=white guifg=darkred ctermbg=white ctermfg=darkred
hi PmenuThumb guibg=white guifg=darkblue ctermbg=white ctermfg=darkred

" adfind.vim : affiche les propriétés du compte AD en utilisant le programme
" adfind.
command! F :runtime macros/adfind.vim|:call F_Prepare()
command! -nargs=1 -complete=file Fe1 :call F_Exec(<args>)
command! -nargs=0 Fe :call F_Exec("")

"map <M-F3> :set spell!<CR>
"noremap <F3> ]s
"noremap <S-F3> [s
"map <C-F3> z=
"map <F4> zg
map <silent> <F3> :cnext<CR>
map <silent> <S-F3> :cprevious<CR>

"map <F11> :make CFLAGS="-Wall -Wconversion -Wshadow"<CR>
map <F11> :make<CR>
map <F12> :cw<CR>

map <silent> <C-F8> :/\(.\%>81v\\|\s$\\|\t\)/<CR>

" Coller des en-têtes d'email et les colorer syntaxiquement
" Lié à syntax/rh.vim
map <silent> <S-F8> "+P:set filetype=rh<CR>:set buftype=nofile<CR>

map <silent> <M-F8> :Responses<CR>
map <M-m> gg"+yG

" Ouvre le fichier personnel .vimrc en édition
map <silent> <Leader>m :tabnew $MYVIMRC<CR>

" Affiche/enlève le menu et la barre d'outil (gvim)
map <silent> <C-F2> :
    \ if &guioptions =~# 'T' \|
    \     set guioptions-=T \|
    \     set guioptions-=m \|
    \ else \|
    \     set guioptions+=T \|
    \     set guioptions+=m \|
    \ endif<CR>
set guioptions-=T
set guioptions-=m

" Affiche/enlève une barre de défilement horizontale en bas
map <silent> <S-F2> :
    \ if &guioptions=~# 'b' \|
    \     set guioptions-=b \|
    \ else \|
    \     set guioptions+=b \|
    \ endif<CR>

" Dates US (m/d/y) -> FR (d/m/y)
map <F9> "+pggdd:%s!00/00/0000.*$!!e<CR>:
    \ %s!\v^(\d\d)/(\d\d)/(\d\d\d\d).*$!\2/\1/\3!e<CR>:
    \ %s!\v^(\d\d\d\d)(\d\d)(\d\d)\d\d\d\d\d\d\.0Z$!\3/\2/\1!e<CR>gg"+yG
" Dates US (m/d/y) -> US (m/d/y)
map <M-F9> "+pggdd:%s!00/00/0000.*$!!e<CR>:
    \ %s!\v^(\d\d)/(\d\d)/(\d\d\d\d).*$!\1/\2/\3!e<CR>:
    \ %s!\v^(\d\d\d\d)(\d\d)(\d\d)\d\d\d\d\d\d\.0Z$!\2/\3/\1!e<CR>gg"+yG

map Q gq
noremap gQ Q
map <Space> W
map <Backspace> B

" Map, mode insertion
map! <C-H> <C-R>=strftime("%H:%M:%S")<CR>
map! <C-F> <C-R>=strftime("%d/%m/%y")<CR>
map! <C-G> <C-R>=strftime("%Y%m%d%H%M%S")<CR>

" Map, mode normal
map <silent> <F2> :noh<CR>
map <silent> <S-F1> :set list!<CR>
map <C-W><C-T> <C-W>T
map <C-Q> :tab new<CR>
map <Leader>t :tab new<CR>
map <M-q> :tabmove 0<CR>
map <C-H> :tab h<CR>
map <Leader>h :tab h<CR>
map <M-w> gT
map <M-x> gt
map <Leader>: gT
map <Leader>! gt
map <M-e> :Texplore<CR>
map <Leader>e :Texplore<CR>
map <Leader>q <C-W>q
map <Leader>o <C-W>o
map <Leader>z <C-W>z
map <Leader>- <C-W>-
map <Leader>= <C-W>=
map <Leader>_ <C-W>_
map <Leader>+ <C-W><C-+>
  " Permet de parcourir les lignes telles qu'affichées à l'écran
  " (utile si l'option wrap est activée)
map <Up> gk
map <Down> gj
  " Début et fin de ligne tel qu'à l'écran (utile si l'option wrap est
  " activée)
map <Home> g^
map <End> g$
map <M-Up> zk
map <M-Down> zj

map <M-z> <C-]>
map <C-Z> <C-]>
map <M-a> <C-T>

" Lié à plugin/EnhancedCommentify.vim
map <M-c> <Plug>Traditionalj
map <M-d> <Plug>Traditional
map <S-M-c> <Plug>Commentj
map <S-M-d> <Plug>DeComment

" <Leader>y copie le mot à l'endroit du curseur,
" <Leader>p colle le texte du registre par défaut ("") à la place du mot sous
" le curseur.
" <Leader><Leader> (en mode normal) passe en mode visuel et sélectionne le mot
" sous le curseur, ensuite dans le mode visuel, <Leader><Leader> remplace la
" sélection actuelle par le contenu du registre par défaut ("".) Ainsi une
" fois que l'on a copié un mot donné (que ce soit par <Leader>y ou autre), en
" appyant quatre fois sur <Leader>, le mot est remplacé par le contenu du
" registre par défaut.
map <Leader>y yiw
map <Leader>Y yiW
map <Leader>p "_ciw<C-R>"<Esc>
map <Leader>P "_ciW<C-R>"<Esc>
map <Leader><Leader> viw
map <Leader>1 viW
map <Leader>v viw
map <Leader>V viW
vmap <Leader><Leader> "_c<C-R>"<Esc>

noremap <silent> <M-Left> (
noremap <silent> <M-Right> )
noremap <silent> <M-Up> {
noremap <silent> <M-Down> }

vmap <C-Up> dkP'[V']
vmap <C-Down> dp'[V']
vmap <C-Left> <gv
vmap <C-Right> >gv

set autoindent
set smartindent
set cindent

set ignorecase
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set linebreak
set startofline
set modeline
set autochdir
"set undofile
set matchpairs+=<:>

set fo=tcrqnj

set ruler
set nobackup

set timeout
set timeoutlen=1000
set ttimeout
set ttimeoutlen=200

  " Affiche une barre de menu juste au-dessus de la ligne de commande durant
  " la complétion automatique
set wildmenu
  " N'ajoute pas de deuxième espace après ., ? et ! lorsque deux lignes sont
  " jointes (commande J)
set nojoinspaces
  " Les recherches ne cyclent pas dans le fichier
" set nowrapscan
  " Démarre les recherches durant la frappe
set incsearch
  " Montre les commandes (mode normal) en cours de saisie
set showcmd
  " Nombre de lignes de la ligne de commande
set cmdheight=1
  " Demande confirmation d'enregistrer au lieu de produire une erreur
set confirm
  " Scroller avant d'avoir atteint le haut ou le bas de l'écran : c'est
  " possible !
set scrolloff=2
  " Toujours afficher la ligne status
set laststatus=2
  " Ma propre ligne status - proche de l'original mais affiche le type de
  " fichier à droite (option filetype)
set statusline=%1*%m%*\ %<%F\ %r%=\ %y[%{&ff}]\ \|%03.3b\|0x%02.2B\|\ %-14.(%l,%c%V%)\ <%L>\ %P
highlight User1 term=inverse,bold cterm=inverse,bold ctermfg=red gui=inverse,bold guifg=red
  " Le mode 'list' est affiché de manière plus lisible
set listchars=tab:>-,trail:●,nbsp:°,eol:$,extends:…,space:.
  " Pour que le remplacement soit immédiat si on sélectionne du texte à la
  " souris
set selectmode=mouse,key
  " Casse gérée élégamment lors de la complétion
set infercase
  " Mode virtuel en mode block, c'est plus agréable
set virtualedit=block
  " Là où la touche Suppression est autorisée à supprimer en mode insertion
set backspace=indent,eol,start
  " Pour passer d'une ligne à l'autre en mode insertion, avec <Left> et
  " <Right>
set whichwrap+=[,],<,>
  " Pour enlever le caractère '=' des caractères se trouvant dans un fichier.
  " Bien sûr un nom de fichier peut contenir le caractrère '=', mais c'est
  " rare et il est par contre fréquent d'utiliser la complétion pour un
  " fichier écrit tout de suite (sans espace) après le signe '='.
  " La complétion se fait avec i_CTRL-X_CTRL-F
set isfname-==

" Options - GUI

  " L'option c dans guioptions impose d'utiliser la fenêtre Vim pour poser
  " des questions plutôt que l'interface graphique. Intérêt : les raccourcis
  " clavier fonctionnent.
set guioptions+=c
  " Demande à l'interface GUI d'ignorer les combinaisons Alt- pour accéder au
  " menu (permet de mapper <M-...> sans limitation.)
set winaltkeys=no
  " Font GUI
  " Windows
"set guifont=Consolas:h9
"set linespace=0
  " Linux
"set guifont=Monospace\ 12
set guifont=Monospace\ 10

" Options - TAGs

  " La double étoile indique d'inclure tous les sous-répertoires,
  " récursivement
"set path+=~/travail/**
  " Pour aller chercher automatiquement les fichiers tags au-dessus
"set tags+=./../tags

" Options - Correction orthographique

  " Pour simplifier la correction orthographique (un clic droit de la souris
  " fait apparaître un menu contextuel pour corriger le mot)
set mousemodel=popup_setpos
  " J'écris en français le plus souvent
set spelllang=fr
  " Tout un écran de suggestions, je trouve ça inutile. 8, c'est très bien
set spellsuggest=best,8

  " Les fonctions Smt_BufWritePre_backup_options() et
  " Smt_BufWritePre_backup_options() dont définies dans /etc/vim/vimrc.local
"au BufWritePre ~/.vim/* call Smt_BufWritePre_backup_options()
"au BufWritePost ~/.vim/* call Smt_BufWritePost_backup_options()
"au BufWritePre ~/.vimrc call Smt_BufWritePre_backup_options()
"au BufWritePost ~/.vimrc call Smt_BufWritePost_backup_options()

  " To have Vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                     \ exe "normal! g'\"" | endif
endif

" Tiré de 'Hacking Vim 7.2'
" Pour modifier l'affichage des titres de tabs
function! ShortTabLine()
    let ret = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let ret .= '%#errorMsg#'
        else
            let ret .= '%#TabLine#'
        endif
        let buflist = tabpagebuflist(i + 1)
        let winnr = tabpagewinnr(i + 1)
        let buffername = bufname(buflist[winnr - 1])
        let filename = fnamemodify(buffername, ':t')
        if filename == ''
            let filename = 'noname'
        endif
        if strlen(filename) >= 12
            let ret .= '[' . filename[0:9] . '..]'
        else
            let ret .= '[' . filename . ']'
        endif
    endfor
    let ret .= '%#TabLineFill#%T'
    return ret
endfunction
set tabline=%!ShortTabLine()

  " Idem ci-dessus, mais pour le GUI
function! ShortTabLabel()
    let bufnrlist = tabpagebuflist(v:lnum)
    let plus = ''
    "
    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let plus = '+ '
            break
        endif
    endfor

    let label = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    let filename = fnamemodify(label, ':t')
    if strlen(filename) >= 12
        let ret = filename[0:9] . '..'
    else
        let ret = filename
    endif
    return plus . ret
endfunction
set guitablabel=%{ShortTabLabel()}

  " Tooltip s'affichant sur les tabs, en GUI
function! InfoGuiTooltip()
    let bufferlist = ''
    let nl=''
    for i in tabpagebuflist()
        let bufferlist .= nl . fnamemodify(bufname(i), ':p:~')
        let nl = "\n"
    endfor
    return bufferlist
endfunction
set guitabtooltip=%!InfoGuiTooltip()

  " Tooltip en GUI, général. S'il y a un fold, affiche le contenu du fold, sinon
  " affiche la suggestion orthographique (si mot mal orthographié.)
function! FoldSpellBalloon()
    let foldStart = foldclosed(v:beval_lnum)
    let foldEnd = foldclosedend(v:beval_lnum)
    let lines = []
    if foldStart < 0
          " Nous ne sommes pas sur un fold
        let lines = spellsuggest(spellbadword(v:beval_text)[0], 5, 0)
    else
          " Nous sommes dans un fold
        let numLines = foldEnd - foldStart + 1
        if numLines > 31
            let lines = getline(foldStart, foldStart + 14)
            let lines += ['-- (' . (numLines - 30) . ') lignes --']
            let lines += getline(foldEnd - 14, foldEnd)
        else
            let lines = getline(foldStart, foldEnd)
        endif
    endif
    return join(lines, has("balloon_multiline") ? "\n" : "")
endfunction
set balloonexpr=FoldSpellBalloon()
set ballooneval

function! RemoveAccents(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"

    if a:0  " Invoked from Visual mode, use '< and '> marks.
        silent exe "'<,'>substitute/\\C\\và|â|ä/a/ge"
        silent exe "'<,'>substitute/\\C\\vÀ|Â|Ä/A/ge"
        silent exe "'<,'>substitute/\\C\\vé|è|ê|ë/e/ge"
        silent exe "'<,'>substitute/\\C\\vÉ|È|Ê|Ë/E/ge"
        silent exe "'<,'>substitute/\\C\\vî|ï/i/ge"
        silent exe "'<,'>substitute/\\C\\vÎ|Ï/I/ge"
        silent exe "'<,'>substitute/\\C\\vô|ö/o/ge"
        silent exe "'<,'>substitute/\\C\\vÔ|Ö/O/ge"
        silent exe "'<,'>substitute/\\C\\vù|û|ü/u/ge"
        silent exe "'<,'>substitute/\\C\\vÙ|Û|Ü/U/ge"
    elseif a:type == 'line'
        silent exe "'[,']substitute/\\C\\và|â|ä/a/ge"
        silent exe "'[,']substitute/\\C\\vÀ|Â|Ä/A/ge"
        silent exe "'[,']substitute/\\C\\vé|è|ê|ë/e/ge"
        silent exe "'[,']substitute/\\C\\vÉ|È|Ê|Ë/E/ge"
        silent exe "'[,']substitute/\\C\\vî|ï/i/ge"
        silent exe "'[,']substitute/\\C\\vÎ|Ï/I/ge"
        silent exe "'[,']substitute/\\C\\vô|ö/o/ge"
        silent exe "'[,']substitute/\\C\\vÔ|Ö/O/ge"
        silent exe "'[,']substitute/\\C\\vù|û|ü/u/ge"
        silent exe "'[,']substitute/\\C\\vÙ|Û|Ü/U/ge"
    elseif a:type == 'block'
        silent exe "'[,']substitute/\\C\\và|â|ä/a/ge"
        silent exe "'[,']substitute/\\C\\vÀ|Â|Ä/A/ge"
        silent exe "'[,']substitute/\\C\\vé|è|ê|ë/e/ge"
        silent exe "'[,']substitute/\\C\\vÉ|È|Ê|Ë/E/ge"
        silent exe "'[,']substitute/\\C\\vî|ï/i/ge"
        silent exe "'[,']substitute/\\C\\vÎ|Ï/I/ge"
        silent exe "'[,']substitute/\\C\\vô|ö/o/ge"
        silent exe "'[,']substitute/\\C\\vÔ|Ö/O/ge"
        silent exe "'[,']substitute/\\C\\vù|û|ü/u/ge"
        silent exe "'[,']substitute/\\C\\vÙ|Û|Ü/U/ge"
    else
        silent exe "'[,']substitute/\\C\\và|â|ä/a/ge"
        silent exe "'[,']substitute/\\C\\vÀ|Â|Ä/A/ge"
        silent exe "'[,']substitute/\\C\\vé|è|ê|ë/e/ge"
        silent exe "'[,']substitute/\\C\\vÉ|È|Ê|Ë/E/ge"
        silent exe "'[,']substitute/\\C\\vî|ï/i/ge"
        silent exe "'[,']substitute/\\C\\vÎ|Ï/I/ge"
        silent exe "'[,']substitute/\\C\\vô|ö/o/ge"
        silent exe "'[,']substitute/\\C\\vÔ|Ö/O/ge"
        silent exe "'[,']substitute/\\C\\vù|û|ü/u/ge"
        silent exe "'[,']substitute/\\C\\vÙ|Û|Ü/U/ge"
    endif
    let &selection = sel_save
endfunction

nmap <silent> <Leader>a :set opfunc=RemoveAccents<CR>g@
vmap <silent> <Leader>a :<C-U>call RemoveAccents(visualmode(), 1)<CR>

"
" Pour tester la fonction de suppression des caractères accentués
"
" a grave :        à   a circonf. :     â   a trema :        ä   a maj grave : À
" a maj circonf. : Â   a maj trema :    Ä   e aigu :         é   e grave :     è
" e circonf. :     ê   e trema :        ë   e maj aigu :     É   e maj grave : È
" e maj circonf. : Ê   e maj trema :    Ë   i circonf. :     î   i trema :     ï
" i maj circonf. : Î   i maj trema :    Ï   o circonf. :     ô   o trema :     ö
" o maj circonf. : Ô   o maj trema :    Ö   u grave :        ù   u circonf. :  û
" u trema :        ü   u maj grave :    Ù   u maj circonf. : Û   u maj trema : Ü
"

" The CountChars command counts the number of characters in the current line
" (or in the line range specified before the command) and appends it to the
" end of the line, after adding a tab character as well.
function! CountChars()
    let n = len(getline("."))
    exe "normal A\t" . n
endfunction

command! -range CountChars <line1>,<line2>call CountChars()

command! Follow set updatetime=1000 | autocmd CursorHold <buffer> edit!
                \| exe "normal G" | call feedkeys("0")
command! StopFollow autocmd! CursorHold <buffer>

autocmd BufEnter *.pm :syntax sync fromstart

" Trouvé ici :
"   https://stackoverflow.com/questions/2345519/
"           how-can-i-script-vim-to-run-perltidy-on-a-buffer
"define :Tidy command to run perltidy on visual selection || entire buffer"
command -range=% -nargs=* Tidy <line1>,<line2>!perltidy

"run :Tidy on entire buffer and return cursor to (approximate) original position
fun DoTidy()
    let l = line(".")
    let c = col(".")
    :Tidy
    call cursor(l, c)
endfun

"shortcut for normal mode to run on entire buffer then return to current line"
au Filetype perl nmap <F8> :call DoTidy()<CR>

"shortcut for visual mode to run on the the current visual selection"
au Filetype perl vmap <F8> :Tidy<CR>

command! Responses
    \ e ~\OneDrive\ -\ Constellium\Documents\Principal\modèles\ texte\m2.txt
    \| vnew ~\OneDrive\ -\ Constellium\Documents\Principal\modèles\ texte\m1.txt

