require "language/node"

class Esbuild < Formula
  desc "Extremely fast JavaScript bundler and minifier"
  homepage "https://esbuild.github.io/"
  url "https://registry.npmjs.org/esbuild/-/esbuild-0.18.2.tgz"
  sha256 "80c624c6435773efc5ffe9502840d4b2da2a3f13b0749f93c301399ce376431b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "139f31525c6062ce48db9f6fb9c6405ca973f841b3bc293dc58763abbaab15c3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "139f31525c6062ce48db9f6fb9c6405ca973f841b3bc293dc58763abbaab15c3"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "139f31525c6062ce48db9f6fb9c6405ca973f841b3bc293dc58763abbaab15c3"
    sha256 cellar: :any_skip_relocation, ventura:        "8ff28e3bbdf6ed98a34289e69b1dbd6ea947312fff50441948bb98d2e864be94"
    sha256 cellar: :any_skip_relocation, monterey:       "8ff28e3bbdf6ed98a34289e69b1dbd6ea947312fff50441948bb98d2e864be94"
    sha256 cellar: :any_skip_relocation, big_sur:        "8ff28e3bbdf6ed98a34289e69b1dbd6ea947312fff50441948bb98d2e864be94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4235758ab809c91e444e5638c6268527f18149546cfea1b81cd8a874cd1ae0af"
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"app.jsx").write <<~EOS
      import * as React from 'react'
      import * as Server from 'react-dom/server'

      let Greet = () => <h1>Hello, world!</h1>
      console.log(Server.renderToString(<Greet />))
    EOS

    system Formula["node"].libexec/"bin/npm", "install", "react", "react-dom"
    system bin/"esbuild", "app.jsx", "--bundle", "--outfile=out.js"

    assert_equal "<h1>Hello, world!</h1>\n", shell_output("node out.js")
  end
end
