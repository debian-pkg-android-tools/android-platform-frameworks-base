include /usr/include/android/arch/android_includes.mk

NAME = aidl
SOURCES = aidl_language_l.cpp \
          aidl_language_y.cpp \
          aidl.cpp \
          aidl_language.cpp \
          options.cpp \
          search_path.cpp \
          AST.cpp \
          Type.cpp \
          generate_java.cpp \
          generate_java_binder.cpp \
          generate_java_rpc.cpp
CXXFLAGS += -fPIC
CPPFLAGS += $(ANDROID_INCLUDES) -I/usr/include/android

build: $(SOURCES) aidl_language_y.cpp aidl_language_l.cpp
	c++ $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LOCAL_LDFLAGS)

clean:
	rm -f $(NAME) aidl_language_y.cpp aidl_language_y.h aidl_language_l.cpp

aidl_language_l.cpp: aidl_language_l.l aidl_language_y.cpp
	flex -o $@ $<

aidl_language_y.cpp: aidl_language_y.y
	bison --defines=aidl_language_y.h -o $@ $^
