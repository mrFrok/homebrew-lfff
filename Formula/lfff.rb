class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.1.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-macos-aarch64.tar.gz"
  sha256 "3aa1e5a8fa1438358c3f0fce73b8b810c17d5d2ada0f19045989125c89a9818b"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-macos-aarch64.tar.gz"
        sha256 "3aa1e5a8fa1438358c3f0fce73b8b810c17d5d2ada0f19045989125c89a9818b"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-macos-x86_64.tar.gz"
        sha256 "59103f93587761bbe82878029037e44cb64ece9c4a60e183b41a1d06bc75ff65"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-linux-aarch64.tar.gz"
        sha256 "3297a46a6887f1260ce789e8c5632e14cbc313e7e4dc5203de1be8e845354ae8"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-linux-x86_64.tar.gz"
        sha256 "fdaedab546af5a08a3287c18e5509f823dc89b0f7ef2a76c292586d8003bf329"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "7903c8f304fb17092bc3afbb6180520fcd5458c8228376f0119eb8bd2490a39b"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "835f7a56eee86bee0d996f725fec55dc86cba01f15ff6054d0c88dec9730c059"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "8b9fbcf30855e5cdfdf0ae889d3ad185bb0cde54fb173620f9d9787a2eb9da71"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.1.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "8f6a954d978ad301a30d39214eaf383046da24cc9040fdc179073e2cb213d1d3"
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
