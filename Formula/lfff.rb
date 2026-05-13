class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.1"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-macos-aarch64.tar.gz"
        sha256 "26fb9133c089dcb6ac747da4174081fdf472fa0b9eadf9eee889377f18326d42"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "f711190580e8e2a3c28e510af0067f1cbd9ca3795447e641bcc278d8013a0f25"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-macos-x86_64.tar.gz"
        sha256 "3bb4b7971caee45f2e3ac43acf9468f49ace72b80f19720e927f29f01b859904"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "5f175b5e19c719c595cbd592b8c5fa0a8024fc2aa07e54730d4a6901e1adc5ee"
      end
    end
  end

  on_linux do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-linux-aarch64.tar.gz"
        sha256 "b1ad6ecd38f444abb13d72980094a5d48f6b6e076fab0f337db0f75f2ddfbbef"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "127d098d1d910717d3f775c165e3c0923feb7af449369a47c711d482b28e1281"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-linux-x86_64.tar.gz"
        sha256 "cab58c0c9c4e95d2b51f6cd64688568e8c5c6ccae0c77f336cef26f9ef7c5d39"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "c383b7cfe049db9373f64534fcb665b1aca49a393b8ee5253051a48269061fa1"
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
