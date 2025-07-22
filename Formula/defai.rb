class Defai < Formula
  desc "CLI tool for developing and publishing DEFAI elements"
  homepage "https://github.com/defaiza/defai-monorepo"
  version "1.0.0"
  
  # You'll need to update this URL and SHA256 after building and releasing
  url "https://github.com/defaiza/defai-monorepo/releases/download/v1.0.0/defai-cli-v1.0.0.tar.gz"
  sha256 "61718b0379547f3f1ea9732d6cbd882113ea40de520e5039140deab78e7c1ed8"
  
  license "MIT"

  depends_on "node"

  def install
    # Install the CLI package
    libexec.install Dir["*"]
    
    # Create wrapper script
    (bin/"defai").write <<~EOS
      #!/bin/bash
      export NODE_PATH="#{libexec}/node_modules:$NODE_PATH"
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/bin/defai-element.js" "$@"
    EOS
    
    chmod 0755, bin/"defai"
  end

  test do
    # Test that the CLI runs and shows help
    assert_match "DEFAI Element CLI", shell_output("#{bin}/defai --help 2>&1")
  end
end 