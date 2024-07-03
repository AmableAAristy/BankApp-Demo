import SwiftUI
import AVKit

struct VideoPlayerView: View {
    var videoURL: URL
    @State private var player: AVPlayer?

    var body: some View {
        VideoPlayer(player: player)
            .frame(height: 300)
            .onAppear {
                player = AVPlayer(url: videoURL)
                player?.actionAtItemEnd = .none
                player?.play()
                
                NotificationCenter.default.addObserver(
                    forName: .AVPlayerItemDidPlayToEndTime,
                    object: player?.currentItem,
                    queue: .main
                ) { _ in
                    player?.seek(to: .zero)
                    player?.play()
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
                player?.pause()
            }
    }
}

let pedro: some View = {
    if let videoURL = Bundle.main.url(forResource: "pedro", withExtension: "mp4") {
        return AnyView(
            VideoPlayerView(videoURL: videoURL)
                .frame(width: 300, height: 300)
        )
    } else {
        return AnyView(Text("Video not found"))
    }
}()
