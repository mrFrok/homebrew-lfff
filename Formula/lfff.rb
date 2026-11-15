class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.7.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-macos-aarch64.tar.gz"
  sha256 "fd901231de5842ef1900fbd3c5d8d401869dba3381c20c9a326dff7364552ea9"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-macos-aarch64.tar.gz"
        sha256 "fd901231de5842ef1900fbd3c5d8d401869dba3381c20c9a326dff7364552ea9"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-macos-x86_64.tar.gz"
        sha256 "85c61c18b0adfb7afee9c8056950dda14e3215beb871a6408c76c16a2619905e"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-linux-aarch64.tar.gz"
        sha256 "ef279c003b6ddeed07e9119f10515af1eca9e72c27d51eed9f910baa2711c827"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-linux-x86_64.tar.gz"
        sha256 "d1212cfa65ff08ef66426620b19722bdae73b6045ab724c325ad11f7fa230d90"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "f65a96c3d7c5b8f792ad2b97c3691cacda66f53ae75d8b230f168bed59c711ed"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "eb5ee10909489da998b1b702d284f7a150559c2598cf91fdbf2016968bf3e006"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "a79a03a4f67ea13ad5351d06b1cf633dc8480b26edfbcebfda7aa14167710792"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.7.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "48a8c75dae3d4c71a9aad9022e44256a4e2a24c510d68f088f9c2c82a6123720"
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
