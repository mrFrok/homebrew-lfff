class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.2.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-macos-aarch64.tar.gz"
  sha256 "41dc9e037a3ae9539dae747713978f79995fb8f91f10fd15354a075bafa26596"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-macos-aarch64.tar.gz"
        sha256 "41dc9e037a3ae9539dae747713978f79995fb8f91f10fd15354a075bafa26596"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-macos-x86_64.tar.gz"
        sha256 "6195c9aecfc7ebd1a4faad974b704259f7a65abd19ab729c44ad4f46c069b714"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-linux-aarch64.tar.gz"
        sha256 "e8defc4be5f5f119ff1b5a6f3cc1e2fca19dfd2cefc6d56ea77732e50531d6b2"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-linux-x86_64.tar.gz"
        sha256 "341e96f2b320bcad5cd7b202ada590f8e6a414e1f468320404b6f9d652290925"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "16f3bf6cd0457e1e98b66f50cd30c7311d37bb092e2203a0482515fa85123efb"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "546d50d47d04d0434c32951ea01ed381d3df7e79fc126ad97051da6fb16f200e"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "72a3e4dec15f29477c8ebf67bd16b6b795967733514d686f46e2b27911d2adef"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.2.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "9361ecce3a87046ceb9e4f5e69c008c44dc67794b4e8fd5895e3cbd29aafb30e"
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
