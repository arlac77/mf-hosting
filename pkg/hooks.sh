
post_install() {
	systemctl daemon-reload
	systemctl enable {{name}}
	systemctl enable {{name}}.socket
	systemctl start {{name}}.socket
}

post_upgrade() {
	systemctl is-active {{name}} >/dev/null
	ACTIVE=$?
    if [[ $ACTIVE -eq 0 ]]
	then
		systemctl daemon-reload
		systemctl restart {{name}}
		systemctl restart {{name}}.socket
	fi
}

pre_remove() {
	systemctl stop {{name}}.socket
	systemctl disable {{name}}.socket
	systemctl stop {{name}}
	systemctl disable {{name}}
}
