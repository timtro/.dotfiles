#include <cstdio>
#include <experimental/type_traits>

// using std::experimental::is_detected_v;

int main() {
#ifdef _LIBCPP_VERSION
  printf("LIBCPP_VERSION: %d\n", _LIBCPP_VERSION);
  printf("LIBCPP_ABI_VERSION: %d\n", _LIBCPP_ABI_VERSION);
#endif

#ifdef __GLIBCPP__
  std::printf("GLIBCPP: %d\n", __GLIBCPP__);
#endif
#ifdef __GLIBCXX__
  std::printf("GLIBCXX: %d\n", __GLIBCXX__);
#endif

#if __has_cpp_attribute(__cpp_lib_experimental_type_trait_variable_templates)
  std::printf("__cpp_lib_experimental_type_trait_variable_templates : yes\n");
#else
  std::printf("__cpp_lib_experimental_type_trait_variable_templates : no\n");
#endif

#if __has_cpp_attribute(__cpp_lib_type_trait_variable_templates)
  std::printf("__cpp_lib_type_trait_variable_templates : yes\n");
#else
  std::printf("__cpp_lib_type_trait_variable_templates : no\n");
#endif

#if __has_cpp_attribute(__cpp_lib_variant)
  std::printf("__cpp_lib_variant : yes\n");
#else
  std::printf("__cpp_lib_variant : no\n");
#endif

  return 0;
}
