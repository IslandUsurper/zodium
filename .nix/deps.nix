{ lib, beamPackages, overrides ? (x: y: {}) }:

let
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildErlangMk = lib.makeOverridable beamPackages.buildErlangMk;

  self = packages // (overrides self packages);

  packages = with beamPackages; with self; {
    nimble_parsec = buildMix rec {
      name = "nimble_parsec";
      version = "1.4.2";

      src = fetchHex {
        pkg = "nimble_parsec";
        version = "${version}";
        sha256 = "4b21398942dda052b403bbe1da991ccd03a053668d147d53fb8c4e0efe09c973";
      };

      beamDeps = [];
    };

    pegasus = buildMix rec {
      name = "pegasus";
      version = "0.2.6";

      src = fetchHex {
        pkg = "pegasus";
        version = "${version}";
        sha256 = "0ac159f0ccab7967cf90208327cc8a35788874814c8d78e19d47104d3fc049b9";
      };

      beamDeps = [ nimble_parsec ];
    };

    protoss = buildMix rec {
      name = "protoss";
      version = "1.1.0";

      src = fetchHex {
        pkg = "protoss";
        version = "${version}";
        sha256 = "c2f874383dd047fcfdf467b814dd33a208a4d24a467aef90d86185b41a0752ad";
      };

      beamDeps = [];
    };

    zig_get = buildMix rec {
      name = "zig_get";
      version = "0.15.2";

      src = fetchHex {
        pkg = "zig_get";
        version = "${version}";
        sha256 = "e6b0028f2d5a8da791ff8037deff5b492784017d8d241e598377a24bd765f56f";
      };

      beamDeps = [];
    };

    zig_parser = buildMix rec {
      name = "zig_parser";
      version = "0.6.0";

      src = fetchHex {
        pkg = "zig_parser";
        version = "${version}";
        sha256 = "bb7a1523b69f7f8f6b74ba5bf9dabc83f512c0cd67d9eebba1c501a529a2f95e";
      };

      beamDeps = [ pegasus ];
    };

    zigler = buildMix rec {
      name = "zigler";
      version = "0.15.2";

      src = fetchHex {
        pkg = "zigler";
        version = "${version}";
        sha256 = "6bf96df41e281a70147e8826e439e24945f0222e08d058fc544da84f5c7ea8dd";
      };

      beamDeps = [ protoss zig_get zig_parser ];
    };
  };
in self

