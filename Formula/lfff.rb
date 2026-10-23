class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.3.1"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-macos-aarch64.tar.gz"
  sha256 "525754c9da1faa29ab8332e36eec0a45e1c9e868a6b274b9fb9a625de3ef8090"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-macos-aarch64.tar.gz"
        sha256 "525754c9da1faa29ab8332e36eec0a45e1c9e868a6b274b9fb9a625de3ef8090"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-macos-x86_64.tar.gz"
        sha256 "d5030ec71ff7558f5a5e0198cf4d73f3008802b828dece67c7ae501a6b4ecb6f"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-linux-aarch64.tar.gz"
        sha256 "10cf893b34c8f2c83e19e376bb6f892b4bee2018199b0959a0df58e1c4b97d22"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-linux-x86_64.tar.gz"
        sha256 "cfbe930263c1f752c2d7762eb9b9b34172d68a814ca69d263bcf459ad10bc71f"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-gui-macos-aarch64.tar.gz"
        sha256 "4197f607957c2d77327ea5f8f645dc50f96ea3db88179f91195a2e71e2b41e72"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-gui-macos-x86_64.tar.gz"
        sha256 "c5937a0eb32c4d86b3eb90f080ef622784b03bb9396acfbfd4f7b29143cb9382"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-gui-linux-aarch64.tar.gz"
        sha256 "66528506429d40f545a3ca18b0ad6dd39bf11b86ec8cdfd728401e700ca6d1da"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.3.1/lfff-gui-linux-x86_64.tar.gz"
        sha256 "20b335de7f07d3895fdf8c6d383b10e43cdba2ce2d93f168290739cd6aae9cb4"
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
