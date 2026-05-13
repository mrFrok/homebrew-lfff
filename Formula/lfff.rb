class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.1"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-macos-aarch64.tar.gz"
        sha256 "fc43ad3ddb352a83efa7c62166f18ab025e89d83fc1ba514f0130edbd2438573"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "5351eec174a40c0f9eefd435cf3542422d915c4b7399c6919cb95743c2c529a5"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-macos-x86_64.tar.gz"
        sha256 "25782e12a616700b7f81fc49075b736434466fe0b04b9a5426c02f23a45fe0b7"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "1dab7ddc807115f04b96d9266e8e0138670fe1b9482cef295c2825ba1739a122"
      end
    end
  end

  on_linux do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-linux-aarch64.tar.gz"
        sha256 "10d5e454ad8e970d3b0c004f5fcd0692c39703d386a2ebd154645bec26246530"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "04591f09e31d955508019b426f35bb13e6a6ba5d0d2dbb5749b9fc1a0a111107"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-linux-x86_64.tar.gz"
        sha256 "8d9b2adc52cd2fddf723e1578916438fc12fe70492c39a37ca3e36a0a3b171ac"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "1492ede46f127ce62e5e8b327ca5d8d51b6cba23092ff2dbb607f4d3f816b990"
      end
    end
  end

  def install
    resource("cli").stage { bin.install "lfff" }
    resource("gui").stage { bin.install "lfff-gui" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lfff --version")
    assert_match version.to_s, shell_output("#{bin}/lfff-gui --version")
  end
end
