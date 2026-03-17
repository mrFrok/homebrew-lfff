class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "0.2.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-macos-aarch64.tar.gz"
      sha256 "f566e78e1a9a8ace50cf93756977ac22bc9959218f36002bea03057def4970c9"
    end
    on_intel do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-macos-x86_64.tar.gz"
      sha256 "1ea11cd5b5c79dcb7210cf9cd1d7f500d124dfae0b75896d1ce6a42b386020f3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-linux-aarch64.tar.gz"
      sha256 "535f1b0bb05fffe3e81c9462ba3f1765156032652c0195ed54b3aa60139e7051"
    end
    on_intel do
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v0.2.0/lfff-linux-x86_64.tar.gz"
      sha256 "8191c4ff07ad9324cf837c3a94755c6c97bca277e16f29f5ffea7a6ac3ff3982"
    end
  end

  depends_on cask: "android-platform-tools"

  def install
    bin.install "lfff"
  end

  test do
    assert_match "lfff", shell_output("#{bin}/lfff --version")
  end
end
