class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.3"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-macos-aarch64.tar.gz"
        sha256 "38f2da96c9a02cc3353f06d93c47f91e4916d08b4109e7eabbfb905c461946fc"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-gui-macos-aarch64.tar.gz"
        sha256 "a9f16c40113b222aa7ed961660e09bf8737896ab67b5596eaf964d1016bc0fe5"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-macos-x86_64.tar.gz"
        sha256 "252e17d0b9d6c656f1f1f42ebce8a54367d453fafc7b390d5817f98a424ef0e0"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-gui-macos-x86_64.tar.gz"
        sha256 "5bc5bb73f29374024215e72a16545dc1c87ed4fec07578ac384de4ceb825921c"
      end
    end
  end

  on_linux do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-linux-aarch64.tar.gz"
        sha256 "e4f99ea4511b104841ebf49d72a40f24db8da081d7140f1c51fe1bbc5dc7d1ca"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-gui-linux-aarch64.tar.gz"
        sha256 "4e0bc8f03293ef9f5eea296c6e42e65841d18801ce0ccc6f04d6d50c14a046de"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-linux-x86_64.tar.gz"
        sha256 "72f4acbb2cc9702eb05020abff47852ec859088f97337e34d0a2d299c9017f29"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.3/lfff-gui-linux-x86_64.tar.gz"
        sha256 "268858d232624b2028e98730dd0837c3c11d5f3fcf96f10ad7c2d8a7b6302a4e"
      end
    end
  end

  def install
    resource("cli").stage { bin.install "lfff" }
    resource("gui").stage do |stage|
      if OS.mac?
        # Archive contains LFFF.app bundle from v2.0.3+
        if (stage + "LFFF.app").exist?
          bin.install "LFFF.app/Contents/MacOS/lfff-gui"
          prefix.install "LFFF.app"
        else
          # Fallback: raw binary (v2.0.2 and earlier)
          bin.install "lfff-gui"
        end
      else
        bin.install "lfff-gui"
      end
    end
  end

  def caveats
    if OS.mac?
      <<~EOS
        LFFF.app is installed in the Cellar. To use it from Launchpad / Finder:
          cp -r #{prefix}/LFFF.app /Applications
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lfff --version")
    assert_match version.to_s, shell_output("#{bin}/lfff-gui --version")
  end
end
