#!/bin/bash

export XSOCK=/tmp/.X11-unix
export XAUTH=/tmp/.docker.xauth

touch ${XAUTH}
xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | uniq | xauth -f ${XAUTH} nmerge -

DISPLAY2=$(echo $DISPLAY | sed s/localhost//)
if [ $DISPLAY2 != $DISPLAY ]
then
        export DISPLAY=$DISPLAY2
        xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | uniq | xauth -f ${XAUTH} nmerge -
fi

ARGS=$(echo $@ | sed 's/[^a-zA-Z0-9_.-]//g')

docker run \
	--network=host \
	--user=root \
        -v ${XSOCK}:${XSOCK} \
        -v ${XAUTH}:${XAUTH} \
        -e XAUTHORITY=${XAUTH} \
        -e DISPLAY=${DISPLAY} \
	-e EMU='-v -g1024x768 -s' \
	--security-opt label=type:container_runtime_t \
	-it b94a38b37b4f \
	bash

	#-it 62473828d9c3 \
	#bash

	
	#emu -c1 wm/wm

# EMU='-v -g1024x768 -s' 
