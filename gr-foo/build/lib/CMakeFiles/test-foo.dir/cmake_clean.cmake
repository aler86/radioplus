FILE(REMOVE_RECURSE
  "CMakeFiles/test-foo.dir/test_foo.cc.o"
  "CMakeFiles/test-foo.dir/qa_foo.cc.o"
  "test-foo.pdb"
  "test-foo"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang CXX)
  INCLUDE(CMakeFiles/test-foo.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
