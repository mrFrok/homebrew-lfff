cask "librefastbootfirmwareflasher" do
  arch arm: "aarch64", intel: "x86_64"

  version "3.3.1"
  sha256 arm:   "4197f607957c2d77327ea5f8f645dc50f96ea3db88179f91195a2e71e2b41e72",
         intel: "c5937a0eb32c4d86b3eb90f080ef622784b03bb9396acfbfd4f7b29143cb9382"

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
