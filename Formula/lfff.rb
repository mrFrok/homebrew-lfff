class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.4"
  license "GPL-3.0-only"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-macos-aarch64.tar.gz"
      sha256 "d7587947ea9a0e46b1d6734aa57bbf35465abda2058570f12dfacbd93e44db30"
    else
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-macos-x86_64.tar.gz"
      sha256 "adcc8ef357e9ed8d791c7315678c9f7bffad0545e4331a0d1ce9868ffe6b7c82"
    end
  else
    if Hardware::CPU.arm?
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-linux-aarch64.tar.gz"
      sha256 "3a6f93115a551311c288085c9acf8b4aa1752be186908f233eacbc1c05b7927d"
    else
      url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-linux-x86_64.tar.gz"
      sha256 "178931c71490f675abbb2eba32648d73c7265b0480f42b9dae6cf6a6076e2e21"
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-gui-macos-aarch64.tar.gz"
        sha256 "09e61ff6de73d8a29b98aba70560a6a0f814c7a1d70c08bfb641bc1eff60496d"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-gui-macos-x86_64.tar.gz"
        sha256 "32ca2e4db2da5e388158ec2d390365e78f228ae316a126412c466d2b1eb12f31"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-gui-linux-aarch64.tar.gz"
        sha256 "1fd0c5d9b2ae2b936e6c4a1ee271e813439a73e9ba8a3946c46d39f7167cf593"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.4/lfff-gui-linux-x86_64.tar.gz"
        sha256 "4de3ac26a8f76f2c1932a7715c955340de1a438afe912e0d75b3243caf19efb2"
      end
    end
  end

  def install
    bin.install "lfff"
    resource("gui").stage do |stage|
      if OS.mac? && (stage + "LFFF.app").exist?
        bin.install "LFFF.app/Contents/MacOS/lfff-gui"
        prefix.install "LFFF.app"
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
    assert_predicate bin/"lfff-gui", :exist?
  end
end
