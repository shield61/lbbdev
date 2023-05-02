#!/usr/bin/env bash
printf "%s " "$(tail -n -1 "$HOME/.bash_history")"
printf "\n"
sleep 50
_SOURCEURL=""
_SOURCEBRANCH=""
_SOURCEREPO=""
_SOURCESCRIPT=""

function getInstallCommand() {
    OIFS=$IFS
    IN="$(tail -n -1 "$HOME/.bash_history")"
    #IN="curl -sSL https://raw.githubusercontent.com/shield61/little-backup-box/development/install-little-backup-box.sh | bash  2> install-error.log"
    IFS=' ' read -r -a CMDLINE <<< "$IN"
    for x in "${CMDLINE[@]}"
    do
        if [[ "$x" = *"github"* ]] ; then
            _SOURCEURL=$x
            IFS='/' read -r -a URL <<< "$x"
            _SOURCESCRIPT=${URL[-1]}
            _SOURCEBRANCH=${URL[-2]}
            _SOURCEREPO=${URL[-3]}
        fi
        continue
    done
    IFS=$OIFS
}

if ! [[ $SHELL =~ "bash" ]] ; then
    echo "Calling shell must be bash. Using '$SHELL' is not supported. Terminating!"
    exit 255
fi
getInstallCommand

echo "URL:" "${_SOURCEURL}"
echo "SCRIPTNAME:" "${_SOURCESCRIPT}"
echo "BRANCH:" "${_SOURCEBRANCH}"
echo "REPOSITORY:" "${_SOURCEREPO}"
