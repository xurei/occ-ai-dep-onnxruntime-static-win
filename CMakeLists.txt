## The purpose of this CMake file is to check that a newly compiled
## library can be compiled and that no linking error occurs

cmake_minimum_required(VERSION 3.20)
project(OnnxRuntimeTest)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Path to the release build
set(ONNXRUNTIME_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../release/Release")

# Include directories
include_directories(${ONNXRUNTIME_ROOT}/include)

# Link directories
link_directories(${ONNXRUNTIME_ROOT}/lib)

# Create the test executable
add_executable(onnxruntime_test test/main.cpp)

# Link all the libraries
target_link_libraries(onnxruntime_test PRIVATE
    # Abseil libraries
    absl_throw_delegate
    absl_raw_hash_set
    absl_city
    absl_hash
    absl_low_level_hash
    absl_log_internal_check_op
    absl_log_internal_conditions
    absl_log_internal_format
    absl_log_internal_globals
    absl_log_internal_log_sink_set
    absl_log_internal_message
    absl_log_internal_nullguard
    absl_log_internal_proto
    absl_log_severity
    absl_raw_logging_internal
    absl_base
    absl_spinlock_wait
    absl_exponential_biased
    absl_hashtablez_sampler
    absl_synchronization
    absl_graphcycles_internal
    absl_kernel_timeout_internal
    absl_stacktrace
    absl_symbolize
    absl_debugging_internal
    absl_demangle_internal
    absl_strings
    absl_strings_internal
    absl_str_format_internal
    absl_int128
    absl_time
    absl_time_zone
    absl_civil_time
    absl_bad_optional_access
    absl_bad_variant_access

    # ONNX libraries
    onnx_proto
    onnx

    # RE2
    re2

    # ONNX Runtime libraries
    onnxruntime_common
    onnxruntime_flatbuffers
    onnxruntime_framework
    onnxruntime_graph
    onnxruntime_mlas
    onnxruntime_optimizer
    onnxruntime_providers_dml
    onnxruntime_providers_shared
    onnxruntime_providers
    onnxruntime_session
    onnxruntime_util

    # Protobuf
    libprotobuf-lite
)

# Copy DirectML.dll to the output directory
add_custom_command(TARGET onnxruntime_test POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    "${ONNXRUNTIME_ROOT}/bin/DirectML.dll"
    $<TARGET_FILE_DIR:onnxruntime_test>
)
