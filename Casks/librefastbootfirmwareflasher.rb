cask "librefastbootfirmwareflasher" do
  arch arm: "aarch64", intel: "x86_64"

  version "3.6.0"
  sha256 arm:   "9572a7926a24e35f4a25015ff3e726657fbbef5dc015cdb408821e409e9289bf",
         intel: "7e8a166b58be32bfe99de33f7bae94796cfd8ebf962911f7ef197e15d33049e8"

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
