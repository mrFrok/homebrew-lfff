class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.9.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-macos-aarch64.tar.gz"
  sha256 "129dc8901b88d240d2f5fc40b8cf741330e927a89c282296260b82861696ab0a"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-macos-aarch64.tar.gz"
        sha256 "129dc8901b88d240d2f5fc40b8cf741330e927a89c282296260b82861696ab0a"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-macos-x86_64.tar.gz"
        sha256 "78e90e95b003ce782d59aa93be3cd79fd0b7fa9e348fafb2ef03bcae1904dfa1"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-linux-aarch64.tar.gz"
        sha256 "dc730766cdb349ce7d036b8636fe524d3662deff87b75dc717cba56ded5b55fe"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-linux-x86_64.tar.gz"
        sha256 "da53e96172f60ba536400544c1b8ff19ab4c9e0741a20185e635593f9c39ed05"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "84647676861345427fd5f83e7fe595284f33b292b61a1f22eb9b2b83561bc6ab"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "96804eb2f252c9b210b4243569b129c2151575a4b3aa0275d4d1222e3ea755f3"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "5cddff29c90fe24c4d083d67614f232b8fcbf02381dde21b7e96f59810645365"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "e0ebc88573b7b1c99d5a828f1ea5048e5720fe6b6d9d15dba17ee5942e432e25"
      end
    end
  end

  def install
    resource("cli").stage { bin.install "lfff" }
    resource("gui").stage do |stage|
      if OS.mac? && (stage + "LibreFastbootFirmwareFlasher.app").exist?
        bin.install "LibreFastbootFirmwareFlasher.app/Contents/MacOS/lfff-gui"
        prefix.install "LibreFastbootFirmwareFlasher.app"
      else
        bin.install "lfff-gui"
      end
    end

    generate_completions_from_executable(bin/"lfff", "completion")
  end

  def caveats
    if OS.mac?
      <<~EOS
        LibreFastbootFirmwareFlasher.app is installed in the Cellar. To use it from Launchpad / Finder:
          cp -r #{prefix}/LibreFastbootFirmwareFlasher.app /Applications
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lfff --version")
    assert_predicate bin/"lfff-gui", :exist?
  end
end
