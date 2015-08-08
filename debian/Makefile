#!/bin/make -f

build:
	make -C libs/androidfw -f ../../debian/libandroidfw.mk
	make -C tools/aapt -f ../../debian/aapt.mk
	make -C tools/aidl -f ../../debian/aidl.mk
	make -C tools/split-select -f ../../debian/split-select.mk

clean:
	make -C libs/androidfw -f ../../debian/libandroidfw.mk clean
	make -C tools/aapt -f ../../debian/aapt.mk clean
	make -C tools/aidl -f ../../debian/aidl.mk clean
	make -C tools/split-select -f ../../debian/split-select.mk clean