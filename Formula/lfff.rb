class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.6.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-macos-aarch64.tar.gz"
  sha256 "3027cf3b602c304a684e52a7904cbe5a64f9ae6be97f08408ea5ee6e1c174a17"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-macos-aarch64.tar.gz"
        sha256 "3027cf3b602c304a684e52a7904cbe5a64f9ae6be97f08408ea5ee6e1c174a17"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-macos-x86_64.tar.gz"
        sha256 "7b0e47b39f93b1ba1bbeb2f9ab21f505222cfe9c4e50757e1035c3d9cdb4515e"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-linux-aarch64.tar.gz"
        sha256 "2d39c07a16e9da787b30aa020e92ce0b107a718636dbb3abcc209e3a9cfda192"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-linux-x86_64.tar.gz"
        sha256 "aa5f195fb06cc0878dbe22bd4e1b78d2f47455292990fdf4ebafffcac0d9de4a"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "04dae19929c7126bc8cafb1a86cfbe5534a2b8d492e67ef043b8390cacaf58d9"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "e911918eb72d312adfa720c67a040c38e3ecf2f3c732d6cc4b593e94f081f2e2"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "2b94d0aea9b77fe0cac6e705150e67eb9fa136e11d621949ae149535edb46ba0"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.6.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "8504e7729bf47e2019bfb2fa292e449923508412f18238837fb3ab466c275ea4"
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
