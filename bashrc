# ~/.bashrc: executed by bash(1) for non-login shells.
# .see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If running non interactively, do nothing


########################################################
#|# General                                            #
########################################################

alias dirbashrc="grep -nT '^#|' ~/.bashrc"
alias bashrc="vim ~/.bashrc"



########################################################
#|## Bash, PATH                                        #
########################################################

# put here for early evaluation
alias rebash='source ~/.bashrc'

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}


########################################################
#|## Extra git enhancements                            #
########################################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
elif [ -d ~/.bash_completion ]; then
    echo "Found user bash-completions"
    for fn in ~/.bash_completion/*sh; do
        echo ${fn}
        source ${fn}
    done
fi


# have to stay here before setting PS1
export GIT_PS1_SHOWDIRTYSTATE=true
export export GIT_PS1_SHOWSTASHSTATE=true



# set a fancy prompt
declare -F | grep __git_ps1 > /dev/null
if [ "$?" -eq 0 ]
then
    echo ${platform}
        export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]:\w\[\033[31m\]$(__git_ps1 "(%s)")\[\033[01;34m\]$\[\033[00m\] '
else
    if [[ ${platform} == 'mac' ]]; then
        export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]:\w\[\033[31m\]$(parse_git_branch)\[\033[01;34m\]$\[\033[00m\] '
    else
        export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\]:\w\[\033[31m\]\[\033[01;34m\]$\[\033[00m\] '
    fi
fi

PATH="${HOME}/.local/bin":\
${PATH};

shopt -s cdspell
shopt -s histappend
shopt -s expand_aliases
shopt -s lithist
shopt -s extglob
set show-all-if-ambiguous on

# set bash to vi mode
# (hit ESC for command mode/
#  hit i for insert mode)
#set -o vi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:[cb]d:b:exit:[ ]*"
export HISTSIZE=99999


# enable color support of ls and also add handy aliases
export INPUTRC=~/.inputrc
if [[ ${platform} == 'mac' ]]; then
    export CLICOLOR=YES
    eval `dircolors -b`
    export JAVA_HOME=$(/usr/libexec/java_home)
else
    eval `dircolors -b`
fi

#key bindings

bind '"\M-a"':"\"bd\""
bind '"\M-k"':"\"ls -f\""
# enable smart history search
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
########################################################
#|## Environment                                       #
########################################################

export EDITOR=vim
export FC="/usr/bin/gfortran"
export F2PY_FCOMPILER='gfortran'
export GDFONTPATH="/usr/share/fonts/truetype/latex-xft-fonts/"

########################################################
#|## Aliases, Utiliites                                #
########################################################

# bash sugar
alias ls='ls --color=auto'
alias cdreadlink='cd $(readlink -f .)' # cd to real absolute path
alias ldir='ls -l --color=always | grep -e "^d"'  # list only directories
alias gr='grep'
alias c='clear'
alias ct='printf "\033c"'  # clear terminal
alias l='ls -lhtr --color=auto  --time-style long-iso && pwd'
alias ll='clear && ls -lhtr --color=auto  --time-style long-iso && pwd'
alias ltail='ls -rtlh |  tail -n 20'
alias j='jobs'
alias g='gthumb'
alias d='date'
alias v='vim'
alias rl='readlink -f'
alias eb='vim ~/.bashrc'
alias kk='kill %'

alias sortdu="du -sch .[!.]* * |sort -h"

alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias keyjnote='impressive -T 100 -t CrossFade '
alias git-svn-pull='git svn fetch; git merge git-svn'
alias gitsy='git pull; git push'
alias gy='gitsy'
alias gitst='git st'
alias modularize='touch __init__.py'
alias top='htop -d 1'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."
alias ............="cd ../../../../../../../../../../.."
alias .............="cd ../../../../../../../../../../../.."
alias vb=vboxmanage
alias vh=vboxheadless
alias sd="sudo shutdown -fh now"
alias hk=heroku

# Make the bash feel smoother
# correct common typos
alias sl='ls'
alias iv='vi'
alias vi='vim'
alias dc='cd'
alias tpo='top'
alias otp='top'
alias mem="ps aux | awk '{print \$2, \$4, \$11}' | sort -k2rn | head -n 20"
alias t='top'
alias db='bd'
alias b='bd'
alias rs='./manage.py runserver &'
alias ds='./manage.py shell'
alias dt='./manage.py test'
alias pr='./tools/update_from_git.sh'
alias ks='kmos shell'
alias be='bundle exec'
alias bert='bundle exec rake test'
alias berd='bundle exec rake db:migrate'
alias q='echo "You are not on a queueing system, dummy. Stop checking for running jobs!!!!"'
alias nose=nosetests

# vim
alias vi=vim
alias vim="vim -O"



#alias unlock="python -c 'from ctypes import *; X11 = cdll.LoadLibrary(\"libX11.so.6\"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'"

alias getmyip="curl http://ipecho.net/plain"

function fqpn(){
    if [ "x${1}" == "x" ]
    then
        rel_path="."
    else
        rel_path="${1}"
    fi

    hn=$(hostname -f)
    pn=$(readlink -f ${rel_path} )
    echo ${hn}:${pn}
}

function loclink(){
    if [ "x${1}" == "x" ]
    then
        return
    else
        fn="${1}"
    fi
 cp --remove-destination $(readlink ${fn} ) ${fn}
}

function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}
pantex (){
    pandoc --csl=$(readlink -f ~/src/citation-styles/american-chemical-society.csl ) -sS --bibliography $(echo *.bib) ${1} -o $(basename ${1} .md).pdf
}
function n { seq 1 $1| { shift; xargs -i -- "$@"; } }
function executify(){
file=${1}
if  [ -f ${file} -a ! -x ${file} ]
then
  chmod  755 ${file}
fi
./${file}
}
function pdfbiblatex(){
    for command in pdflatex bibtex pdflatex pdflatex
    do
        ${command} ${1}
    done
}
function pdf_colorpages(){
gs -o - -sDEVICE=inkcov ${1} | grep -v "^ 0.00000  0.00000  0.00000"  | grep -B1 CMYK | grep Page
echo -en "Total pages"
pdfinfo ${1} | grep Pages
}

function pdf_prepress(){
gs -sDEVICE=pdfwrite  -dSAFER -dPDFSETTINGS=/prepress -dNOPAUSE -r150x150 -sOutputFile=$(basename ${1} .pdf)_prepress.pdf -dBATCH ${1}
}
function pdf_printer(){
gs -sDEVICE=pdfwrite  -dSAFER -dPDFSETTINGS=/printer -dUseCIEColor=true -dNOPAUSE -r150x150 -sOutputFile=$(basename ${1} .pdf)_printer.pdf -dBATCH ${1}
}
function pdf_ebook(){
gs -sDEVICE=pdfwrite  -dSAFER -dPDFSETTINGS=/ebook -dNOPAUSE -r150x150 -sOutputFile=$(basename ${1} .pdf)_ebook.pdf -dBATCH ${1}
}
function pdf_screen(){
gs -sDEVICE=pdfwrite  -dSAFER -dPDFSETTINGS=/screen -dNOPAUSE -r150x150 -sOutputFile=$(basename ${1} .pdf)_screen.pdf -dBATCH ${1}
}

function pdf_bw(){
gs  -sOutputFile=$(basename ${1} .pdf)_bw.pdf  -sDEVICE=pdfwrite  -sColorConversionStrategy=Gray -dNOPAUSE -dBATCH  -dProcessColorModel=/DeviceGray  -dCompatibilityLevel=1.4   $(basename ${1} .pdf).pdf < /dev/null
}

function pygraph(){
TMP=$(mktemp -d)
sfood -i ${1} > ${TMP}/SFOOD
sfood-graph ${TMP}/SFOOD > ${TMP}/SFOOD.dot
dot -Tpdf  ${TMP}/SFOOD.dot > SFOOD.pdf
xpdf SFOOD.pdf
rm -rf ${TMP}
}

function note(){
if [ "x${1}" == "x" ]
then
    message='Hello World'
else
    message=${1}
fi
notify-send -u normal -t 10 -i info 'hw' ${1}
}

function rsafevi() {
link_name="${1}.$(date +"%Y%m%d-%H%M%S").$(sudo env | grep SUDO_USER | cut -d= -f 2)"
sudo cp  ${1} ${link_name}
sudo vi ${1}
#if [ ${link_name} -ef  ${1} ]
#then
  #sudo rm ${link_name}
#fi
}
alias rvi=rsafevi
function fname() { find . -name "*$@*"; }
function fregex() { find . -regextype posix-egrep -regex "*$@*"; }
function firegex() { find . -regextype posix-egrep -iregex "*$@*"; }
function finame() { find . -iname "*$@*"; }

function safevi() {
cp  ${1} ${1}.$(date +"%Y%m%d-%H%M%S")
vi ${1}
}
# always use pushd/popd by default
# and if directory turns out to be a file, we open it with vi :-)
function cd() {
  if [ "$#" = "0" ]
  then
  pushd ${HOME} > /dev/null
  elif [ -f "${1}" ]
  then
    ${EDITOR} ${1}
  else
  pushd "$1" > /dev/null
  fi
}

# bd 5 goes 5 directories back in history
function bd(){
  if [ "$#" = "0" ]
  then
    popd > /dev/null
  else
    for i in $(seq ${1})
    do
      popd > /dev/null
    done
  fi
}

function cdup(){
  if [ "$#" = "0" ]
  then
    cd ..
  else
    reldir=''
    for i in $(seq ${1})
    do
      reldir="${reldir}../"
    done
    cd ${reldir}
  fi
}
# bash bookmark manager, credit goes to getmizanur at Stackoverflow
function bm() {
    bookmark_storage="${HOME}/.bookmarks"
    USAGE="Usage: cdb [-c|-g|-d|-l] [bookmark]
    cd -c <bookmark>
        Bookmark the current directory under <bookmark>
    cd -g <bookmark>
        Go to the directory saved under <boomark>
    cd -d <boomark>
        Delete directory under <bookmark>





    " ;
    if  [ ! -e ${bookmark_storage} ] ; then
        mkdir ${bookmark_storage}
    fi

    case $1 in
        # create bookmark
        -c) shift
            if [ ! -f ${bookmark_storage}/$1 ] ; then
                echo "$(pwd)" > ${bookmark_storage}/"$1" ;
            else
                echo "Try again! Looks like there is already a bookmark '$1'"
            fi
            ;;
        # goto bookmark
        -g) shift
            if [ -f ${bookmark_storage}/${1} ] ; then
                cd $(cat ${bookmark_storage}/${1})
            else
                echo "Mmm...looks like your bookmark has spontaneously combusted. What I mean to say is that your bookmark does not exist." ;
            fi
            ;;
        # delete bookmark
        -d) shift
            if [ -f ${bookmark_storage}/$1 ] ; then
                rm ${bookmark_storage}/"$1" ;
            else
                echo "Oops, forgot to specify the bookmark" ;
            fi
            ;;
        # list bookmarks
        -l) shift
            for bookmark in ${bookmark_storage}/*
            do
                echo  "$(basename ${bookmark}) -> $(cat ${bookmark})" ;
            done

            ;;
         *) echo "$USAGE" ;
            ;;
    esac
}

# call pdflatex on a tex file and open with xpdf
function xpdflatex(){
  pdflatex ${1}
  xpdf $(basename ${1} .tex).pdf
}
# standard way to install python package in user space
alias pyuserinstall='python setup.py install --user'

alias line_profile="kernprof.py -lv"

# shortcut for building standalone C program
# from standalone Python script using Cython
function cython-build(){
echo -e $1
cython --verbose --embed $1
gcc -O3 -I/usr/include/python2.7 -o $(basename ${1} .py) $(basename ${1} .py).c -lpython2.7 -lphtread -lm -lutil -ldl
}


# miscellaneous
alias cleanmake='make clean; make'
alias cm='cleanmake'

if [[  ${platform} == 'linux' ]]; then
    alias units='units -e'
fi
alias xmod='xmodmap ~/.xmodmap'

alias pysh='ipython --profile=pysh'

# copy a file to middle mouse-button
alias clip='xclip -selection clipboard'
alias xclip='xclip -selection clipboard'

pman() { # view man pages the fancy way
  tmp=$(mktemp); man -t $1  | ps2pdf - ${tmp} && xpdf -z 'width' -g 1280x1000 ${tmp} && rm ${tmp};
};


alias fuck='$(thefuck $(fc -ln -1))'
alias pysyntax="python -m 'py_compile' "
alias is=inkscape
isexport(){
    if [ "${2}x" = "x" ]
    then
        res=90
    else
        res=${2}
    fi
    seed=$(basename ${1} .svg)
    JPEG2PS_INSTALLED=true
    hash jpeg2ps 2>/dev/null || JPE2PS_INSTALLED=false
    if $JPEG2PS_INSTALLED
    then
        inkscape --export-area-snap  -e ${seed}.png ${1} -d ${res} -b white
        convert ${seed}.{png,jpg}
        jpeg2ps ${seed}.jpg > ${seed}.eps
        epstopdf ${seed}.eps
        # touch up to make it more current than pdf, for paper buildout
        touch ${seed}.eps
    else
        inkscape --export-area-snap -E $(basename ${1} .svg).eps -A $(basename ${1} .svg).pdf -e $(basename ${1} .svg).png ${1} -d ${res}
    fi
}

########################################################
#|# Platform Specifics                                 #
########################################################
########################################################
#|## Mac OS X                                          #
########################################################
if [[ ${platform} == 'mac' ]]; then
    export PATH=~/.cabal/bin:/opt/local/libexec/gnubin:${PATH}:/Users/$(whoami)/Library/Python/2.7/bin/:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin
    export DISPLAY="127.0.0.1:0.0"
    export CDPATH=.:~:~/src:~/stanford:~/phd:~/ssh_mounts
    export GOPATH=~/src/gocode
    export PATH=${PATH}:${GOPATH}/bin
    export PYTHONPATH="${HOME}/.local/lib/python2.7/site-packages/"
    export PATH=${PATH}:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin
    alias xpdf=open
    alias o=open
    alias finder=open
    alias nautilus=open
########################################################
#|## Linux                                             #
########################################################
elif [[ ${platform} == 'linux' ]]; then
    export PATH=${PATH}
    export CDPATH=.:~:~/src

fi

########################################################
#|# Host Specifics                                     #
########################################################



########################################################
#|## Package-Managment APT/Macports                    #
########################################################
# apt-get
if [[ ${platform} == 'mac' ]]; then
    alias clean='sudo port clean'
    alias install='sudo port -v install'
    alias remove='sudo port uninstall'
    alias search='port -v search'
    alias show='port info'
    alias update='sudo port -v selfupdate'
    alias upgrade='sudo port upgrade outdated'
    alias vmd=' /Applications/VMD\ 1.9.2.app/Contents/MacOS/startup.command'
else
    alias autoremove='sudo apt-get autoremove -y'
    alias build-dep='sudo apt-get build-dep'
    alias clean='sudo apt-get clean'
    alias dist-upgrade='sudo apt-get dist-upgrade'
    alias install='sudo apt-get install -y'
    alias purge='sudo apt-get remove --purge'
    alias reinstall='sudo apt-get install --reinstall'
    alias remove='sudo apt-get remove'
    alias search='apt-cache search'
    alias show='apt-cache show'
    alias update='sudo apt-get update'
    alias upgrade='sudo apt-get upgrade'
fi

