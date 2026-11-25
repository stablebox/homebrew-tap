cask "stablebar" do
  version "0.19.0"
  sha256 "9c27305fa99a7377dd4a61656714b7893229d6a6c82800fe90b3c19a609b0f7e"

  url "https://github.com/stablebox/StableBar/releases/download/v#{version}/StableBar.dmg"
  name "StableBar"
  desc "Native, configurable menu bar"
  homepage "https://stablebar.app/"

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "StableBar.app"

  # Homebrew also runs this stanza to upgrade or reinstall. --homebrew-uninstall waits until brew exits, then undoes
  # what StableBar changed on the Mac, as its own Uninstall does, only if StableBar is no longer installed.
  uninstall quit:   "org.stablebar.app",
            script: {
              executable:   "/bin/sh",
              args:         [
                "-c",
                'if [ -x "$1" ]; then exec "$1" --homebrew-uninstall; fi',
                "sh",
                "#{appdir}/StableBar.app/Contents/MacOS/StableBar",
              ],
              must_succeed: false,
            }

  zap trash: [
    "~/.config/stablebar",
    "~/Library/Caches/org.stablebar.app",
    "~/Library/Caches/org.stablebar.app.sparkle",
    "~/Library/Caches/StableBar",
    "~/Library/HTTPStorages/org.stablebar.app",
    "~/Library/Preferences/org.stablebar.app.plist",
  ]
end
