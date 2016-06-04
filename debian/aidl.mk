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
SOURCES := $(foreach source, $(SOURCES), tools/aidl/$(source))
CPPFLAGS += -include android/arch/AndroidConfig.h

build: $(SOURCES) tools/aidl/aidl_language_y.cpp tools/aidl/aidl_language_l.cpp
	$(CXX) $^ -o $(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) $(NAME) tools/aidl/aidl_language_y.cpp tools/aidl/aidl_language_y.h tools/aidl/aidl_language_l.cpp

tools/aidl/aidl_language_l.cpp: tools/aidl/aidl_language_l.l tools/aidl/aidl_language_y.cpp
	flex -o $@ $<

tools/aidl/aidl_language_y.cpp: tools/aidl/aidl_language_y.y
	bison --defines=tools/aidl/aidl_language_y.h -o $@ $^
