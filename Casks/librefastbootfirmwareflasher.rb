cask "librefastbootfirmwareflasher" do
  arch arm: "aarch64", intel: "x86_64"

  version "3.4.0"
  sha256 arm:   "85150d0599bcb21dfc9a67f1c794f8d26a3e2ca6f0fd02784f1f74b3d5aadb13",
         intel: "be971007e27dfd0dcc23194662fce8bf2b69d932c41e7c9ea1d9e7905047675b"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v#{version}/lfff-gui-macos-#{arch}.tar.gz"
  name "Libre Fastboot Firmware Flasher"
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"

  # The command-line tool comes from the formula of this tap.
  depends_on formula: "mrfrok/lfff/lfff"

  app "LibreFastbootFirmwareFlasher.app"
  binary "#{appdir}/LibreFastbootFirmwareFlasher.app/Contents/MacOS/lfff-gui"

  # The app is not notarised; with the quarantine flag Gatekeeper refuses to
  # open it at all.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/LibreFastbootFirmwareFlasher.app"]
  end

  zap trash: "~/Library/Application Support/lfff"
end
