#!/bin/make -f

build:
	make -C libs/androidfw -f ../../debian/libandroidfw.mk
	make -C tools/aapt -f ../../debian/aapt.mk
	make -C tools/aidl -f ../../debian/aidl.mk

clean:
	make clean -C libs/androidfw -f ../../debian/libandroidfw.mk
	make clean -C tools/aapt -f ../.../debian/aapt.mk
	make clean -C tools/aidl -f ../../debian/aidl.mk