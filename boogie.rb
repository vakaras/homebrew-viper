require "formula"
class Boogie < Formula
  homepage "http://boogie.codeplex.com"
  url "https://github.com/boogie-org/boogie.git"
  version "2.3"

  #FIXME this formula installs a wrong version of mono;
  # need to satisfy this dep manually: http://www.mono-project.com/download/
  #
  #depends_on "mono"

  def install
    system "curl", "-L", "-o", "nuget.exe", "https://nuget.org/nuget.exe"
    system "/usr/local/bin/mono", "nuget.exe", "restore", "./Source/Boogie.sln"
    system "/usr/local/bin/xbuild", "Source/Boogie.sln"
    system "mkdir", "#{prefix}/Binaries"
    prefix.install Dir["Binaries/*"]
    system "echo '#!/bin/sh'$'\\n''mono\ #{prefix}/Boogie.exe\ \"$@\"'$'\\n' > boogie"
    system "chmod", "+x", "boogie"
    bin.install "boogie"
  end

  test do
    system "boogie"
  end
end
