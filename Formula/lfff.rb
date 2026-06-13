class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.4.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-macos-aarch64.tar.gz"
  sha256 "dbd3519639945216570488dab4bd4f4b70538435af1a3777f71fc09fd602a72f"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-macos-aarch64.tar.gz"
        sha256 "dbd3519639945216570488dab4bd4f4b70538435af1a3777f71fc09fd602a72f"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-macos-x86_64.tar.gz"
        sha256 "1a34167e9711aa5a0ea1cce9537ffff690117c3b5a8098a4ee2f3de5a5d80f84"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-linux-aarch64.tar.gz"
        sha256 "67c3361ec99e887a552a08e0ea333c67025ba4f0efb01a400d55e5b2aa9fd7c1"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-linux-x86_64.tar.gz"
        sha256 "5b9d9800e079213c2ec9da6dbf22d4817def4f5f95d14778388806a4c054576b"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "ea13eb3ce959ff9cbe3eada477d262ca3f381a635f3b9e0af7a6d199a2967cb8"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "6c6117022f94e6c91aa51bc09e37b8050d40d6f019fccceffd6dd668a7409b47"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "35f91e092632138eebf7089d642990afa0fcc9403c808f9c2f6c3e3e14fe16e1"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.4.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "e1a67421e1d510f81b6290c8227ec6ccbcbc2bf33381f051016520d750c8d23c"
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
