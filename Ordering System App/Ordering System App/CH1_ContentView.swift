import SwiftUI
import AVFoundation
import Speech

struct CH1_ContentView: View {
    @State private var recognizedText = "點擊下方按鈕開始自我介紹..."
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showingPermissionAlert = false
    @State private var permissionAlertMessage = ""
    @State private var recordingStartTime: Date? = nil
    @State private var timer: Timer?
    @State private var recordingDuration: TimeInterval = 0

    private let audioFilename: URL = {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return path.appendingPathComponent("recording.m4a")
    }()

    var body: some View {
        VStack(spacing: 20) {
            Text("語音自我介紹")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.blue)
                .padding(.top, 30)
            
            ScrollView {
                VStack {
                    if isRecording {
                        Text("錄音中...")
                            .foregroundColor(.red)
                            .font(.headline)
                        Text(timeString(from: recordingDuration))
                            .font(.system(.title2, design: .monospaced))
                            .foregroundColor(.red)
                    }
                    
                    Text(recognizedText)
                        .padding()
                }
                .frame(minHeight: 150)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 5)
                )
                .padding()
            }
            
            HStack(spacing: 20) {
                Button(action: {
                    if isRecording {
                        stopRecording()
                    } else {
                        checkAndRequestMicrophonePermission()
                    }
                }) {
                    VStack {
                        Image(systemName: isRecording ? "stop.circle.fill" : "mic.circle.fill")
                            .font(.system(size: 50))
                        Text(isRecording ? "停止錄音" : "開始錄音")
                            .font(.headline)
                    }
                    .foregroundColor(isRecording ? .red : .blue)
                }
                
                Button(action: playRecording) {
                    VStack {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 50))
                        Text("播放錄音")
                            .font(.headline)
                    }
                    .foregroundColor(.green)
                }
            }
            .padding(.bottom, 30)
        }
        .padding()
        .alert(isPresented: $showingPermissionAlert) {
            Alert(
                title: Text("提醒"),
                message: Text(permissionAlertMessage),
                dismissButton: .default(Text("確定"))
            )
        }
        .onAppear {
            setupAudioSession()
        }
    }

    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("音訊設定失敗: \(error.localizedDescription)")
        }
    }

    private func checkAndRequestMicrophonePermission() {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            startRecording()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async {
                    if granted {
                        startRecording()
                    } else {
                        showingPermissionAlert = true
                        permissionAlertMessage = "需要麥克風權限才能進行錄音"
                    }
                }
            }
        case .denied, .restricted:
            showingPermissionAlert = true
            permissionAlertMessage = "請在設定中開啟麥克風權限以使用錄音功能"
        @unknown default:
            break
        }
    }

    private func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startRecording() {
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            AudioServicesPlaySystemSound(1113) // 播放開始錄音提示音
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.record()
            isRecording = true
            recordingStartTime = Date()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if let startTime = recordingStartTime {
                    recordingDuration = Date().timeIntervalSince(startTime)
                }
            }
            
            recognizedText = "正在錄音..."
        } catch {
            recognizedText = "錄音設定失敗: \(error.localizedDescription)"
        }
    }

    private func stopRecording() {
        timer?.invalidate()
        timer = nil
        recordingStartTime = nil
        recordingDuration = 0
        
        AudioServicesPlaySystemSound(1114) // 播放結束錄音提示音
        
        audioRecorder?.stop()
        isRecording = false
        recognizedText = "錄音已停止，正在轉換為文字..."
        transcribeAudio()
    }

    private func playRecording() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.play()
            recognizedText = "正在播放錄音..."
        } catch {
            recognizedText = "播放錄音失敗: \(error.localizedDescription)"
        }
    }

    private func transcribeAudio() {
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-TW"))
        let request = SFSpeechURLRecognitionRequest(url: audioFilename)
        
        recognizer?.recognitionTask(with: request) { result, error in
            DispatchQueue.main.async {
                if let result = result {
                    recognizedText = result.bestTranscription.formattedString
                } else if let error = error {
                    recognizedText = "轉換失敗: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct CH1_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CH1_ContentView()
    }
}



