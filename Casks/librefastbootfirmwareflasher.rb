cask "librefastbootfirmwareflasher" do
  arch arm: "aarch64", intel: "x86_64"

  version "3.5.1"
  sha256 arm:   "791168766d8468f920e3fc01df597bf7b5b0a3b5cc08886f54a65afcef6af1f9",
         intel: "d8c4576fbf754eca9b1b2e58ab6ecc7ab54c3ec1105e21561f047f07ae00fb45"

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
