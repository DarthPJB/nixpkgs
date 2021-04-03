{ mkDerivation, fetchurl, makeWrapper, lib, php }:
let
  pname = "psalm";
  version = "4.6.1";
in
mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://github.com/vimeo/psalm/releases/download/${version}/psalm.phar";
    sha256 = "sha256-YFeTSIfZ2u1KmpoKV5I7pMMvCk3u5ILktsunvoDnBsg=";
  };

  phases = [ "installPhase" ];
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    install -D $src $out/libexec/psalm/psalm.phar
    makeWrapper ${php}/bin/php $out/bin/psalm \
      --add-flags "$out/libexec/psalm/psalm.phar"
  '';

  meta = with lib; {
    description = "A static analysis tool for finding errors in PHP applications";
    license = licenses.mit;
    homepage = "https://github.com/vimeo/psalm";
    maintainers = teams.php.members;
  };
}
