class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.5.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-macos-aarch64.tar.gz"
  sha256 "ab73888b7b5512438bde15babaa6b16691d4aa25322d00fba7c3accc28c852b6"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-macos-aarch64.tar.gz"
        sha256 "ab73888b7b5512438bde15babaa6b16691d4aa25322d00fba7c3accc28c852b6"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-macos-x86_64.tar.gz"
        sha256 "6fdd8995ef278c89f96c067f094742e7a05ca02b653cf6107fca5660552d249f"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-linux-aarch64.tar.gz"
        sha256 "6b91db1e282df308adcc400d0a2a54e05de70d3306b9f481fd4311259e1682d7"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-linux-x86_64.tar.gz"
        sha256 "2a96807dd5ba45d9c3ce5926f9634521923544e8dc9da8729ecd9d4af624dc7f"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "65f52b852693fda092d06e3f04754a707f8f01d4c07af3c518dcae8d07269678"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "9f6d142f8158bb90cd219af0e0f5b4b07a1f2ae4439acae7c4e778a495612c82"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "132000afeda6f2fcfb457b4830f114c4b87178f57482d12f38c9ea473f35fa20"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.5.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "45125857b8a6d7edec14f0abe1b8b60cc8a7867ca642493933e012b2dfd185ae"
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
