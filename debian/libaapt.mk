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
CXXFLAGS += -fPIC -std=gnu++11
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(BUILD_TOOLS_VERSION)\" \
            -include android/arch/AndroidConfig.h \
            -I/usr/include/android -Iinclude
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 -Wl,-rpath=/usr/lib/android \
           -lpng -lexpat -lz -L/usr/lib/android -llog -lutils -L. -landroidfw

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.0

clean:
	$(RM) $(NAME).so*