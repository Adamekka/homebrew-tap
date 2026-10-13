cask "gstreamer-runtime" do
  version "1.28.6"
  sha256 "a8eb366c59b7e9e5dc049848fed6bcd203a8878aa7517c051639fda78797c6ad"

  url "https://gstreamer.freedesktop.org/data/pkg/osx/#{version}/gstreamer-1.0-#{version}-universal.pkg"
  name "GStreamer runtime package"
  desc "Open Source Multimedia Framework"
  homepage "https://gstreamer.freedesktop.org/"

  livecheck do
    url "https://gstreamer.freedesktop.org/download/"
    regex(/gstreamer[._-]1\.0[._-]v?(\d+(?:\.\d+)+)[._-]universal\.pkg/i)
  end

  depends_on :macos

  pkg "gstreamer-1.0-#{version}-universal.pkg"

  preflight_steps do
    # The installer is not notarized, so clear Homebrew's quarantine before installation.
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{staged_path}}/gstreamer-1.0-#{version}-universal.pkg"]
  end

  postflight_steps do
    # The root-owned runtime has development-only symlinks; do not follow their missing targets.
    run "/usr/bin/xattr",
        args: ["-drs", "com.apple.quarantine", "/Library/Frameworks/GStreamer.framework"],
        sudo: true
  end

  uninstall pkgutil: [
    "org.freedesktop.gstreamer.darwin.base-crypto",
    "org.freedesktop.gstreamer.darwin.base-system-1.0",
    "org.freedesktop.gstreamer.darwin.GStreamer",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-analytics",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-capture",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-codecs",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-codecs-gpl",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-codecs-gpl-restricted",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-codecs-restricted",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-core",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-devtools",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-dvd",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-dvd-gpl",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-editing",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-effects",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-encoding",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-gtk",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-libav",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-net",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-net-restricted",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-playback",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-python",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-qt5",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-system",
    "org.freedesktop.gstreamer.darwin.gstreamer-1.0-visualizers",
  ]

  zap trash: "/Library/Frameworks/GStreamer.framework"

  caveats <<~EOS
    This cask installs the GStreamer.framework runtime tools into /Library/Frameworks/.
    GStreamer is not notarized by Apple. This cask removes macOS quarantine from
    the installer and installed framework so Wine can use it.

    To install the GStreamer.framework development tools also, run:
      brew install --cask gstreamer-development
  EOS
end
