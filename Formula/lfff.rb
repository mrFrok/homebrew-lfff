class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "0.2.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-macos-aarch64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
    on_intel do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-macos-x86_64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-linux-aarch64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
    on_intel do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-linux-x86_64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  end

  depends_on "android-platform-tools"

  def install
    bin.install "lfff"
  end

  test do
    assert_match "lfff", shell_output("#{bin}/lfff --version")
  end
end
