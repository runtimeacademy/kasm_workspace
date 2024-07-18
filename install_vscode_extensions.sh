#!/bin/bash

#Docker File PreReq:
#copy file https://github.com/runtimeacademy/kasm_workspace.git/install_vscode_extensions.sh 
#chmod +x install_vscode_extensions.sh

# Extension identifier
WASP="wasp-lang.wasp"
PRISMA="prisma.prisma"


code --install-extension $WASP

code --install-extension $PRISMA
