NAME = libaapt
SOURCES = AaptAssets.cpp \
          AaptConfig.cpp \
          AaptUtil.cpp \
          AaptXml.cpp \
          ApkBuilder.cpp \
          Command.cpp \
          CrunchCache.cpp \
          FileFinder.cpp \
          Images.cpp \
          Package.cpp \
          pseudolocalize.cpp \
          Resource.cpp \
          ResourceFilter.cpp \
          ResourceIdCache.cpp \
          ResourceTable.cpp \
          SourcePos.cpp \
          StringPool.cpp \
          WorkQueue.cpp \
          XMLNode.cpp \
          ZipEntry.cpp \
          ZipFile.cpp
SOURCES := $(foreach source, $(SOURCES), tools/aapt/$(source))
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(ANDROID_BUILD_TOOLS_VERSION)\" \
            -Iinclude
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=.:/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lpng -lexpat -lz \
           -Ldebian/out -landroidfw \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -llog -lutils

build: $(SOURCES)
	mkdir --parents debian/out
	$(CXX) $^ -o debian/out/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/$(NAME).so

clean:
	$(RM) debian/out/$(NAME).so*
