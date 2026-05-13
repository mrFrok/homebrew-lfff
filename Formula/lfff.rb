class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.1"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-macos-aarch64.tar.gz"
        sha256 "e90821827837d9e85a8eec6f18e70657348ce275777917f32cd4ad2ef84d7c93"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "56b31da13150aabaf3b88479a730a0893a15b626b9bed80289f14be9c0d4b625"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-macos-x86_64.tar.gz"
        sha256 "92345f59cffb9f0cede73823d9d4c88113072734bf5d9b1504ebbb6295a7b396"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "cff5f4971ba4e6939ebe5a55535b646ddf247ac78a079e30cda7279aaee680fb"
      end
    end
  end

  on_linux do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-linux-aarch64.tar.gz"
        sha256 "b9c1c53c01db72ca6da04202ddf7ed99eb9220dfe927497fa8656f09cd5a483c"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "900c9fd3fa50e40110271dcd285c4edba5b3e0168faeefcd3c2f2b33a00866aa"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-linux-x86_64.tar.gz"
        sha256 "a5757090d5a88a8115666607a028dec18cffc68e0a87fe29b53cdaad0967f652"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "45841fc073b07df3847198390bcecfd80a1e00f0a7de4b294f0652e92c0e3fa7"
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
