class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.8.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-macos-aarch64.tar.gz"
  sha256 "3df9ff08f82c898caaf82f41686e94dd9a8a64bb7c5d2a646e87bad69e4ee99b"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-macos-aarch64.tar.gz"
        sha256 "3df9ff08f82c898caaf82f41686e94dd9a8a64bb7c5d2a646e87bad69e4ee99b"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-macos-x86_64.tar.gz"
        sha256 "48e3304dea2979c95426cafdc01a53d08e92f8160920715abb9d96ac765dc95f"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-linux-aarch64.tar.gz"
        sha256 "e8320ea8d2285f40ad89347c20a792ceb27a0960fe61fe5cdd828b27c7914c02"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-linux-x86_64.tar.gz"
        sha256 "60f65b0cabaeb00dc70a9e8de83fbc3aa170c00c8ee0f6315723a0a71edd8ac8"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "ecabc27c9a916ca5b5dbb781b1ddd8a5d9b51ef17c9d4cf6bbda09807feed06e"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "5611236986c9cfbd96f817a98d55e54711824a45fcde58ebd1b1ebe9831bbebb"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "4cb572f18a2bc27c72c28ca35cff48e5cf9a3e0b935ec4762c61358560f340c6"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "5807f098f34578ee80091b52b51c7a3e7051a6c9702b6659c5d48db4e973f0f5"
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
