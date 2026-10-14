# Homebrew cask（ONE-58）。scripts/release-mac.sh が版と sha256 を入れて dist/mac/<version>/cuff-agent.rb に書き出す。
# tap（ShinyaAzuma/homebrew-cuff）の Casks/cuff-agent.rb に置く：
#   brew install --cask shinyaazuma/cuff/cuff-agent
cask "cuff-agent" do
  version "0.1.0"
  sha256 "b9abeb04c7c88b705eca0e61afc141602fed3465eb158928f864163514578c2b"

  url "https://github.com/ShinyaAzuma/cuff-agent-releases/releases/download/v#{version}/CuffAgent-#{version}.dmg"
  name "Cuff Agent"
  desc "Apple Watch から声で AI エージェントに仕事を任せる、Mac の常駐ゲートウェイ"
  homepage "https://cuffagent.app/"

  livecheck do
    url "https://cuffagent.app/appcast.xml"
    strategy :sparkle, &:short_version
  end

  # 更新はアプリの Sparkle が行う
  auto_updates true
  depends_on macos: ">= :tahoe"
  depends_on arch: :arm64

  app "Cuff Agent.app"

  uninstall launchctl: "com.cuff.gateway.app",
            quit:      "com.shinyaazuma.cuffagent.mac"

  zap trash: [
    "~/.cuff",
    "~/Library/Caches/com.shinyaazuma.cuffagent.mac",
    "~/Library/Preferences/com.shinyaazuma.cuffagent.mac.plist",
  ]
end
