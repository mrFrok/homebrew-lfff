class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.3.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-macos-aarch64.tar.gz"
  sha256 "d24378bbab01e04bab9ef8a7f12b2a4bf6537ad818cfd507c3aac93774a9a397"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-macos-aarch64.tar.gz"
        sha256 "d24378bbab01e04bab9ef8a7f12b2a4bf6537ad818cfd507c3aac93774a9a397"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-macos-x86_64.tar.gz"
        sha256 "97811383daa8f12af59c0724d99aa6eebe4a2369f308c62b4cf8c841fdfb6d63"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-linux-aarch64.tar.gz"
        sha256 "cd9355a8851dc2d961320414e767f8e110c53e741678a976158a2234baa94f4c"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-linux-x86_64.tar.gz"
        sha256 "cdb79f67cfaf9f02b37f6d199b8f24e44d2708445e3a794cdb964ee53baaa75e"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "db6708307ccc37c5ea747252bd487c1e1c55d940be40c486d59e485b47a280dc"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "bbc17357bdb4e459f5d8c28f3a65b99372124791482d5a7386e48e9caf655e9a"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "e8ae8ad7619d8a9d85fc801e89e4c033c878e7f76328ad4140ef786776949980"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.3.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "c083dd4f9509e11aa339ec64d7b1e22ad7feefa925911584faee75b45164204c"
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