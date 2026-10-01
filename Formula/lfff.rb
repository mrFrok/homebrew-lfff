class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.9.1"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-macos-aarch64.tar.gz"
  sha256 "c5d693b4519430b0aa859742fdd89bd755cecb7b8249748473c96f2a1b2982db"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-macos-aarch64.tar.gz"
        sha256 "c5d693b4519430b0aa859742fdd89bd755cecb7b8249748473c96f2a1b2982db"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-macos-x86_64.tar.gz"
        sha256 "3b42c438902d5cea80cebcad4ecb6ee2b65c08a96a7dd9597f20d679949b1690"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-linux-aarch64.tar.gz"
        sha256 "ff7c4e23cc47c4447d765f291b9ac6f470e8d1c79b412eca914ec51c4b24e713"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-linux-x86_64.tar.gz"
        sha256 "40f8f6fc309503377771bc988151877f6e0b3fc5325cb15912d55e94c6451845"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "220ad2b05f6889773141447f9bce4ad5e8eeaa222edced69615e4b3dc074ea0e"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "b1ceeceb323e07340f0c91857bb5d2ca2fe5f026be621e743d3c5207e635b6dd"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "06450622e42eb1a095b2a37053c9d814f3f2cd604ffb30e67fa9270b16a9dd51"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "94132dc18d5745f98012737a527aced61596cf4b6d29741dd60e92aa1142e56a"
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
