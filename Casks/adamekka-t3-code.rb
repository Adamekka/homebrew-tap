cask "adamekka-t3-code" do
  version "0.0.34-nightly.20260824.50"
  sha256 "f3b40e04abd82b99aad23d5ae90a11b70a98c9638ab949b1ca18d48d638ddc8c"

  url "https://github.com/Adamekka/t3code/releases/download/v#{version}/T3-Code-#{version}-arm64.dmg"
  name "T3 Code"
  desc "GUI for coding agents"
  homepage "https://github.com/Adamekka/t3code"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "T3 Code (Nightly).app"

  zap trash: [
    "~/.t3/userdata",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.t3tools.t3code.sfl*",
    "~/Library/Application Support/T3 Code (Alpha)",
    "~/Library/Application Support/t3code",
    "~/Library/Caches/com.t3tools.t3code",
    "~/Library/HTTPStorages/com.t3tools.t3code",
    "~/Library/Preferences/com.t3tools.t3code.plist",
    "~/Library/Saved Application State/com.t3tools.t3code.savedState",
  ]

  caveats <<~EOS
    T3 Code is unsigned and unnotarized. On first launch, right-click the app,
    choose Open, then confirm that you want to open it.
  EOS
end
