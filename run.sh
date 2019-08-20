#!/bin/sh

IMAGE=image
SCENE=scene

yes | makescene -i $IMAGE $SCENE
sfmrecon $SCENE
dmrecon -s2 $SCENE
scene2pset -F2 $SCENE $SCENE/pset-L2.ply
fssrecon $SCENE/pset-L2.ply $SCENE/surface-L2.ply
meshclean -t10 $SCENE/surface-L2.ply $SCENE/surface-L2-clean.ply
