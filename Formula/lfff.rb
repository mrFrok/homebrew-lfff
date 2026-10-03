class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.9.3"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-macos-aarch64.tar.gz"
  sha256 "284410c429fb30b7c4c0b95a17122f92fe690fcca5136cf15a05d2b6069ef79d"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-macos-aarch64.tar.gz"
        sha256 "284410c429fb30b7c4c0b95a17122f92fe690fcca5136cf15a05d2b6069ef79d"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-macos-x86_64.tar.gz"
        sha256 "740840eec30228c0c22e61c2e6e9da85cbb163be479841e9c14ef226312277ca"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-linux-aarch64.tar.gz"
        sha256 "2a53ac2e654e3aa2b7837800c4dfb430ba8358a625a35edadbd712e219fc9859"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-linux-x86_64.tar.gz"
        sha256 "fc531a6100751d42d771a358195e98da560eccacfb8c45aaca5f312218e139ba"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-gui-macos-aarch64.tar.gz"
        sha256 "238a22b1b570c1634e02a012aef42bb92267f010918605a4b97361455777863a"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-gui-macos-x86_64.tar.gz"
        sha256 "b8e389a3a92a1419f90907d2203b05e735de58f5bb6e46980d820239175b9147"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-gui-linux-aarch64.tar.gz"
        sha256 "035612b7d862832de38cefce5dbb683ec72172ea2c557be4ba271a3e21904513"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.3/lfff-gui-linux-x86_64.tar.gz"
        sha256 "5f8b7832c1a741cd3b50f8f0bc8019b7832b8e1c1554c7f45aaf778d269e93f5"
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
