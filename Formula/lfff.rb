class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.3.2"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-macos-aarch64.tar.gz"
  sha256 "e3b7b8c99f6533a6a3c7f9fd644080b9717aa48ababf912510187eacc4add346"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-macos-aarch64.tar.gz"
        sha256 "e3b7b8c99f6533a6a3c7f9fd644080b9717aa48ababf912510187eacc4add346"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-macos-x86_64.tar.gz"
        sha256 "81eff75125e8f1fb66d039e3ea820b2f62e5caf9fc05042eb019ccca98ddf525"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-linux-aarch64.tar.gz"
        sha256 "6f237afd93b15a07a96c6bbe586f4f57d5367907436650253ef2efb318878f3e"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-linux-x86_64.tar.gz"
        sha256 "011d590f91bdfe15701188848b05281f888109e8ccbd83f9d31dd7e591ecd7be"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-gui-macos-aarch64.tar.gz"
        sha256 "82df5e6dcf2356de6766ecb0897a405207b4ef5a91d49e5575f95a6a246a1d51"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-gui-macos-x86_64.tar.gz"
        sha256 "7a21bbea2d124c1e3400e61a86e4b80cc0645667d66afcfda9fa510f517018d0"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-gui-linux-aarch64.tar.gz"
        sha256 "aaf786270670372cec89e022356c0a73edb50130c76c778453f2a0781a8ff308"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.2/lfff-gui-linux-x86_64.tar.gz"
        sha256 "4f4497dd6b885fa17acfe45dd779561bf842bd749292deb311d34224f6ba2497"
      end
    end
  end

  def install
    resource("cli").stage { bin.install "lfff" }
    # On macOS the app comes from the cask, which also pulls in this formula:
    # installing it here too would clash over bin/lfff-gui.
    unless OS.mac?
      resource("gui").stage { bin.install "lfff-gui" }
    end

    generate_completions_from_executable(bin/"lfff", "completion")
  end

  def caveats
    if OS.mac?
      <<~EOS
        This formula is the command-line tool. For the app:
          brew install --cask librefastbootfirmwareflasher
      EOS
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lfff --version")
    assert_predicate bin/"lfff-gui", :exist? unless OS.mac?
  end
end
