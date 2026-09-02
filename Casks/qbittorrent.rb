cask "qbittorrent" do
  version "5.2.3"
  sha256 "9e37f6c7ff848c7bdd3c10167614c0cb78c00e2ddcc323f1ad3ac6c008a0481f"

  url "https://downloads.sourceforge.net/qbittorrent/qbittorrent-mac/qbittorrent-#{version}/qbittorrent-#{version}.dmg"
  name "qBittorrent"
  desc "Peer-to-peer BitTorrent client"
  homepage "https://www.qbittorrent.org/"

  livecheck do
    url "https://sourceforge.net/projects/qbittorrent/rss?path=/qbittorrent-mac"
    regex(%r{url=.*?/qbittorrent[._-]v?(\d+(?:\.\d+)+)\.dmg}i)
  end

  conflicts_with cask: "qbittorrent@lt20"
  depends_on macos: :ventura

  app "qbittorrent.app", target: "qBittorrent.app"

  postflight do
    # Upstream self-signs the app, so Gatekeeper rejects it while quarantined.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/qBittorrent.app"]
  end

  zap trash: [
    "~/.config/qBittorrent",
    "~/Library/Application Support/qBittorrent",
    "~/Library/Caches/qBittorrent",
    "~/Library/Preferences/org.qbittorrent.qBittorrent.plist",
    "~/Library/Preferences/qBittorrent",
    "~/Library/Saved Application State/org.qbittorrent.qBittorrent.savedState",
  ]

  caveats <<~EOS
    qBittorrent is self-signed and is not notarized by Apple. This cask removes
    macOS quarantine from the installed app so it can open.
  EOS
end
