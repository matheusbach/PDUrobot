#!/usr/bin/env bash
echo "Iniciando Bot ...."
sleep 0.8
clear
echo "Iniciando Bot █▒▒▒▒▒▒▒▒▒ 10%"
sleep 0.3
clear
echo "Iniciando Bot ██▒▒▒▒▒▒▒▒ 20%"
sleep 0.3
clear
echo "Iniciando Bot ███▒▒▒▒▒▒▒ 30%"
sleep 0.3
clear
echo "Iniciando Bot ████▒▒▒▒▒▒ 40%"
sleep 0.3
clear
echo "Iniciando Bot █████▒▒▒▒▒ 50%"
sleep 0.3
clear
echo "Iniciando Bot ██████▒▒▒▒ 60%"
sleep 0.3
clear
echo "Iniciando Bot ███████▒▒▒ 70%"
sleep 0.3
clear
echo "Iniciando Bot ████████▒▒ 80%"
sleep 0.3
clear
echo "Iniciando Bot █████████▒ 90%"
sleep 0.3
clear
echo "Iniciando Bot ██████████ 100%"
sleep 0.7
clear
make_template() {
	find . -name "*.lua" | sort |
		xgettext --from-code=utf-8 \
			--add-comments=TRANSLATORS \
			--package-name=GroupButler \
			--package-version=4.2 \
			--msgid-bugs-address=https://telegram.me/matheusbach \
			--force-po \
			--files-from=/dev/stdin \
			--output=/dev/stdout
}

case $1 in moderador | "")
	while true; do
		lua PDUrobot.lua
		sleep 10
	done

	;; create-locale)
	if [ -z "$2" ]; then
		echo "Using: $0 $1 <locale_name>" >&2
	elif [ -a locales/$2.po ]; then
		echo "Locale exists" >&2
	else
		make_template | msginit --locale=$2 \
			--input=/dev/stdin \
			--output-file=locales/$2.po
	fi
	exit

	;; update-locale)
	if [ -z "$2" ]; then
		echo "Using: $0 $1 <locale_name>" >&2
	else
		make_template | msgmerge --update locales/$2.po /dev/stdin
	fi
	exit
esac

echo "Using: $0 [ bot | create-locale | update-locale ]" >&2
