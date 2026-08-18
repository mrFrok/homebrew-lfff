class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.7.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-macos-aarch64.tar.gz"
  sha256 "216f85178e9487f8ce2e4382ad066a4c0631cbf4fe5cdb0a74170acd332f7b97"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-macos-aarch64.tar.gz"
        sha256 "216f85178e9487f8ce2e4382ad066a4c0631cbf4fe5cdb0a74170acd332f7b97"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-macos-x86_64.tar.gz"
        sha256 "7d7b278c78ac2b12753ea427d649a6e60b7233d15d9361eca5aa90c946885920"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-linux-aarch64.tar.gz"
        sha256 "d700c7250428459fbca714ca8e2e9f529fdaf20d4b1e8295c92a34d6b7007d6c"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-linux-x86_64.tar.gz"
        sha256 "4caca1e7861153140e171af27b01c8e9294dba7721e1c28e6031a094ddd1b4e2"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "b7aef6b7bded9a9373aaa87fe27e96af15d445a6b95b5ed34b00d0f0d9799065"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "ed30b8fe67380f761c60985de986f49c6d560b4aa745ad1062948ec852f5f12f"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "ad650586741f4201075a0309e0b171186d3303fe92e8c4884ccf5d4a0010f04f"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "e9075f6dfcab497c71d0557c9e586f497fb0941d39527754563f71caa45855d8"
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
