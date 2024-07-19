#!/usr/bin/env bash

#Docker File PreReq:
#copy file https://github.com/runtimeacademy/kasm_workspace.git/install_vscode_extensions.sh 
#chmod +x install_vscode_extensions.sh

#Extension identifier
WASP="wasp-lang.wasp"

code --install-extension $WASP
