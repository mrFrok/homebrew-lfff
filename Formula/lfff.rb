class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.0"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-macos-aarch64.tar.gz"
        sha256 "01a9fd150d9ae692deaf9d67b9ccea8e11e280290a535719a85f7bd1d7a6aebe"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "26990eda99347bc97c1692412b43022b22707e7858e22026efc97dd1b656a1e1"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-macos-x86_64.tar.gz"
        sha256 "5b03aa86bc20a71fc7fefe8591e3900cbaa20584117e4f9462ae3042b2530621"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "9fdb922c014a036f89605eb1f89c1e9d20a7d872298c6a654bbe0d11db5e5e49"
      end
    end
  end

  on_linux do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-linux-aarch64.tar.gz"
        sha256 "6c9aac42c9be3963ff65fe92db58202343fbfd88ad01fef30bcde0d81c460c12"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "9bf30b482e2beba8aac16cc1b78fbf28552dcf614dea703c494ab809563f1ea7"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-linux-x86_64.tar.gz"
        sha256 "43bcc19cc1faf26f29a7f4a081d639e5f652658d5bddfa0003c92ef36fb2d4b8"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "510d3e36531758ce0d7f91abd5434a943a554f49cb1051d6c89c308142058bb1"
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
