cask "adamekka-t3-code" do
  version "0.0.39-nightly.20260902.73"
  sha256 "b244ceaf06402a2da4528e24bfef636b8b53658e1bd205feadb31d7b92480fac"

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
