#!/bin/bash

# Define o caminho do jogo
XDG_DATA_HOME="/storage/roms/ports/annelids/save"
export XDG_DATA_HOME
GAMEDIR="/storage/roms/ports/annelids"
cd "$GAMEDIR"

# Configura o mapeamento de controles do R36S (teclado virtual para os analógicos)
# O gptokeyb traduz os botões físicos em eventos que o jogo Android entende
export GST_REGISTRY_FOR_USER="$GAMEDIR/gstreamer-1.0/registry.bin"
./gptokeyb -c "annelids.gptk" &

# Força o uso da biblioteca gráfica OpenGL ES 2 do R36S
export SDL_VIDEO_GL_DRIVER="libGLESv2.so"
export SDL_VIDEO_EGL_DRIVER="libEGL.so"

# Dispara o carregador genérico injetando o Annelids
./fakeandroid libannelids.so 2>&1 | tee log.txt

# Fecha o mapeador de controles ao encerrar o jogo
killall -9 gptokeyb
unset LD_PRELOAD
