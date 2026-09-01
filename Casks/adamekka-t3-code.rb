cask "adamekka-t3-code" do
  version "0.0.38-nightly.20260901.69"
  sha256 "60f85a6fcf08262d345a662357918b3bd6b2b5dbae6fff1973f3cdca65b87a7a"

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
