import SwiftUI
import AVFoundation
import Speech

struct H1_ContentView: View {
    @State private var recognizedText = "請按下按鈕開始語音輸入..."
    @State private var isListening = false
    private let speechRecognizer = SFSpeechRecognizer()
    private let audioEngine = AVAudioEngine()
    private let speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack(spacing: 30) {
            Text("語音自我介紹")
                .font(.largeTitle)
                .padding()

            // 顯示語音輸入的結果
            Text(recognizedText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .frame(height: 200)
                .padding()

            // 開始/停止語音輸入按鈕
            Button(action: {
                if isListening {
                    stopListening()
                } else {
                    startListening()
                }
                isListening.toggle()
            }) {
                Text(isListening ? "停止語音輸入" : "開始語音輸入")
                    .padding()
                    .background(isListening ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // 語音輸出按鈕
            Button(action: {
                speak(text: "您好，我是 Swift UI 的語音自我介紹範例")
            }) {
                Text("播放語音自我介紹")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

        }
        .padding()
    }

    // 語音輸出（Text-to-Speech）
    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        speechSynthesizer.speak(utterance)
    }

    // 開始語音識別
    private func startListening() {
        let request = SFSpeechAudioBufferRecognitionRequest()
        let inputNode = audioEngine.inputNode

        guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            recognizedText = "語音識別無法使用"
            return
        }

        speechRecognizer.recognitionTask(with: request) { result, error in
            if let result = result {
                recognizedText = result.bestTranscription.formattedString
            } else if let error = error {
                recognizedText = "語音識別錯誤: \(error.localizedDescription)"
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
            recognizedText = "請開始說話..."
        } catch {
            recognizedText = "無法開始錄音: \(error.localizedDescription)"
        }
    }

    // 停止語音識別
    private func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognizedText = "已停止語音輸入"
    }
}

