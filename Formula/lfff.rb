class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.2.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-macos-aarch64.tar.gz"
  sha256 "c40276188844689c46d55645c4fca031bc70e652cccb730b2075ee16d2a848bf"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-macos-aarch64.tar.gz"
        sha256 "c40276188844689c46d55645c4fca031bc70e652cccb730b2075ee16d2a848bf"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-macos-x86_64.tar.gz"
        sha256 "d8515ddafbf83733b1e72b80169a4ae18676a1d3c8f1eea0b3d1b0dec98e4aad"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-linux-aarch64.tar.gz"
        sha256 "4eb55061f474703f44a107bf8580d46b8735d62def3442c7a5f9814116b2cd60"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-linux-x86_64.tar.gz"
        sha256 "a568d2e8630d003c1c05b9851624f96c915e25e666ff7c2213f439090488c6c3"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "83ad9cffc715a9eb9e111494b495e7b3e7cd89ab2a26a902783fa92f616570e5"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "845ffe9069b2b35f68cd2150bf2f69fd710000a552511c61827d6290074f6bf5"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "acd5c2976ccec48bc4efd2a99864747f84b924b34ad87794397fdc48d6a81b32"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.2.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "2ce8d783532136b56f28b512e3a6a4d9c86fea8f4f0ed367beadca2a33376800"
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
