Param($Configuration, $Version)

if (Test-Path release) {
  Remove-Item release -Recurse -Force
}
New-Item release\$Configuration\bin -ItemType Directory -Force
New-Item release\$Configuration\include -ItemType Directory -Force
New-Item release\$Configuration\lib -ItemType Directory -Force

python onnxruntime\tools\ci_build\build.py --cmake_generator "Visual Studio 17 2022" --build_dir build --config $Configuration --parallel --skip_tests --skip_submodule_sync --use_dml --build_shared_lib

$binArray =
  "build\packages\Microsoft.AI.DirectML.1.15.4\bin\x64-win\DirectML.dll",
  "build\packages\Microsoft.AI.DirectML.1.15.4\bin\x64-win\DirectML.lib"

$includeArray =
  "onnxruntime\include\onnxruntime\core\framework\provider_options.h",
  "onnxruntime\include\onnxruntime\core\providers\cpu\cpu_provider_factory.h",
  "onnxruntime\include\onnxruntime\core\providers\dml\dml_provider_factory.h",
  "onnxruntime\include\onnxruntime\core\session\onnxruntime_c_api.h",
  "onnxruntime\include\onnxruntime\core\session\onnxruntime_cxx_api.h",
  "onnxruntime\include\onnxruntime\core\session\onnxruntime_cxx_inline.h",
  "onnxruntime\include\onnxruntime\core\session\onnxruntime_ep_c_api.h",
  "onnxruntime\include\onnxruntime\core\session\onnxruntime_float16.h",
  "onnxruntime\include\onnxruntime\core\session\onnxruntime_run_options_config_keys.h",
  "onnxruntime\include\onnxruntime\core\session\onnxruntime_session_options_config_keys.h"

$libArray =
  "build\$Configuration\_deps\abseil_cpp-build\absl\base\$Configuration\absl_throw_delegate.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\container\$Configuration\absl_raw_hash_set.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\hash\$Configuration\absl_city.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\hash\$Configuration\absl_hash.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\hash\$Configuration\absl_low_level_hash.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_check_op.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_conditions.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_format.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_globals.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_log_sink_set.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_message.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_nullguard.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\log\$Configuration\absl_log_internal_proto.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\base\$Configuration\absl_log_severity.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\base\$Configuration\absl_raw_logging_internal.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\base\$Configuration\absl_base.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\base\$Configuration\absl_spinlock_wait.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\profiling\$Configuration\absl_exponential_biased.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\profiling\$Configuration\absl_hashtablez_sampler.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\synchronization\$Configuration\absl_synchronization.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\synchronization\$Configuration\absl_graphcycles_internal.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\synchronization\$Configuration\absl_kernel_timeout_internal.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\debugging\$Configuration\absl_stacktrace.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\debugging\$Configuration\absl_symbolize.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\debugging\$Configuration\absl_debugging_internal.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\debugging\$Configuration\absl_demangle_internal.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\strings\$Configuration\absl_strings.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\strings\$Configuration\absl_strings_internal.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\strings\$Configuration\absl_str_format_internal.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\numeric\$Configuration\absl_int128.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\time\$Configuration\absl_time.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\time\$Configuration\absl_time_zone.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\time\$Configuration\absl_civil_time.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\types\$Configuration\absl_bad_optional_access.lib",
  "build\$Configuration\_deps\abseil_cpp-build\absl\types\$Configuration\absl_bad_variant_access.lib",
  "build\$Configuration\_deps\onnx-build\$Configuration\onnx_proto.lib",
  "build\$Configuration\_deps\onnx-build\$Configuration\onnx.lib",
  "build\$Configuration\_deps\re2-build\$Configuration\re2.lib",
  "build\$Configuration\$Configuration\onnxruntime_common.lib",
  "build\$Configuration\$Configuration\onnxruntime_flatbuffers.lib",
  "build\$Configuration\$Configuration\onnxruntime_framework.lib",
  "build\$Configuration\$Configuration\onnxruntime_graph.lib",
  "build\$Configuration\$Configuration\onnxruntime_mlas.lib",
  "build\$Configuration\$Configuration\onnxruntime_optimizer.lib",
  "build\$Configuration\$Configuration\onnxruntime_providers_dml.lib",
  "build\$Configuration\$Configuration\onnxruntime_providers_shared.lib",
  "build\$Configuration\$Configuration\onnxruntime_providers.lib",
  "build\$Configuration\$Configuration\onnxruntime_session.lib",
  "build\$Configuration\$Configuration\onnxruntime_util.lib"

if ($Configuration -eq "Debug") {
  $libArray += "build\Debug\_deps\protobuf-build\Debug\libprotobuf-lited.lib"
} else {
  $libArray += "build\Release\_deps\protobuf-build\Release\libprotobuf-lite.lib"
}

foreach ($bin in $binArray) {
    Copy-Item $bin release\$Configuration\bin -Verbose
}

foreach ($include in $includeArray) {
    Copy-Item $include release\$Configuration\include -Verbose
}

foreach ($lib in $libArray) {
    Copy-Item $lib release\$Configuration\lib -Verbose
}

Compress-Archive release\$Configuration\* release\onnxruntime-windows-$Version-$Configuration.zip -Verbose
