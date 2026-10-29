class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "3.5.0"

  url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-macos-aarch64.tar.gz"
  sha256 "33812949bab22a7b520001f7cb82001bde21ba6fc4b3694bceb70baf93f35a3a"

  resource "cli" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-macos-aarch64.tar.gz"
        sha256 "33812949bab22a7b520001f7cb82001bde21ba6fc4b3694bceb70baf93f35a3a"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-macos-x86_64.tar.gz"
        sha256 "6ba0c243a59b34d38ce6c3f907dd6e2e8585e095ce6427eb386332bfac488d1a"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-linux-aarch64.tar.gz"
        sha256 "bd794a35d2ee4ce92e4d2fbea2253dd447ad9376ef8825828eb4c8239b20f3e4"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-linux-x86_64.tar.gz"
        sha256 "6fe0ff4ee606584603b6c60dcfb8b685d0ce54907eecd584e1caaf2ad10beaeb"
      end
    end
  end

  resource "gui" do
    on_macos do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-gui-macos-aarch64.tar.gz"
        sha256 "b188f9acfb245cf757a88dd45ba97a2c56905306981155c9efaec9b9546c4abc"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-gui-macos-x86_64.tar.gz"
        sha256 "b575dbc2b8677176b5ebbcf151789fb1cd0c629e95946801dd53cef77e8b5492"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-gui-linux-aarch64.tar.gz"
        sha256 "dbe118db289ae9e044301ed0ddfa6716cf05a7f89599d06e47e2123861c8e9af"
      end
      on_intel do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v3.5.0/lfff-gui-linux-x86_64.tar.gz"
        sha256 "9b8fb2c36f089ed92a942f8cea90f05fca48bda99318f69ab17d0b1daa633603"
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
