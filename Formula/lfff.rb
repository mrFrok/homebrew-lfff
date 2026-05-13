class Lfff < Formula
  desc "Free, open-source firmware flasher for Android A/B devices via fastboot"
  homepage "https://github.com/mrFrok/LibreFastbootFirmwareFlasher"
  version "2.0.2"
  license "GPL-3.0-only"

  on_macos do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-macos-aarch64.tar.gz"
        sha256 "cb519542dfbdfb01f1f16ef5f79e3540b3d53a05d89add6c07bd1526c1e27ff1"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-gui-macos-aarch64.tar.gz"
        sha256 "b67561934c3a887c082e3cbbeb2ba55eddd7c8432c5611de104a4c1cde51a16a"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-macos-x86_64.tar.gz"
        sha256 "e4219d2ccfd249e222fb887e41bdef5a955674a9c1370ab74f7955aeb76b5018"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-gui-macos-x86_64.tar.gz"
        sha256 "521838d095822d737a600b5e29680f3b5d462194a50df1e5b8c3f14b8139ab36"
      end
    end
  end

  on_linux do
    on_arm do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-linux-aarch64.tar.gz"
        sha256 "d401bdc8ec2734f55fbd8d225544dbbd289218720070dca2875babac1f79806f"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-gui-linux-aarch64.tar.gz"
        sha256 "0c976e4dc3d89181715b95f0c1e7eeeaa88707d6c5c91dd6248ac04c7f575227"
      end
    end
    on_intel do
      resource "cli" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-linux-x86_64.tar.gz"
        sha256 "9a86698f81a885d3990db5df132a6ce89bac44aa606819bfae463646bc0a0fe1"
      end
      resource "gui" do
        url "https://github.com/mrFrok/LibreFastbootFirmwareFlasher/releases/download/v2.0.2/lfff-gui-linux-x86_64.tar.gz"
        sha256 "7878201d8576140fa0e32417964090619d57bf75f618cae5d094ab69f58f9322"
      end
    end
  end

  def install
    resource("cli").stage { bin.install "lfff" }
    resource("gui").stage { bin.install "lfff-gui" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lfff --version")
    assert_match version.to_s, shell_output("#{bin}/lfff-gui --version")
  end
end
