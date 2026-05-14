class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.5"
  license "GPL-3.0-only"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-macos-aarch64.tar.gz"
  sha256 "3a7e536d7c67af72ba6751bb0d937b655c5cb1db11b27661fcbeb29e1f6be0f0"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-macos-aarch64.tar.gz"
        sha256 "3a7e536d7c67af72ba6751bb0d937b655c5cb1db11b27661fcbeb29e1f6be0f0"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-macos-x86_64.tar.gz"
        sha256 "9f40b6b9ba8171288b6137cb399e4a764a5f1d331f0f2efa2ef7a6ccead3499d"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-linux-aarch64.tar.gz"
        sha256 "f257afae625f84e5c0c555745078dad5dd834c300d6d03a6fc4771a2a6cbb4c9"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-linux-x86_64.tar.gz"
        sha256 "33908f63d6a07f381c34d7126183f59b1b3a17958e4f36197dbc3be15097baab"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-gui-macos-aarch64.tar.gz"
        sha256 "4302406160e62a6ad17cd21cfa066ea13be42a47e65979ee3b5c5e9627444726"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-gui-macos-x86_64.tar.gz"
        sha256 "c42433a628f1c23d46e22821ea3346facd0512655aa157176a322eda97beec03"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-gui-linux-aarch64.tar.gz"
        sha256 "8279b5cf5678dad67fb894a0b0c120e7ae118ec556ac47cfed92b6e6c23a1b4c"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.5/lfff-gui-linux-x86_64.tar.gz"
        sha256 "c8586a64a281e1df7b414319c7af80bcaddbc463487aa0f198f3e96512ff6016"
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
