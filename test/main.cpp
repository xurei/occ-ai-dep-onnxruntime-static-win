#include <iostream>
#include <onnxruntime_cxx_api.h>

int main() {
    try {
        // Initialize ONNX Runtime environment
        Ort::Env env(ORT_LOGGING_LEVEL_WARNING, "ONNXRuntimeTest");
        std::cout << "ONNX Runtime initialized successfully!" << std::endl;
        
        // Get available providers
        std::vector<std::string> providers = Ort::GetAvailableProviders();
        std::cout << "Available providers:" << std::endl;
        for (const auto& provider : providers) {
            std::cout << "  - " << provider << std::endl;
        }
        
        // Try to create a session options with DML provider
        Ort::SessionOptions session_options;
        
        // You can add more test code here to load a model, run inference, etc.
        
        std::cout << "\nTest passed! All libraries linked correctly." << std::endl;
        return 0;
        
    } catch (const Ort::Exception& e) {
        std::cerr << "ONNX Runtime error: " << e.what() << std::endl;
        return 1;
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
}
