class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.5.1"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-macos-aarch64.tar.gz"
  sha256 "0da364a9ada9d8ffb25aea2af89703656477a1ea08f8a9b50d21f31d54102ea8"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-macos-aarch64.tar.gz"
        sha256 "0da364a9ada9d8ffb25aea2af89703656477a1ea08f8a9b50d21f31d54102ea8"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-macos-x86_64.tar.gz"
        sha256 "b9048b4e4b95c671715939e3d6b5987117e75b01c634179fbaeb8ec50c2fa1ea"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-linux-aarch64.tar.gz"
        sha256 "f3bcda7654cf3a79c89eaba5c0f262f255e47b0e20eb942c9a2d4f63d514b59f"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-linux-x86_64.tar.gz"
        sha256 "4258f2446bc097c6a1092e210d4e261c64a61250968fe3b167b02c60b2938d76"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "791168766d8468f920e3fc01df597bf7b5b0a3b5cc08886f54a65afcef6af1f9"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "d8c4576fbf754eca9b1b2e58ab6ecc7ab54c3ec1105e21561f047f07ae00fb45"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "d4a83b67cdc659a1b37522b4f2aa2edeea0a0ca9192a8299ebf3db62110f88e3"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "a704e65e848de5c6683b64a4e336f2a3ce44d2857ce0d9074336a50a154b1b7a"
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
