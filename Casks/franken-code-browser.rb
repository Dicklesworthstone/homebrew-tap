cask "franken-code-browser" do
  version "0.1.0"
  sha256 "698293fc864d984fda3deea37769abd84adcc7fd44a9dbffd6bd9bc214244b76"

  url "https://github.com/Dicklesworthstone/franken_code_browser/releases/download/v#{version}/FrankenCodeBrowser-macos-arm64.dmg"
  name "FrankenCodeBrowser"
  desc "Spatial source browser with a native Metal atlas"
  homepage "https://github.com/Dicklesworthstone/franken_code_browser"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "FrankenCodeBrowser.app"
end
