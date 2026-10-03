class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.9.2"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-macos-aarch64.tar.gz"
  sha256 "544ce2fdae5bf21fe4491dcd274331b663b2acd60c3e9cee534c2c4dbb2fd651"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-macos-aarch64.tar.gz"
        sha256 "544ce2fdae5bf21fe4491dcd274331b663b2acd60c3e9cee534c2c4dbb2fd651"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-macos-x86_64.tar.gz"
        sha256 "8c9402fd634f31380129e05c446a88ff387bb3f4f457c9859cf3c7582007afa1"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-linux-aarch64.tar.gz"
        sha256 "fe8ebca6e20cdcbdfda1abaf682d4e4f8390edff0376aa4c4c7d0ce711d6431b"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-linux-x86_64.tar.gz"
        sha256 "e24c03207bff316b89f4125e8838ef4dc2c7dcf959116f45347b1bf88f92ed42"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-gui-macos-aarch64.tar.gz"
        sha256 "5eeb59936ffb1667ae59d36d985e233684c922d771e4d77a198b02198c1295f5"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-gui-macos-x86_64.tar.gz"
        sha256 "36c2d4237d50f22313d350fd94b6c071b49b5689d05de6624518f0923b40c3fe"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-gui-linux-aarch64.tar.gz"
        sha256 "634fa2a263b6ae09a766bc6d6a4629b450597c868e5eab5fba029e3052a9709c"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.9.2/lfff-gui-linux-x86_64.tar.gz"
        sha256 "938542554e991809fdf25cb50e96ae8e5ae1377da1eddcd79d10608791381aa1"
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
