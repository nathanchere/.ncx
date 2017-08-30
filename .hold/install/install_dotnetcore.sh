#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y libunwind libicu
  dnf -y install python cmake clang llvm libicu-devel lldb-devel libunwind-devel lttng-ust-devel libuuid-devel zlib-devel libcurl-devel krb5-devel openssl-devel automake libtool


  TMPFILE="$TMPROOT/dotnet.tar.gz"
  curl -sSL https://go.microsoft.com/fwlink/?linkid=843457 -o "$TMPFILE"

  mkdir -p /opt/dotnet
  tar -zxf "$TMPFILE" -C /opt/dotnet
  ln -s /opt/dotnet/dotnet /usr/local/bin
}

main 2>&1 |& tee -a "$LOGFILE"
