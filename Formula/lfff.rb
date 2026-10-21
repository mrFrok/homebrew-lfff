class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.0.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-macos-aarch64.tar.gz"
  sha256 "7116da5b235df8ac61cca769e20e9996ff2f313f0b0af9935ff35aace73bbc4d"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-macos-aarch64.tar.gz"
        sha256 "7116da5b235df8ac61cca769e20e9996ff2f313f0b0af9935ff35aace73bbc4d"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-macos-x86_64.tar.gz"
        sha256 "841f06e10c213f748b47fdd5dcbb5eb2f9da1384db0d7666623a75c36d539d0f"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-linux-aarch64.tar.gz"
        sha256 "c8262e889990417c198a51adecbdf124622ebf0e5e2b8b6b8e77641b61fee2a5"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-linux-x86_64.tar.gz"
        sha256 "2e78eaa08ced7231c643f59fcffce7d167c6c00b269a990bbb6777b7fcc45d82"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "bb28c7587157285942def01fbbbc27f56d0073601926fd698c2b08a092d5aeac"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "efe880af08370753169c8a3c88b9e6132516228fda01d1626d020feb60388e7e"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "9b3a80ebcc94cd47d156cc0788adb07e185b5ee548d0b67494f0e6a035373bc6"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.0.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "44dd910daedcab7ca09b259b29e4843e5d1b8bfd3cea69bbf8fc1db29cc12fc5"
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
