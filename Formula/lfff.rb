class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.3.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-macos-aarch64.tar.gz"
  sha256 "5f94ab323b3a03bc89542ccd185d0b1ad027afdde4f8dc4dee2837325d2b0162"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-macos-aarch64.tar.gz"
        sha256 "5f94ab323b3a03bc89542ccd185d0b1ad027afdde4f8dc4dee2837325d2b0162"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-macos-x86_64.tar.gz"
        sha256 "b723e0a3cf173f9999c3172b6c22df33fe312c2eb8681150d4f079c78e6249e7"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-linux-aarch64.tar.gz"
        sha256 "2876db9d6e411b3007ecdb5fe8475324f64521df4fc9f6fd80699700e52d967f"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-linux-x86_64.tar.gz"
        sha256 "fcead69548abf034d4f5e5afaa1a5c6c1a71613972b865accb7c16f523b5a840"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "8f586484e890e92628b8ebaf8dd5d6f753faefd55cd707e870ea62c97b2742df"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "81fd08ee8a4218108f86ecda20392f8c0ad2ba887062d02bc3c0898fc9477625"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "4eb1a93c75cbf5848967a7c8daacd7d125b2a30d330051881530846d46ae68e1"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "046a3c5f1afb19ede17aacbce95818f1732b9bbe5420986d806e97d455c7f4be"
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
