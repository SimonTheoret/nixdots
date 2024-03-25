{
  enable = true;
  profiles = {
    "3screens" = {
      fingerprint = {
        DP-0 =
          "00ffffffffffff0006b3af2701010101211e0104a53c22783b07f0a655539e270e5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c450056502100001e000000fd002890a0a021010a202020202020000000fc0056473237380a20202020202020000000ff004c384c4d51533037343732320a01eb020318f14b900504030201111213141f2309070783010000023a801871382d40582c450056502100001e8a4d80a070382c403020350056502100001afe5b80a0703835403020350056502100001a866f80a0703840403020350056502100001afc7e8088703812401820350056502100001e000000000000000000000000006b";
        DP-2 =
          "00ffffffffffff0006b32027010101010e200104a53c22783b07f0a655539e270e5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c450056502100001e000000fd0028a5c3c329010a202020202020000000fc0056473237380a20202020202020000000ff004e334c4d51533137323436300a012d020318f14b900504030201111213141f2309070783010000a49c80a0703859403020350056502100001a8a4d80a070382c403020350056502100001afe5b80a0703835403020350056502100001a866f80a0703840403020350056502100001afc7e8088703812401820350056502100001e00000000000000000000000000fc";
        HDMI-1 =
          "00ffffffffffff0006b3ad270101010113210103803c2278ea07f0a655539e270e5054b7ef00714f8180814081c081009500b3000101023a801871382d40582c450056502100001e000000fd0028781e8c1e000a202020202020000000fc0056473237380a20202020202020000000ff0052354c4d51533034313730350a012302032bf14d900504030201111213141f403f230907078301000067030c0010000044681a000001012878008a4d80a070382c403020350056502100001afe5b80a0703835403020350056502100001a866f80a0703840403020350056502100001a0000000000000000000000000000000000000000000000000000000000004f";
      };
      config = {
        HDMI-0.enable = false;
        DP-1.enable = false;
        DP-3.enable = false;
        HDMI-1 = {
          enable = true;
          crtc = 2;
          mode = "1920x1080";
          position = "0x0";
          rate = "120.00";
          rotate = "right";
        };
        DP-0 = {
          enable = true;
          crtc = 0;
          mode = "1920x1080";
          position = "3000x0";
          rate = "144.00";
          rotate = "left";
        };
        DP-2 = {
          enable = true;
          primary = true;
          crtc = 1;
          mode = "1920x1080";
          position = "1080x271";
          rate = "165.00";
        };
      };
    };
  };
}