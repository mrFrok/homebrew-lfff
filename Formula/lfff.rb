class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.4.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-macos-aarch64.tar.gz"
  sha256 "c5a439ea4b893fc3bb647f75833a2e39cb8050b6b7b83d4b3d52043ed9dce0eb"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-macos-aarch64.tar.gz"
        sha256 "c5a439ea4b893fc3bb647f75833a2e39cb8050b6b7b83d4b3d52043ed9dce0eb"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-macos-x86_64.tar.gz"
        sha256 "0bd2716897f2be5fcca4b1eb29af4047ccbc688ae3571036d91550fd24461c41"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-linux-aarch64.tar.gz"
        sha256 "667a33f7e52dd996077dc74f2a85a28878e7e2a5407cec8dda4803a42b205674"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-linux-x86_64.tar.gz"
        sha256 "1df39a6c1231147e8be554873d282776a63c552fc64f86451d613ca98851e08e"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "85150d0599bcb21dfc9a67f1c794f8d26a3e2ca6f0fd02784f1f74b3d5aadb13"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "be971007e27dfd0dcc23194662fce8bf2b69d932c41e7c9ea1d9e7905047675b"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "551e553d8b1215480409367e26348b6772c79f21109bc1acdedcb9a868e39fa0"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.4.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "8e40970b35762cbb47bc4db5d94f573e13e75b356578f5e0786a1c3a4f457576"
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
