# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/sunny/src/gr-foo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/sunny/src/gr-foo/build

# Include any dependencies generated for this target.
include lib/CMakeFiles/test-foo.dir/depend.make

# Include the progress variables for this target.
include lib/CMakeFiles/test-foo.dir/progress.make

# Include the compile flags for this target's objects.
include lib/CMakeFiles/test-foo.dir/flags.make

lib/CMakeFiles/test-foo.dir/test_foo.cc.o: lib/CMakeFiles/test-foo.dir/flags.make
lib/CMakeFiles/test-foo.dir/test_foo.cc.o: ../lib/test_foo.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object lib/CMakeFiles/test-foo.dir/test_foo.cc.o"
	cd /home/sunny/src/gr-foo/build/lib && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test-foo.dir/test_foo.cc.o -c /home/sunny/src/gr-foo/lib/test_foo.cc

lib/CMakeFiles/test-foo.dir/test_foo.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test-foo.dir/test_foo.cc.i"
	cd /home/sunny/src/gr-foo/build/lib && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/sunny/src/gr-foo/lib/test_foo.cc > CMakeFiles/test-foo.dir/test_foo.cc.i

lib/CMakeFiles/test-foo.dir/test_foo.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test-foo.dir/test_foo.cc.s"
	cd /home/sunny/src/gr-foo/build/lib && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/sunny/src/gr-foo/lib/test_foo.cc -o CMakeFiles/test-foo.dir/test_foo.cc.s

lib/CMakeFiles/test-foo.dir/test_foo.cc.o.requires:
.PHONY : lib/CMakeFiles/test-foo.dir/test_foo.cc.o.requires

lib/CMakeFiles/test-foo.dir/test_foo.cc.o.provides: lib/CMakeFiles/test-foo.dir/test_foo.cc.o.requires
	$(MAKE) -f lib/CMakeFiles/test-foo.dir/build.make lib/CMakeFiles/test-foo.dir/test_foo.cc.o.provides.build
.PHONY : lib/CMakeFiles/test-foo.dir/test_foo.cc.o.provides

lib/CMakeFiles/test-foo.dir/test_foo.cc.o.provides.build: lib/CMakeFiles/test-foo.dir/test_foo.cc.o

lib/CMakeFiles/test-foo.dir/qa_foo.cc.o: lib/CMakeFiles/test-foo.dir/flags.make
lib/CMakeFiles/test-foo.dir/qa_foo.cc.o: ../lib/qa_foo.cc
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object lib/CMakeFiles/test-foo.dir/qa_foo.cc.o"
	cd /home/sunny/src/gr-foo/build/lib && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/test-foo.dir/qa_foo.cc.o -c /home/sunny/src/gr-foo/lib/qa_foo.cc

lib/CMakeFiles/test-foo.dir/qa_foo.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/test-foo.dir/qa_foo.cc.i"
	cd /home/sunny/src/gr-foo/build/lib && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /home/sunny/src/gr-foo/lib/qa_foo.cc > CMakeFiles/test-foo.dir/qa_foo.cc.i

lib/CMakeFiles/test-foo.dir/qa_foo.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/test-foo.dir/qa_foo.cc.s"
	cd /home/sunny/src/gr-foo/build/lib && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /home/sunny/src/gr-foo/lib/qa_foo.cc -o CMakeFiles/test-foo.dir/qa_foo.cc.s

lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.requires:
.PHONY : lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.requires

lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.provides: lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.requires
	$(MAKE) -f lib/CMakeFiles/test-foo.dir/build.make lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.provides.build
.PHONY : lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.provides

lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.provides.build: lib/CMakeFiles/test-foo.dir/qa_foo.cc.o

# Object files for target test-foo
test__foo_OBJECTS = \
"CMakeFiles/test-foo.dir/test_foo.cc.o" \
"CMakeFiles/test-foo.dir/qa_foo.cc.o"

# External object files for target test-foo
test__foo_EXTERNAL_OBJECTS =

lib/test-foo: lib/CMakeFiles/test-foo.dir/test_foo.cc.o
lib/test-foo: lib/CMakeFiles/test-foo.dir/qa_foo.cc.o
lib/test-foo: /usr/lib/libboost_filesystem-mt.so
lib/test-foo: /usr/lib/libboost_system-mt.so
lib/test-foo: /usr/lib/libcppunit.so
lib/test-foo: lib/libgnuradio-foo.so
lib/test-foo: /usr/lib/libboost_filesystem-mt.so
lib/test-foo: /usr/lib/libboost_system-mt.so
lib/test-foo: lib/CMakeFiles/test-foo.dir/build.make
lib/test-foo: lib/CMakeFiles/test-foo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable test-foo"
	cd /home/sunny/src/gr-foo/build/lib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test-foo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib/CMakeFiles/test-foo.dir/build: lib/test-foo
.PHONY : lib/CMakeFiles/test-foo.dir/build

lib/CMakeFiles/test-foo.dir/requires: lib/CMakeFiles/test-foo.dir/test_foo.cc.o.requires
lib/CMakeFiles/test-foo.dir/requires: lib/CMakeFiles/test-foo.dir/qa_foo.cc.o.requires
.PHONY : lib/CMakeFiles/test-foo.dir/requires

lib/CMakeFiles/test-foo.dir/clean:
	cd /home/sunny/src/gr-foo/build/lib && $(CMAKE_COMMAND) -P CMakeFiles/test-foo.dir/cmake_clean.cmake
.PHONY : lib/CMakeFiles/test-foo.dir/clean

lib/CMakeFiles/test-foo.dir/depend:
	cd /home/sunny/src/gr-foo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/sunny/src/gr-foo /home/sunny/src/gr-foo/lib /home/sunny/src/gr-foo/build /home/sunny/src/gr-foo/build/lib /home/sunny/src/gr-foo/build/lib/CMakeFiles/test-foo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/CMakeFiles/test-foo.dir/depend
