class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.7.1"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-macos-aarch64.tar.gz"
  sha256 "4d6287666e0861b7052e6b810049fa12cb6c4e21eea89860b71756204ed329be"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-macos-aarch64.tar.gz"
        sha256 "4d6287666e0861b7052e6b810049fa12cb6c4e21eea89860b71756204ed329be"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-macos-x86_64.tar.gz"
        sha256 "eec149e096366f6bbc5e53beea4a73402ef0e1f92c9181a78f7a32686235decb"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-linux-aarch64.tar.gz"
        sha256 "3b97190a2e4daab0676f44a90481f0f34365caa3f539bc68935e98d942c2967e"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-linux-x86_64.tar.gz"
        sha256 "c7f4b419d0994f6319ac57aadd784883177641b344b571f07643167be640f6fd"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "7c9d8d0ffe40f2152fad22f992f3f6d36524351193e6a7e6af238b7f9ba5aeb2"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "0fc05713e7086caaa53a8ccc804536022665f7a20227e2863ccdf0856b2f0cbc"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "38bff39407e2802b1784339cd09d76ca1504df679add7ab9594bd1a00f162c03"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.7.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "ab7c091bd495d95adf0993e2cf37742cddf7c9c59216a48a03d8bdd96b9aed7b"
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
