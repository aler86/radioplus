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

# Utility rule file for pygen_swig_5834e.

# Include the progress variables for this target.
include swig/CMakeFiles/pygen_swig_5834e.dir/progress.make

swig/CMakeFiles/pygen_swig_5834e: swig/foo_swig.pyc
swig/CMakeFiles/pygen_swig_5834e: swig/foo_swig.pyo

swig/foo_swig.pyc: swig/foo_swig.py
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating foo_swig.pyc"
	cd /home/sunny/src/gr-foo/build/swig && /usr/bin/python /home/sunny/src/gr-foo/build/python_compile_helper.py /home/sunny/src/gr-foo/build/swig/foo_swig.py /home/sunny/src/gr-foo/build/swig/foo_swig.pyc

swig/foo_swig.pyo: swig/foo_swig.py
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating foo_swig.pyo"
	cd /home/sunny/src/gr-foo/build/swig && /usr/bin/python -O /home/sunny/src/gr-foo/build/python_compile_helper.py /home/sunny/src/gr-foo/build/swig/foo_swig.py /home/sunny/src/gr-foo/build/swig/foo_swig.pyo

swig/foo_swigPYTHON_wrap.cxx: ../swig/foo_swig.i
swig/foo_swigPYTHON_wrap.cxx: /usr/local/include/gnuradio/swig/gnuradio.i
swig/foo_swigPYTHON_wrap.cxx: /usr/local/include/gnuradio/swig/gr_extras.i
swig/foo_swigPYTHON_wrap.cxx: /usr/local/include/gnuradio/swig/gr_shared_ptr.i
swig/foo_swigPYTHON_wrap.cxx: /usr/local/include/gnuradio/swig/gnuradio_swig_bug_workaround.h
swig/foo_swigPYTHON_wrap.cxx: /usr/local/include/gnuradio/swig/gr_types.i
swig/foo_swigPYTHON_wrap.cxx: swig/foo_swig.tag
swig/foo_swigPYTHON_wrap.cxx: ../swig/foo_swig.i
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_3)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Swig source"
	cd /home/sunny/src/gr-foo/build/swig && /usr/bin/cmake -E make_directory /home/sunny/src/gr-foo/build/swig
	cd /home/sunny/src/gr-foo/build/swig && /usr/bin/swig2.0 -python -fvirtual -modern -keyword -w511 -module foo_swig -I/usr/local/include/gnuradio/swig -I/usr/include/python2.7 -I/usr/include/python2.7 -I/home/sunny/src/gr-foo/swig -I/home/sunny/src/gr-foo/build/swig -outdir /home/sunny/src/gr-foo/build/swig -c++ -I/home/sunny/src/gr-foo/include -I/usr/include -I/usr/local/include -I/usr/local/include/gnuradio/swig -I/usr/include/python2.7 -I/home/sunny/src/gr-foo/swig -I/home/sunny/src/gr-foo/build/swig -o /home/sunny/src/gr-foo/build/swig/foo_swigPYTHON_wrap.cxx /home/sunny/src/gr-foo/swig/foo_swig.i

swig/foo_swig.py: swig/foo_swigPYTHON_wrap.cxx

swig/foo_swig.tag: swig/foo_swig_doc.i
swig/foo_swig.tag: swig/_foo_swig_swig_tag
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_4)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating foo_swig.tag"
	cd /home/sunny/src/gr-foo/build/swig && ./_foo_swig_swig_tag
	cd /home/sunny/src/gr-foo/build/swig && /usr/bin/cmake -E touch /home/sunny/src/gr-foo/build/swig/foo_swig.tag

swig/foo_swig_doc.i: swig/foo_swig_doc_swig_docs/xml/index.xml
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_5)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating foo_swig_doc.i"
	cd /home/sunny/src/gr-foo/docs/doxygen && /usr/bin/python -B /home/sunny/src/gr-foo/docs/doxygen/swig_doc.py /home/sunny/src/gr-foo/build/swig/foo_swig_doc_swig_docs/xml /home/sunny/src/gr-foo/build/swig/foo_swig_doc.i

swig/foo_swig_doc_swig_docs/xml/index.xml: swig/_foo_swig_doc_tag
	$(CMAKE_COMMAND) -E cmake_progress_report /home/sunny/src/gr-foo/build/CMakeFiles $(CMAKE_PROGRESS_6)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating doxygen xml for foo_swig_doc docs"
	cd /home/sunny/src/gr-foo/build/swig && ./_foo_swig_doc_tag
	cd /home/sunny/src/gr-foo/build/swig && /usr/bin/doxygen /home/sunny/src/gr-foo/build/swig/foo_swig_doc_swig_docs/Doxyfile

pygen_swig_5834e: swig/CMakeFiles/pygen_swig_5834e
pygen_swig_5834e: swig/foo_swig.pyc
pygen_swig_5834e: swig/foo_swig.pyo
pygen_swig_5834e: swig/foo_swigPYTHON_wrap.cxx
pygen_swig_5834e: swig/foo_swig.py
pygen_swig_5834e: swig/foo_swig.tag
pygen_swig_5834e: swig/foo_swig_doc.i
pygen_swig_5834e: swig/foo_swig_doc_swig_docs/xml/index.xml
pygen_swig_5834e: swig/CMakeFiles/pygen_swig_5834e.dir/build.make
.PHONY : pygen_swig_5834e

# Rule to build all files generated by this target.
swig/CMakeFiles/pygen_swig_5834e.dir/build: pygen_swig_5834e
.PHONY : swig/CMakeFiles/pygen_swig_5834e.dir/build

swig/CMakeFiles/pygen_swig_5834e.dir/clean:
	cd /home/sunny/src/gr-foo/build/swig && $(CMAKE_COMMAND) -P CMakeFiles/pygen_swig_5834e.dir/cmake_clean.cmake
.PHONY : swig/CMakeFiles/pygen_swig_5834e.dir/clean

swig/CMakeFiles/pygen_swig_5834e.dir/depend:
	cd /home/sunny/src/gr-foo/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/sunny/src/gr-foo /home/sunny/src/gr-foo/swig /home/sunny/src/gr-foo/build /home/sunny/src/gr-foo/build/swig /home/sunny/src/gr-foo/build/swig/CMakeFiles/pygen_swig_5834e.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : swig/CMakeFiles/pygen_swig_5834e.dir/depend

