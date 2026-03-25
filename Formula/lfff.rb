class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "1.0.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-macos-aarch64.tar.gz"
        sha256 "15e6786c9313fc82be79422fe0080c286ff8308660316f1530298fd5eb02bd67"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "1c6202897303df3adfdbe34d01347b074784c7b21f4977d6df51b63db2a61f82"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-macos-x86_64.tar.gz"
        sha256 "8bc4dcb73030e496b2a4a39cea11c8578e4478d74d46642db951ad6c4fbe43eb"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "7f15d92b5f096bdd8c2fec95891a5ac1cc633f9fc4b5692ae6035231e2cecfcb"
      end
    end
  end

  on_linux do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-linux-aarch64.tar.gz"
        sha256 "d17bb964ef59c2bc5240a485e436089f79c8d0e0def735ed6b16c3e5ee9d6fe6"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "3388e15cc0dbde8ddf7956fd2d90ed794097c2a54e1d99a07de8d5b4cc5e9d84"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-linux-x86_64.tar.gz"
        sha256 "acdb3d7dffa783b8a0e5921381d7326f95397a782736fd7a18dff67371b6263e"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v1.0.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "5261246c4dc1a102a6ef3fa34f166e77845c9fa619a1620367e346041ec04d25"
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
