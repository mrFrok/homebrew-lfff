class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.8.1"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-macos-aarch64.tar.gz"
  sha256 "584e5a499cff4f2af946f658cc85724f18b2fe5b76a2e0b65e887b92d85dfcd4"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-macos-aarch64.tar.gz"
        sha256 "584e5a499cff4f2af946f658cc85724f18b2fe5b76a2e0b65e887b92d85dfcd4"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-macos-x86_64.tar.gz"
        sha256 "645d4d994ff477c185cb0e959ba91b303f4628b9986da59614fcea308f1a8084"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-linux-aarch64.tar.gz"
        sha256 "772b426daf12af9a660fddd40aa07d781ae17c6973d9213f565080ef37925dc3"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-linux-x86_64.tar.gz"
        sha256 "9b353c1516d37694bb971aa0f15f05b1fa2d94af62ac9e6beb42fb48246f9946"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "418977a3d8e72207c8da63afd3ea506e36d7ef747114eee4a9d39458676fc64c"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "d74d84b28ef5f3b23cd336bba7069e9d198b34a1aca5faac82759f4966a6fd50"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "6108b64041a1d925a348e396acaed5f614d4f5a618695a9af1e0f3a2e370403a"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.8.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "dfbbe4b5a7d2577b0b37cadbcd6c9b238eafe72087166fadcc885496f0a10cdc"
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
