class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.6.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-macos-aarch64.tar.gz"
  sha256 "9558f838442cd8700e193004763c227671eec14fd3c305d2ca9e63dec67e55ba"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-macos-aarch64.tar.gz"
        sha256 "9558f838442cd8700e193004763c227671eec14fd3c305d2ca9e63dec67e55ba"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-macos-x86_64.tar.gz"
        sha256 "781a5d11768385695d1ef925086113d0112103060c474a3e8b54a785de47d978"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-linux-aarch64.tar.gz"
        sha256 "924aa762f74134980f50383fbcc84995b3f9d86a9c60403155969bd5635efd42"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-linux-x86_64.tar.gz"
        sha256 "e58d21f7fd558097fb83ac511aad871b6841d04c098621432c6bfeaf5ba49213"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "9572a7926a24e35f4a25015ff3e726657fbbef5dc015cdb408821e409e9289bf"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "7e8a166b58be32bfe99de33f7bae94796cfd8ebf962911f7ef197e15d33049e8"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "395d587b33b1518407f81564abf968b371e30724a7a03f606035d41630b4de81"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.6.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "a8d789346268259c77d69d287d247dc65e4c052c6f9b4dd7a60e6294ae404bae"
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
