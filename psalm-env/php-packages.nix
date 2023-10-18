{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
  packages = {
    "amphp/amp" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "amphp-amp-9d5100cebffa729aaffecd3ad25dc5aeea4f13bb";
        src = fetchurl {
          url = "https://api.github.com/repos/amphp/amp/zipball/9d5100cebffa729aaffecd3ad25dc5aeea4f13bb";
          sha256 = "0pwk9xx2wr5h0lyihccinvzlkk17hc4gjc0w5jsinxsnazfqhmn1";
        };
      };
    };
    "amphp/byte-stream" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "amphp-byte-stream-acbd8002b3536485c997c4e019206b3f10ca15bd";
        src = fetchurl {
          url = "https://api.github.com/repos/amphp/byte-stream/zipball/acbd8002b3536485c997c4e019206b3f10ca15bd";
          sha256 = "14jqc5igivq54bwj0gr9rpbnw1rapi11ddhmvbkx1251a1bbyzr2";
        };
      };
    };
    "barryvdh/laravel-ide-helper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "barryvdh-laravel-ide-helper-81d5b223ff067a1f38e14c100997e153b837fe4a";
        src = fetchurl {
          url = "https://api.github.com/repos/barryvdh/laravel-ide-helper/zipball/81d5b223ff067a1f38e14c100997e153b837fe4a";
          sha256 = "0z1zpkznvrqs0wnr0zj8fj832a8bqgzkhk4s3j6mmaxjkxbxa8s9";
        };
      };
    };
    "barryvdh/reflection-docblock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "barryvdh-reflection-docblock-e6811e927f0ecc37cc4deaa6627033150343e597";
        src = fetchurl {
          url = "https://api.github.com/repos/barryvdh/ReflectionDocBlock/zipball/e6811e927f0ecc37cc4deaa6627033150343e597";
          sha256 = "08gsiwza5n66mkpc07lpc0w505rrz0rv0dp9jiwk3ain0jl54yfw";
        };
      };
    };
    "brick/math" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "brick-math-0ad82ce168c82ba30d1c01ec86116ab52f589478";
        src = fetchurl {
          url = "https://api.github.com/repos/brick/math/zipball/0ad82ce168c82ba30d1c01ec86116ab52f589478";
          sha256 = "04kqy1hqvp4634njjjmhrc2g828d69sk6q3c55bpqnnmsqf154yb";
        };
      };
    };
    "composer/class-map-generator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-class-map-generator-953cc4ea32e0c31f2185549c7d216d7921f03da9";
        src = fetchurl {
          url = "https://api.github.com/repos/composer/class-map-generator/zipball/953cc4ea32e0c31f2185549c7d216d7921f03da9";
          sha256 = "07lj173vnxccxzw5yaci16zrxl338jx84xnwmyz71fsvv7jkzcc8";
        };
      };
    };
    "composer/pcre" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-pcre-00104306927c7a0919b4ced2aaa6782c1e61a3c9";
        src = fetchurl {
          url = "https://api.github.com/repos/composer/pcre/zipball/00104306927c7a0919b4ced2aaa6782c1e61a3c9";
          sha256 = "0y7adswd7hq9fsnwqdkrjwimnpzyklw71myypybm65xk43wf3ck8";
        };
      };
    };
    "composer/semver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-semver-35e8d0af4486141bc745f23a29cc2091eb624a32";
        src = fetchurl {
          url = "https://api.github.com/repos/composer/semver/zipball/35e8d0af4486141bc745f23a29cc2091eb624a32";
          sha256 = "1sr3l0k87fi9z95j4jh9xqs4dz1315mj4bi95sij35d2ad3rcs19";
        };
      };
    };
    "composer/xdebug-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "composer-xdebug-handler-ced299686f41dce890debac69273b47ffe98a40c";
        src = fetchurl {
          url = "https://api.github.com/repos/composer/xdebug-handler/zipball/ced299686f41dce890debac69273b47ffe98a40c";
          sha256 = "1hnhrp26mk3zjsp6cl351b12bcbbbdglc677vjz9n8l7qj466b0h";
        };
      };
    };
    "dflydev/dot-access-data" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dflydev-dot-access-data-f41715465d65213d644d3141a6a93081be5d3549";
        src = fetchurl {
          url = "https://api.github.com/repos/dflydev/dflydev-dot-access-data/zipball/f41715465d65213d644d3141a6a93081be5d3549";
          sha256 = "1vgbjrq8qh06r26y5nlxfin4989r3h7dib1jifb2l3cjdn1r5bmj";
        };
      };
    };
    "dnoegel/php-xdg-base-dir" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dnoegel-php-xdg-base-dir-8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd";
        src = fetchurl {
          url = "https://api.github.com/repos/dnoegel/php-xdg-base-dir/zipball/8f8a6e48c5ecb0f991c2fdcf5f154a47d85f9ffd";
          sha256 = "02n4b4wkwncbqiz8mw2rq35flkkhn7h6c0bfhjhs32iay1y710fq";
        };
      };
    };
    "doctrine/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-cache-1ca8f21980e770095a31456042471a57bc4c68fb";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/cache/zipball/1ca8f21980e770095a31456042471a57bc4c68fb";
          sha256 = "1p8ia9g3mqz71bv4x8q1ng1fgcidmyksbsli1fjbialpgjk9k1ss";
        };
      };
    };
    "doctrine/dbal" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-dbal-5b7bd66c9ff58c04c5474ab85edce442f8081cb2";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/dbal/zipball/5b7bd66c9ff58c04c5474ab85edce442f8081cb2";
          sha256 = "0v525nm588i6r94h6nrpx358axfmdkwh0xdgy1bh5cwkb3iaphha";
        };
      };
    };
    "doctrine/deprecations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-deprecations-4f2d4f2836e7ec4e7a8625e75c6aa916004db931";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/deprecations/zipball/4f2d4f2836e7ec4e7a8625e75c6aa916004db931";
          sha256 = "1kxy6s4v9prkfvsnggm10kk0yyqsyd2vk238zhvv3c9il300h8sk";
        };
      };
    };
    "doctrine/event-manager" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-event-manager-750671534e0241a7c50ea5b43f67e23eb5c96f32";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/event-manager/zipball/750671534e0241a7c50ea5b43f67e23eb5c96f32";
          sha256 = "1inhh3k8ai8d6rhx5xsbdx0ifc3yjjfrahi0cy1npz9nx3383cfh";
        };
      };
    };
    "doctrine/inflector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-inflector-f9301a5b2fb1216b2b08f02ba04dc45423db6bff";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/inflector/zipball/f9301a5b2fb1216b2b08f02ba04dc45423db6bff";
          sha256 = "1kdq3sbwrzwprxr36cdw9m1zlwn15c0nz6i7mw0sq9mhnd2sgbrb";
        };
      };
    };
    "doctrine/lexer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-lexer-84a527db05647743d50373e0ec53a152f2cde568";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/lexer/zipball/84a527db05647743d50373e0ec53a152f2cde568";
          sha256 = "1wn3p8vjq3hqzn0k6dmwxdj2ykwk3653h5yw7a57avz9qkb86z70";
        };
      };
    };
    "dragonmantank/cron-expression" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dragonmantank-cron-expression-adfb1f505deb6384dc8b39804c5065dd3c8c8c0a";
        src = fetchurl {
          url = "https://api.github.com/repos/dragonmantank/cron-expression/zipball/adfb1f505deb6384dc8b39804c5065dd3c8c8c0a";
          sha256 = "1gw2bnsh8ca5plfpyyyz1idnx7zxssg6fbwl7niszck773zrm5ca";
        };
      };
    };
    "egulias/email-validator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "egulias-email-validator-ebaaf5be6c0286928352e054f2d5125608e5405e";
        src = fetchurl {
          url = "https://api.github.com/repos/egulias/EmailValidator/zipball/ebaaf5be6c0286928352e054f2d5125608e5405e";
          sha256 = "02n4sh0gywqzsl46n9q8hqqgiyva2gj4lxdz9fw4pvhkm1s27wd6";
        };
      };
    };
    "fakerphp/faker" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fakerphp-faker-e3daa170d00fde61ea7719ef47bb09bb8f1d9b01";
        src = fetchurl {
          url = "https://api.github.com/repos/FakerPHP/Faker/zipball/e3daa170d00fde61ea7719ef47bb09bb8f1d9b01";
          sha256 = "1n99cfc737xcyvip3k9j1f5iy91bh1m64xg404xa7gvzlgpdnm7n";
        };
      };
    };
    "felixfbecker/advanced-json-rpc" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "felixfbecker-advanced-json-rpc-b5f37dbff9a8ad360ca341f3240dc1c168b45447";
        src = fetchurl {
          url = "https://api.github.com/repos/felixfbecker/php-advanced-json-rpc/zipball/b5f37dbff9a8ad360ca341f3240dc1c168b45447";
          sha256 = "1414k12bznhi6zbb41sm7m2wjnpabvi1xybh0v6rxf8khj15rccq";
        };
      };
    };
    "felixfbecker/language-server-protocol" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "felixfbecker-language-server-protocol-6e82196ffd7c62f7794d778ca52b69feec9f2842";
        src = fetchurl {
          url = "https://api.github.com/repos/felixfbecker/php-language-server-protocol/zipball/6e82196ffd7c62f7794d778ca52b69feec9f2842";
          sha256 = "0gildnl5ciiq3sv23l2j6zrcf3glab56vvr4sxlwsd6pqzz2yl37";
        };
      };
    };
    "fidry/cpu-core-counter" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fidry-cpu-core-counter-b58e5a3933e541dc286cc91fc4f3898bbc6f1623";
        src = fetchurl {
          url = "https://api.github.com/repos/theofidry/cpu-core-counter/zipball/b58e5a3933e541dc286cc91fc4f3898bbc6f1623";
          sha256 = "154qkm931w5d3dy202w455wxfa0wsjx7mmfj23mb36zpp1gck19j";
        };
      };
    };
    "fruitcake/php-cors" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fruitcake-php-cors-3d158f36e7875e2f040f37bc0573956240a5a38b";
        src = fetchurl {
          url = "https://api.github.com/repos/fruitcake/php-cors/zipball/3d158f36e7875e2f040f37bc0573956240a5a38b";
          sha256 = "1pdq0dxrmh4yj48y9azrld10qmz1w3vbb9q81r85fvgl62l2kiww";
        };
      };
    };
    "graham-campbell/result-type" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "graham-campbell-result-type-672eff8cf1d6fe1ef09ca0f89c4b287d6a3eb831";
        src = fetchurl {
          url = "https://api.github.com/repos/GrahamCampbell/Result-Type/zipball/672eff8cf1d6fe1ef09ca0f89c4b287d6a3eb831";
          sha256 = "156zbfs19r9g543phlpjwhqin3k2x4dsvr5p0wk7rk4j0wwp8l2v";
        };
      };
    };
    "guzzlehttp/psr7" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-psr7-be45764272e8873c72dbe3d2edcfdfcc3bc9f727";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/psr7/zipball/be45764272e8873c72dbe3d2edcfdfcc3bc9f727";
          sha256 = "1x61sn6srz979p0y6cvbzl3m4dvskgqs68zrhmqpymjdj7b45acn";
        };
      };
    };
    "guzzlehttp/uri-template" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-uri-template-61bf437fc2197f587f6857d3ff903a24f1731b5d";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/uri-template/zipball/61bf437fc2197f587f6857d3ff903a24f1731b5d";
          sha256 = "1i6k0bk30vz4aqsgbj2k4r6kwhmp26qqdqzic58ggdhc7nbyq56d";
        };
      };
    };
    "hamcrest/hamcrest-php" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "hamcrest-hamcrest-php-8c3d0a3f6af734494ad8f6fbbee0ba92422859f3";
        src = fetchurl {
          url = "https://api.github.com/repos/hamcrest/hamcrest-php/zipball/8c3d0a3f6af734494ad8f6fbbee0ba92422859f3";
          sha256 = "1ixmmpplaf1z36f34d9f1342qjbcizvi5ddkjdli6jgrbla6a6hr";
        };
      };
    };
    "laravel/framework" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-framework-09137f50f715c1efc649788a26092dcb1ec4ab6e";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/framework/zipball/09137f50f715c1efc649788a26092dcb1ec4ab6e";
          sha256 = "1p7g9dxrprf0gxqs6i1cd51qixpfxpplznb18kjbfcqmb1xldsii";
        };
      };
    };
    "laravel/prompts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-prompts-cce65a90e64712909ea1adc033e1d88de8455ffd";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/prompts/zipball/cce65a90e64712909ea1adc033e1d88de8455ffd";
          sha256 = "0zxiwn40bxayslm1h3q1f5z2m3jnb52qjlnw62n2f6703vlh3wqg";
        };
      };
    };
    "laravel/serializable-closure" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-serializable-closure-e5a3057a5591e1cfe8183034b0203921abe2c902";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/serializable-closure/zipball/e5a3057a5591e1cfe8183034b0203921abe2c902";
          sha256 = "0sjcn7w31x14slfj2mqs32kj62ay86i47i441p5cg3ajw9kjb6iy";
        };
      };
    };
    "laravel/tinker" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-tinker-b936d415b252b499e8c3b1f795cd4fc20f57e1f3";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/tinker/zipball/b936d415b252b499e8c3b1f795cd4fc20f57e1f3";
          sha256 = "1vggdik2nby6a9avwgylgihhwyglm0mdwm703bwv7ilwx0dsx1i7";
        };
      };
    };
    "league/commonmark" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-commonmark-3669d6d5f7a47a93c08ddff335e6d945481a1dd5";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/commonmark/zipball/3669d6d5f7a47a93c08ddff335e6d945481a1dd5";
          sha256 = "1rbaydy1n1c1schskbabzd4nx57nvwpnzqapsfxjm6kyihca1nr3";
        };
      };
    };
    "league/config" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-config-754b3604fb2984c71f4af4a9cbe7b57f346ec1f3";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/config/zipball/754b3604fb2984c71f4af4a9cbe7b57f346ec1f3";
          sha256 = "0yjb85cd0qa0mra995863dij2hmcwk9x124vs8lrwiylb0l3mn8s";
        };
      };
    };
    "league/flysystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-flysystem-bd4c9b26849d82364119c68429541f1631fba94b";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/flysystem/zipball/bd4c9b26849d82364119c68429541f1631fba94b";
          sha256 = "0qlrxrs748m9sbijyjrknbqzd5r00rl7gvyq43cjs2calsx0yjjg";
        };
      };
    };
    "league/flysystem-local" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-flysystem-local-ec7383f25642e6fd4bb0c9554fc2311245391781";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/flysystem-local/zipball/ec7383f25642e6fd4bb0c9554fc2311245391781";
          sha256 = "1im8df7ysrlfqrjm1bl9rky9jrk1gv1z4xs5brcqnyhdxkwd9jp4";
        };
      };
    };
    "league/mime-type-detection" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-mime-type-detection-b6a5854368533df0295c5761a0253656a2e52d9e";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/mime-type-detection/zipball/b6a5854368533df0295c5761a0253656a2e52d9e";
          sha256 = "0bsqha9c0pyb5l78iiv1klrpqmhki6nh9x73pgnmh7sphh6ilygj";
        };
      };
    };
    "mockery/mockery" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "mockery-mockery-b8e0bb7d8c604046539c1115994632c74dcb361e";
        src = fetchurl {
          url = "https://api.github.com/repos/mockery/mockery/zipball/b8e0bb7d8c604046539c1115994632c74dcb361e";
          sha256 = "1fbz87008ffn35k7wgwsx3g5pdrjsc9pygza71as9bmbkxkryjlr";
        };
      };
    };
    "monolog/monolog" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "monolog-monolog-e2392369686d420ca32df3803de28b5d6f76867d";
        src = fetchurl {
          url = "https://api.github.com/repos/Seldaek/monolog/zipball/e2392369686d420ca32df3803de28b5d6f76867d";
          sha256 = "1cs9gx2qgggzzzn41858h2l2v7rrlnysxjxflmdm5ajyxw50sy2n";
        };
      };
    };
    "myclabs/deep-copy" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "myclabs-deep-copy-7284c22080590fb39f2ffa3e9057f10a4ddd0e0c";
        src = fetchurl {
          url = "https://api.github.com/repos/myclabs/DeepCopy/zipball/7284c22080590fb39f2ffa3e9057f10a4ddd0e0c";
          sha256 = "16k44y94bcr439bsxm5158xvmlyraph2c6n17qa5y29b04jqdw5j";
        };
      };
    };
    "nesbot/carbon" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nesbot-carbon-98276233188583f2ff845a0f992a235472d9466a";
        src = fetchurl {
          url = "https://api.github.com/repos/briannesbitt/Carbon/zipball/98276233188583f2ff845a0f992a235472d9466a";
          sha256 = "0vxm2fafg5h3m25hrivm6blc7ibna6icliyx98rv550d75m57zd6";
        };
      };
    };
    "netresearch/jsonmapper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "netresearch-jsonmapper-f60565f8c0566a31acf06884cdaa591867ecc956";
        src = fetchurl {
          url = "https://api.github.com/repos/cweiske/jsonmapper/zipball/f60565f8c0566a31acf06884cdaa591867ecc956";
          sha256 = "1hbn95pcfb63b6z17lgwz16li34cdad92zj4py6vjzdbz14m0xq5";
        };
      };
    };
    "nette/schema" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nette-schema-0462f0166e823aad657c9224d0f849ecac1ba10a";
        src = fetchurl {
          url = "https://api.github.com/repos/nette/schema/zipball/0462f0166e823aad657c9224d0f849ecac1ba10a";
          sha256 = "0x2pz3mjnx78ndxm5532ld3kwzs9p43l4snk4vjbwnqiqgcpqwn7";
        };
      };
    };
    "nette/utils" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nette-utils-cead6637226456b35e1175cc53797dd585d85545";
        src = fetchurl {
          url = "https://api.github.com/repos/nette/utils/zipball/cead6637226456b35e1175cc53797dd585d85545";
          sha256 = "19q4ikaqxkhgbcc8pl2k8n6wpd10132dkxcl2k3lsxaylbvdh1k4";
        };
      };
    };
    "nikic/php-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nikic-php-parser-a6303e50c90c355c7eeee2c4a8b27fe8dc8fef1d";
        src = fetchurl {
          url = "https://api.github.com/repos/nikic/PHP-Parser/zipball/a6303e50c90c355c7eeee2c4a8b27fe8dc8fef1d";
          sha256 = "0a5a6fzgvcgxn5kc1mxa5grxmm8c1ax91pjr3gxpkji7nyc1zh1y";
        };
      };
    };
    "nunomaduro/termwind" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nunomaduro-termwind-8ab0b32c8caa4a2e09700ea32925441385e4a5dc";
        src = fetchurl {
          url = "https://api.github.com/repos/nunomaduro/termwind/zipball/8ab0b32c8caa4a2e09700ea32925441385e4a5dc";
          sha256 = "1g75vpq7014s5yd6bvj78b88ia31slkikdhjv8iprz987qm5dnl7";
        };
      };
    };
    "orchestra/canvas" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "orchestra-canvas-246833ff19f74db0b76d651eb4f36aa92d1af7d3";
        src = fetchurl {
          url = "https://api.github.com/repos/orchestral/canvas/zipball/246833ff19f74db0b76d651eb4f36aa92d1af7d3";
          sha256 = "0flm3m4jmffq1ngj8gsfckz7d2c1hypz8dx6ghw0fxqhq67pssp1";
        };
      };
    };
    "orchestra/canvas-core" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "orchestra-canvas-core-642a966b1f8a351a994c04ce1e03a5ddd1025ff5";
        src = fetchurl {
          url = "https://api.github.com/repos/orchestral/canvas-core/zipball/642a966b1f8a351a994c04ce1e03a5ddd1025ff5";
          sha256 = "0mrxridwfal4hnwc125cxq3m9b9ly9vyidxsbacjk9g4vwx9gh62";
        };
      };
    };
    "orchestra/testbench" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "orchestra-testbench-b793195fa30517a89fd20b36b5d668324c5bbdbb";
        src = fetchurl {
          url = "https://api.github.com/repos/orchestral/testbench/zipball/b793195fa30517a89fd20b36b5d668324c5bbdbb";
          sha256 = "0pwmywfysxdbchqx2z5ckw3xxrpmjh4dqfaimm03yl0d1bixwmzi";
        };
      };
    };
    "orchestra/testbench-core" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "orchestra-testbench-core-b03aa317d3c660dd63e4096580d7f713bc2cab15";
        src = fetchurl {
          url = "https://api.github.com/repos/orchestral/testbench-core/zipball/b03aa317d3c660dd63e4096580d7f713bc2cab15";
          sha256 = "1shv5wynga6nkag6b4y4l3dkss3830l8b41ic1hrjjryisdkh2di";
        };
      };
    };
    "orchestra/workbench" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "orchestra-workbench-52d5f5d6bf738539691a8335ff5cb892f5798b9f";
        src = fetchurl {
          url = "https://api.github.com/repos/orchestral/workbench/zipball/52d5f5d6bf738539691a8335ff5cb892f5798b9f";
          sha256 = "1gvlcvi3v3z1bg4r1973l9ys1wcglavgjbj6bv5himdlqdfxsjfl";
        };
      };
    };
    "phar-io/manifest" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phar-io-manifest-97803eca37d319dfa7826cc2437fc020857acb53";
        src = fetchurl {
          url = "https://api.github.com/repos/phar-io/manifest/zipball/97803eca37d319dfa7826cc2437fc020857acb53";
          sha256 = "107dsj04ckswywc84dvw42kdrqd4y6yvb2qwacigyrn05p075c1w";
        };
      };
    };
    "phar-io/version" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phar-io-version-4f7fd7836c6f332bb2933569e566a0d6c4cbed74";
        src = fetchurl {
          url = "https://api.github.com/repos/phar-io/version/zipball/4f7fd7836c6f332bb2933569e566a0d6c4cbed74";
          sha256 = "0mdbzh1y0m2vvpf54vw7ckcbcf1yfhivwxgc9j9rbb7yifmlyvsg";
        };
      };
    };
    "phpdocumentor/reflection-common" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-reflection-common-1d01c49d4ed62f25aa84a747ad35d5a16924662b";
        src = fetchurl {
          url = "https://api.github.com/repos/phpDocumentor/ReflectionCommon/zipball/1d01c49d4ed62f25aa84a747ad35d5a16924662b";
          sha256 = "1wx720a17i24471jf8z499dnkijzb4b8xra11kvw9g9hhzfadz1r";
        };
      };
    };
    "phpdocumentor/reflection-docblock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-reflection-docblock-622548b623e81ca6d78b721c5e029f4ce664f170";
        src = fetchurl {
          url = "https://api.github.com/repos/phpDocumentor/ReflectionDocBlock/zipball/622548b623e81ca6d78b721c5e029f4ce664f170";
          sha256 = "1vs0fhpqk8s9bc0sqyfhpbs63q14lfjg1f0c1dw4jz97145j6r1n";
        };
      };
    };
    "phpdocumentor/type-resolver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpdocumentor-type-resolver-3219c6ee25c9ea71e3d9bbaf39c67c9ebd499419";
        src = fetchurl {
          url = "https://api.github.com/repos/phpDocumentor/TypeResolver/zipball/3219c6ee25c9ea71e3d9bbaf39c67c9ebd499419";
          sha256 = "1wnd2hfbkzi5qmgh94m7jgl7xr5q5y8aix9c0ka6v4jc3sq8icby";
        };
      };
    };
    "phpoption/phpoption" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpoption-phpoption-dd3a383e599f49777d8b628dadbb90cae435b87e";
        src = fetchurl {
          url = "https://api.github.com/repos/schmittjoh/php-option/zipball/dd3a383e599f49777d8b628dadbb90cae435b87e";
          sha256 = "029gpfa66hwg395jvf7swcvrj085wsw5fw6041nrl5kbc36fvwlb";
        };
      };
    };
    "phpstan/phpdoc-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpstan-phpdoc-parser-bcad8d995980440892759db0c32acae7c8e79442";
        src = fetchurl {
          url = "https://api.github.com/repos/phpstan/phpdoc-parser/zipball/bcad8d995980440892759db0c32acae7c8e79442";
          sha256 = "16c95x9qv8n0vdmnxas18ah8fwjnlacvh4g5694whxdsfgjsk7gz";
        };
      };
    };
    "phpunit/php-code-coverage" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-code-coverage-355324ca4980b8916c18b9db29f3ef484078f26e";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/php-code-coverage/zipball/355324ca4980b8916c18b9db29f3ef484078f26e";
          sha256 = "0p85lwcsv9bq8k0dygzpyfs32bfmhlck22nm7jdpvly7ha3y2l92";
        };
      };
    };
    "phpunit/php-file-iterator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-file-iterator-a95037b6d9e608ba092da1b23931e537cadc3c3c";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/php-file-iterator/zipball/a95037b6d9e608ba092da1b23931e537cadc3c3c";
          sha256 = "1cxdrmvffx6zicjq41hs93jzwzr536vpk9b9vx6cpbyz08v3bbgj";
        };
      };
    };
    "phpunit/php-invoker" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-invoker-f5e568ba02fa5ba0ddd0f618391d5a9ea50b06d7";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/php-invoker/zipball/f5e568ba02fa5ba0ddd0f618391d5a9ea50b06d7";
          sha256 = "16hdigfcwzynbnrs29ha7l1pjr81rf2510jx3z3nhmgz9fys7jsl";
        };
      };
    };
    "phpunit/php-text-template" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-text-template-0c7b06ff49e3d5072f057eb1fa59258bf287a748";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/php-text-template/zipball/0c7b06ff49e3d5072f057eb1fa59258bf287a748";
          sha256 = "083gkd6rp4zdyh1y8cmplrpfcfa0brn4vmgbcillgsjxxs25pkcs";
        };
      };
    };
    "phpunit/php-timer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-php-timer-e2a2d67966e740530f4a3343fe2e030ffdc1161d";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/php-timer/zipball/e2a2d67966e740530f4a3343fe2e030ffdc1161d";
          sha256 = "02skpc6b31lgqnjxsh8x3b4mvr6pz8zp5672dllgfknf70byzy1f";
        };
      };
    };
    "phpunit/phpunit" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpunit-phpunit-62bd7af13d282deeb95650077d28ba3600ca321c";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/phpunit/zipball/62bd7af13d282deeb95650077d28ba3600ca321c";
          sha256 = "02l63x7dv8683wz2cjiiv42cp8lwvzflib45jlsc7f2cvanjfmrg";
        };
      };
    };
    "pimple/pimple" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "pimple-pimple-a94b3a4db7fb774b3d78dad2315ddc07629e1bed";
        src = fetchurl {
          url = "https://api.github.com/repos/silexphp/Pimple/zipball/a94b3a4db7fb774b3d78dad2315ddc07629e1bed";
          sha256 = "1wdq0cyqgys55vvjphh58lxgspzap1f3bs0r1k4vgphvf1m6m8pl";
        };
      };
    };
    "psalm/plugin-laravel" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psalm-plugin-laravel-0b42a51f977d216e0b5d649f68346e2f324f4a55";
        src = fetchurl {
          url = "https://api.github.com/repos/psalm/psalm-plugin-laravel/zipball/0b42a51f977d216e0b5d649f68346e2f324f4a55";
          sha256 = "10nwsgk97095qh6a3wbhaibhwjgn8ckw35yf64y7xmx0xmagz37m";
        };
      };
    };
    "psr/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-cache-aa5030cfa5405eccfdcb1083ce040c2cb8d253bf";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/cache/zipball/aa5030cfa5405eccfdcb1083ce040c2cb8d253bf";
          sha256 = "07rnyjwb445sfj30v5ny3gfsgc1m7j7cyvwjgs2cm9slns1k1ml8";
        };
      };
    };
    "psr/clock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-clock-e41a24703d4560fd0acb709162f73b8adfc3aa0d";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/clock/zipball/e41a24703d4560fd0acb709162f73b8adfc3aa0d";
          sha256 = "0wz5b8hgkxn3jg88cb3901hj71axsj0fil6pwl413igghch6i8kj";
        };
      };
    };
    "psr/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-container-c71ecc56dfe541dbd90c5360474fbc405f8d5963";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/container/zipball/c71ecc56dfe541dbd90c5360474fbc405f8d5963";
          sha256 = "1mvan38yb65hwk68hl0p7jymwzr4zfnaxmwjbw7nj3rsknvga49i";
        };
      };
    };
    "psr/event-dispatcher" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-event-dispatcher-dbefd12671e8a14ec7f180cab83036ed26714bb0";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/event-dispatcher/zipball/dbefd12671e8a14ec7f180cab83036ed26714bb0";
          sha256 = "05nicsd9lwl467bsv4sn44fjnnvqvzj1xqw2mmz9bac9zm66fsjd";
        };
      };
    };
    "psr/http-factory" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-factory-e616d01114759c4c489f93b099585439f795fe35";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/http-factory/zipball/e616d01114759c4c489f93b099585439f795fe35";
          sha256 = "1vzimn3h01lfz0jx0lh3cy9whr3kdh103m1fw07qric4pnnz5kx8";
        };
      };
    };
    "psr/http-message" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-message-402d35bcb92c70c026d1a6a9883f06b2ead23d71";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/http-message/zipball/402d35bcb92c70c026d1a6a9883f06b2ead23d71";
          sha256 = "13cnlzrh344n00sgkrp5cgbkr8dznd99c3jfnpl0wg1fdv1x4qfm";
        };
      };
    };
    "psr/log" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-log-fe5ea303b0887d5caefd3d431c3e61ad47037001";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/log/zipball/fe5ea303b0887d5caefd3d431c3e61ad47037001";
          sha256 = "0a0rwg38vdkmal3nwsgx58z06qkfl85w2yvhbgwg45anr0b3bhmv";
        };
      };
    };
    "psr/simple-cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-simple-cache-764e0b3939f5ca87cb904f570ef9be2d78a07865";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/simple-cache/zipball/764e0b3939f5ca87cb904f570ef9be2d78a07865";
          sha256 = "0hgcanvd9gqwkaaaq41lh8fsfdraxmp2n611lvqv69jwm1iy76g8";
        };
      };
    };
    "psy/psysh" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psy-psysh-128fa1b608be651999ed9789c95e6e2a31b5802b";
        src = fetchurl {
          url = "https://api.github.com/repos/bobthecow/psysh/zipball/128fa1b608be651999ed9789c95e6e2a31b5802b";
          sha256 = "0lrmqw53kzgdldxiy2aj0dawdzz5cbsxqz9p47ca3c0ggnszlk1p";
        };
      };
    };
    "ralouphie/getallheaders" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ralouphie-getallheaders-120b605dfeb996808c31b6477290a714d356e822";
        src = fetchurl {
          url = "https://api.github.com/repos/ralouphie/getallheaders/zipball/120b605dfeb996808c31b6477290a714d356e822";
          sha256 = "1bv7ndkkankrqlr2b4kw7qp3fl0dxi6bp26bnim6dnlhavd6a0gg";
        };
      };
    };
    "ramsey/collection" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ramsey-collection-a4b48764bfbb8f3a6a4d1aeb1a35bb5e9ecac4a5";
        src = fetchurl {
          url = "https://api.github.com/repos/ramsey/collection/zipball/a4b48764bfbb8f3a6a4d1aeb1a35bb5e9ecac4a5";
          sha256 = "0y5s9rbs023sw94yzvxr8fn9rr7xw03f08zmc9n9jl49zlr5s52p";
        };
      };
    };
    "ramsey/uuid" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ramsey-uuid-60a4c63ab724854332900504274f6150ff26d286";
        src = fetchurl {
          url = "https://api.github.com/repos/ramsey/uuid/zipball/60a4c63ab724854332900504274f6150ff26d286";
          sha256 = "1w1i50pbd18awmvzqjkbszw79dl09912ibn95qm8lxr4nsjvbb27";
        };
      };
    };
    "sebastian/cli-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-cli-parser-efdc130dbbbb8ef0b545a994fd811725c5282cae";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/cli-parser/zipball/efdc130dbbbb8ef0b545a994fd811725c5282cae";
          sha256 = "0q850iss5gm7dw9kqdvgfibsf0b54nsnmdbxd4hwvpsakvac4il2";
        };
      };
    };
    "sebastian/code-unit" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-code-unit-a81fee9eef0b7a76af11d121767abc44c104e503";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/code-unit/zipball/a81fee9eef0b7a76af11d121767abc44c104e503";
          sha256 = "0k480x92974k4w2nvaf19xz3brwmjvh84h4wya4xp8vn5a6p3gfg";
        };
      };
    };
    "sebastian/code-unit-reverse-lookup" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-code-unit-reverse-lookup-5e3a687f7d8ae33fb362c5c0743794bbb2420a1d";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/code-unit-reverse-lookup/zipball/5e3a687f7d8ae33fb362c5c0743794bbb2420a1d";
          sha256 = "03x25cyiivl8mf4bgk22c2ivdkh3q7sh59nhivjag2rpnylsj8gb";
        };
      };
    };
    "sebastian/comparator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-comparator-2db5010a484d53ebf536087a70b4a5423c102372";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/comparator/zipball/2db5010a484d53ebf536087a70b4a5423c102372";
          sha256 = "1isk6l8gxk2pk9vxzblw429pny6c6jpyik81svm289lbscy151kc";
        };
      };
    };
    "sebastian/complexity" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-complexity-68cfb347a44871f01e33ab0ef8215966432f6957";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/complexity/zipball/68cfb347a44871f01e33ab0ef8215966432f6957";
          sha256 = "18wbzi6nbbxbisjzygk3gc6dn3jy426hz8v2n5y889jb17jcagjp";
        };
      };
    };
    "sebastian/diff" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-diff-912dc2fbe3e3c1e7873313cc801b100b6c68c87b";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/diff/zipball/912dc2fbe3e3c1e7873313cc801b100b6c68c87b";
          sha256 = "0qxy3209c767pir449nm2b1bl5qzc8lxkfdv4fdgf5c40055fh23";
        };
      };
    };
    "sebastian/environment" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-environment-43c751b41d74f96cbbd4e07b7aec9675651e2951";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/environment/zipball/43c751b41d74f96cbbd4e07b7aec9675651e2951";
          sha256 = "1x65y0kax9vk6gygyhzzgk9smvj09l959b240n5fvn3jlb4s4hlh";
        };
      };
    };
    "sebastian/exporter" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-exporter-64f51654862e0f5e318db7e9dcc2292c63cdbddc";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/exporter/zipball/64f51654862e0f5e318db7e9dcc2292c63cdbddc";
          sha256 = "1pg429bkl8v1m7n4pqv759367kdln1r5iy5bd6b92mfkhnmvby12";
        };
      };
    };
    "sebastian/global-state" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-global-state-7ea9ead78f6d380d2a667864c132c2f7b83055e4";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/global-state/zipball/7ea9ead78f6d380d2a667864c132c2f7b83055e4";
          sha256 = "1hcdh12z1ivmlsrq3vmbkys6s1irknx10z22gf5856605yd8a3jp";
        };
      };
    };
    "sebastian/lines-of-code" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-lines-of-code-649e40d279e243d985aa8fb6e74dd5bb28dc185d";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/lines-of-code/zipball/649e40d279e243d985aa8fb6e74dd5bb28dc185d";
          sha256 = "1i46nh3c95qd0vviv96pijm2pvd51kfnrhk1n05ggybzfn5qiwih";
        };
      };
    };
    "sebastian/object-enumerator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-object-enumerator-202d0e344a580d7f7d04b3fafce6933e59dae906";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/object-enumerator/zipball/202d0e344a580d7f7d04b3fafce6933e59dae906";
          sha256 = "1gqlp8dkjgm9zsbklk7rwc3d9nf3mqws6l445vls2q2h6a9j37w1";
        };
      };
    };
    "sebastian/object-reflector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-object-reflector-24ed13d98130f0e7122df55d06c5c4942a577957";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/object-reflector/zipball/24ed13d98130f0e7122df55d06c5c4942a577957";
          sha256 = "0imfh72b7yjgjnyfh2zrjsfqznz0c6hcsvmp4igmn4cb3w3vpbpv";
        };
      };
    };
    "sebastian/recursion-context" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-recursion-context-05909fb5bc7df4c52992396d0116aed689f93712";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/recursion-context/zipball/05909fb5bc7df4c52992396d0116aed689f93712";
          sha256 = "1dr3wsyx3s5kanlg4s9qgn35wbjjrmhycp31n3azqskalp4whzy5";
        };
      };
    };
    "sebastian/type" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-type-462699a16464c3944eefc02ebdd77882bd3925bf";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/type/zipball/462699a16464c3944eefc02ebdd77882bd3925bf";
          sha256 = "0g2im923glz133bbkz3r12i2n1zpk7d7198znzcms6cs99v6b6mc";
        };
      };
    };
    "sebastian/version" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "sebastian-version-c51fa83a5d8f43f1402e3f32a005e6262244ef17";
        src = fetchurl {
          url = "https://api.github.com/repos/sebastianbergmann/version/zipball/c51fa83a5d8f43f1402e3f32a005e6262244ef17";
          sha256 = "14cirib9q5r4nn5cvyv3hba07qvpw4dwdnsiz67c3rf4ghjwgfym";
        };
      };
    };
    "spatie/array-to-xml" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-array-to-xml-f9ab39c808500c347d5a8b6b13310bd5221e39e7";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/array-to-xml/zipball/f9ab39c808500c347d5a8b6b13310bd5221e39e7";
          sha256 = "0jz25kf4jlhp834fdg5fkzg7g2xnhpkl1pdvsbl4s9c6waai8gd6";
        };
      };
    };
    "spatie/backtrace" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-backtrace-483f76a82964a0431aa836b6ed0edde0c248e3ab";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/backtrace/zipball/483f76a82964a0431aa836b6ed0edde0c248e3ab";
          sha256 = "1mb7fk0phc065iz0b1s6zf0lbn5nz6r2x0g6z650rwdkc015vh9n";
        };
      };
    };
    "spatie/laravel-ray" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-laravel-ray-5028ae44a09451b26eb44490e3471998650788e3";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/laravel-ray/zipball/5028ae44a09451b26eb44490e3471998650788e3";
          sha256 = "0wvqkmqaig214vv988ypajgrjinra24nnz91wc2nqgibya4k82k4";
        };
      };
    };
    "spatie/macroable" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-macroable-ec2c320f932e730607aff8052c44183cf3ecb072";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/macroable/zipball/ec2c320f932e730607aff8052c44183cf3ecb072";
          sha256 = "1b18vinvckqi4j9rsxz44672rfvj3i8dfbbz0wdyq0br4zj4lj29";
        };
      };
    };
    "spatie/ray" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-ray-7ab6bd01dc6a8ecdd836b3182d40a04308ae0c75";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/ray/zipball/7ab6bd01dc6a8ecdd836b3182d40a04308ae0c75";
          sha256 = "1i651j7r97gbw2mf2xqdwp3blxax4ri3jrnqlj10zwbg7impi8sf";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-eca495f2ee845130855ddf1cf18460c38966c8b6";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/console/zipball/eca495f2ee845130855ddf1cf18460c38966c8b6";
          sha256 = "1z81pzshwbacrn77b90k0add0b5y6ll9j5nabpcwin41s1gqhy91";
        };
      };
    };
    "symfony/css-selector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-css-selector-883d961421ab1709877c10ac99451632a3d6fa57";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/css-selector/zipball/883d961421ab1709877c10ac99451632a3d6fa57";
          sha256 = "0psdmi7lslpi4jqyk946cxrrzaylil6nnwv7zrwmdqsnchrb8i6b";
        };
      };
    };
    "symfony/deprecation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-deprecation-contracts-7c3aff79d10325257a001fcf92d991f24fc967cf";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/deprecation-contracts/zipball/7c3aff79d10325257a001fcf92d991f24fc967cf";
          sha256 = "0p0c2942wjq1bb06y9i8gw6qqj7sin5v5xwsvl0zdgspbr7jk1m9";
        };
      };
    };
    "symfony/error-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-error-handler-1f69476b64fb47105c06beef757766c376b548c4";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/error-handler/zipball/1f69476b64fb47105c06beef757766c376b548c4";
          sha256 = "0ms6k8syklgq5i3gpa6nskpjvmzwj2kfrld7q6601bsdh34jvld4";
        };
      };
    };
    "symfony/event-dispatcher" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-adb01fe097a4ee930db9258a3cc906b5beb5cf2e";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/event-dispatcher/zipball/adb01fe097a4ee930db9258a3cc906b5beb5cf2e";
          sha256 = "0kgk5h0py9iyp924z3384cxpaf8qdjz8hcz52gqkjqcpmzf9hlag";
        };
      };
    };
    "symfony/event-dispatcher-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-contracts-a76aed96a42d2b521153fb382d418e30d18b59df";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/event-dispatcher-contracts/zipball/a76aed96a42d2b521153fb382d418e30d18b59df";
          sha256 = "1w49s1q6xhcmkgd3xkyjggiwys0wvyny0p3018anvdi0k86zg678";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-edd36776956f2a6fcf577edb5b05eb0e3bdc52ae";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/filesystem/zipball/edd36776956f2a6fcf577edb5b05eb0e3bdc52ae";
          sha256 = "1idya1y7m51bgk7h3c4s9v02lq2zf35krpy08ypn103x29ghhypa";
        };
      };
    };
    "symfony/finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-finder-a1b31d88c0e998168ca7792f222cbecee47428c4";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/finder/zipball/a1b31d88c0e998168ca7792f222cbecee47428c4";
          sha256 = "19g1qkchm9vj86f5z4gm9h7w105h01xmwcwka5n8mpns5jxzak5r";
        };
      };
    };
    "symfony/http-foundation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-http-foundation-b50f5e281d722cb0f4c296f908bacc3e2b721957";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/http-foundation/zipball/b50f5e281d722cb0f4c296f908bacc3e2b721957";
          sha256 = "18ad3wnyh7wgp6gxr0zq7vl8wa1sh555xwizaj3kpsnihia34ji4";
        };
      };
    };
    "symfony/http-kernel" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-http-kernel-9f991a964368bee8d883e8d57ced4fe9fff04dfc";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/http-kernel/zipball/9f991a964368bee8d883e8d57ced4fe9fff04dfc";
          sha256 = "0bj5fl7rbp9f4inb718kn8rv66h5c7937fmqwjazdv3n03vzzznl";
        };
      };
    };
    "symfony/mailer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-mailer-d89611a7830d51b5e118bca38e390dea92f9ea06";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/mailer/zipball/d89611a7830d51b5e118bca38e390dea92f9ea06";
          sha256 = "086chgpg81zwrsiysp1hvf6y4dd9ypxs96xzimnx0kygxa73z3pi";
        };
      };
    };
    "symfony/mime" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-mime-d5179eedf1cb2946dbd760475ebf05c251ef6a6e";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/mime/zipball/d5179eedf1cb2946dbd760475ebf05c251ef6a6e";
          sha256 = "17mqf0m1dq193b57cd3ml9b3f4wf6zcrzkr6viydcyy953n6vpsl";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-ea208ce43cbb04af6867b4fdddb1bdbf84cc28cb";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-ctype/zipball/ea208ce43cbb04af6867b4fdddb1bdbf84cc28cb";
          sha256 = "0ynkrpl3hb448dhab1injwwzfx68l75yn9zgc7lgqwbx60dvhqm3";
        };
      };
    };
    "symfony/polyfill-iconv" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-iconv-6de50471469b8c9afc38164452ab2b6170ee71c1";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-iconv/zipball/6de50471469b8c9afc38164452ab2b6170ee71c1";
          sha256 = "0pp37jw61c8js9qr5rdp9x2cjq93bl737xc4cg97p0fhzl9fs951";
        };
      };
    };
    "symfony/polyfill-intl-grapheme" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-grapheme-875e90aeea2777b6f135677f618529449334a612";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-grapheme/zipball/875e90aeea2777b6f135677f618529449334a612";
          sha256 = "19j8qcbp525q7i61c2lhj6z2diysz45q06d990fvjby15cn0id0i";
        };
      };
    };
    "symfony/polyfill-intl-idn" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-idn-ecaafce9f77234a6a449d29e49267ba10499116d";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-idn/zipball/ecaafce9f77234a6a449d29e49267ba10499116d";
          sha256 = "0f42w4975rakhysnmhsyw6n3rjg6rjg7b7x8gs1n0qfdb6wc8m3q";
        };
      };
    };
    "symfony/polyfill-intl-normalizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-normalizer-8c4ad05dd0120b6a53c1ca374dca2ad0a1c4ed92";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/8c4ad05dd0120b6a53c1ca374dca2ad0a1c4ed92";
          sha256 = "0msah2ii2174xh47v5x9vq1b1xn38yyx03sr3pa2rq3a849wi7nh";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-42292d99c55abe617799667f454222c54c60e229";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-mbstring/zipball/42292d99c55abe617799667f454222c54c60e229";
          sha256 = "1m3l12y0lid3i0zy3m1jrk0z3zy8wpa7nij85zk2h5vbf924jnwa";
        };
      };
    };
    "symfony/polyfill-php72" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php72-70f4aebd92afca2f865444d30a4d2151c13c3179";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php72/zipball/70f4aebd92afca2f865444d30a4d2151c13c3179";
          sha256 = "10j5ipx16p6rybkpawqscpr2wcnby4270rbdj1qchr598wkvi0kb";
        };
      };
    };
    "symfony/polyfill-php80" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php80-6caa57379c4aec19c0a12a38b59b26487dcfe4b5";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php80/zipball/6caa57379c4aec19c0a12a38b59b26487dcfe4b5";
          sha256 = "05yfindyip9lbfr5apxkz6m0mlljrc9z6qylpxr6k5nkivlrcn9x";
        };
      };
    };
    "symfony/polyfill-php83" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php83-b0f46ebbeeeda3e9d2faebdfbf4b4eae9b59fa11";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php83/zipball/b0f46ebbeeeda3e9d2faebdfbf4b4eae9b59fa11";
          sha256 = "0z0xk1ghssa5qknp7cm3phdam77q4n46bkiwfpc5jkparkq958yb";
        };
      };
    };
    "symfony/polyfill-uuid" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-uuid-9c44518a5aff8da565c8a55dbe85d2769e6f630e";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-uuid/zipball/9c44518a5aff8da565c8a55dbe85d2769e6f630e";
          sha256 = "0w6mphwcz3n1qz0dc6nld5xqb179dvfcwys6r4nj4gjv5nm2nji0";
        };
      };
    };
    "symfony/process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-process-0b5c29118f2e980d455d2e34a5659f4579847c54";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/process/zipball/0b5c29118f2e980d455d2e34a5659f4579847c54";
          sha256 = "09gy20j7wdwxdazm4ql04vfmyycfhs1r2d7f87ak09cip7iw0433";
        };
      };
    };
    "symfony/routing" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-routing-82616e59acd3e3d9c916bba798326cb7796d7d31";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/routing/zipball/82616e59acd3e3d9c916bba798326cb7796d7d31";
          sha256 = "0d7s1jksfxq6yr039xy2nmi00s4yxvgmxb19npfh35l3c56smacs";
        };
      };
    };
    "symfony/service-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-service-contracts-40da9cc13ec349d9e4966ce18b5fbcd724ab10a4";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/service-contracts/zipball/40da9cc13ec349d9e4966ce18b5fbcd724ab10a4";
          sha256 = "188kncrgx16dg9x0ng47n4ljypblpxxn0bic5z75blihnydl5lb4";
        };
      };
    };
    "symfony/stopwatch" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-stopwatch-fc47f1015ec80927ff64ba9094dfe8b9d48fe9f2";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/stopwatch/zipball/fc47f1015ec80927ff64ba9094dfe8b9d48fe9f2";
          sha256 = "0gnpyw9bc4399ycqlqkdsp8nyg63y26629xbp26vh0xdvkfmgwrl";
        };
      };
    };
    "symfony/string" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-string-13d76d0fb049051ed12a04bef4f9de8715bea339";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/string/zipball/13d76d0fb049051ed12a04bef4f9de8715bea339";
          sha256 = "17p4xr6l0n4avxffgwmk0p0x7dvvs8xrgsq5z3865gb3h6nzqcjc";
        };
      };
    };
    "symfony/translation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-3ed078c54bc98bbe4414e1e9b2d5e85ed5a5c8bd";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation/zipball/3ed078c54bc98bbe4414e1e9b2d5e85ed5a5c8bd";
          sha256 = "1s3xfzbg089m7nhl203wvnrvzi32yic6zvpymaw1g5xrcy0nl7yp";
        };
      };
    };
    "symfony/translation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-contracts-02c24deb352fb0d79db5486c0c79905a85e37e86";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation-contracts/zipball/02c24deb352fb0d79db5486c0c79905a85e37e86";
          sha256 = "1mpn6s7dv8q96pgg6f81gyvgdqrnmjg2g6g3x555s5qprmh4hliw";
        };
      };
    };
    "symfony/uid" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-uid-01b0f20b1351d997711c56f1638f7a8c3061e384";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/uid/zipball/01b0f20b1351d997711c56f1638f7a8c3061e384";
          sha256 = "0gmh5j09i4rfhkrbp47bm8620pfjqsh1yq02rcghblh9gkjqq81s";
        };
      };
    };
    "symfony/var-dumper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-var-dumper-3d9999376be5fea8de47752837a3e1d1c5f69ef5";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/var-dumper/zipball/3d9999376be5fea8de47752837a3e1d1c5f69ef5";
          sha256 = "1j5pvfzdnxqi6qzvvqqnljhwfvcpzvlgg8vl93c9dh1d77z0ahrv";
        };
      };
    };
    "symfony/yaml" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-yaml-e23292e8c07c85b971b44c1c4b87af52133e2add";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/yaml/zipball/e23292e8c07c85b971b44c1c4b87af52133e2add";
          sha256 = "1y8zi05h7gd5nmrrqac213a0h3nr4d51llip66d4hd5mkhfivv53";
        };
      };
    };
    "theseer/tokenizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "theseer-tokenizer-34a41e998c2183e22995f158c581e7b5e755ab9e";
        src = fetchurl {
          url = "https://api.github.com/repos/theseer/tokenizer/zipball/34a41e998c2183e22995f158c581e7b5e755ab9e";
          sha256 = "1za4a017kjb4rw2ydglip4bp5q2y7mfiycj3fvnp145i84jc7n0q";
        };
      };
    };
    "tijsverkoyen/css-to-inline-styles" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "tijsverkoyen-css-to-inline-styles-c42125b83a4fa63b187fdf29f9c93cb7733da30c";
        src = fetchurl {
          url = "https://api.github.com/repos/tijsverkoyen/CssToInlineStyles/zipball/c42125b83a4fa63b187fdf29f9c93cb7733da30c";
          sha256 = "0ckk04hwwz0fdkfr20i7xrhdjcnnw1b0liknbb81qyr1y4b7x3dd";
        };
      };
    };
    "vimeo/psalm" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "vimeo-psalm-5c774aca4746caf3d239d9c8cadb9f882ca29352";
        src = fetchurl {
          url = "https://api.github.com/repos/vimeo/psalm/zipball/5c774aca4746caf3d239d9c8cadb9f882ca29352";
          sha256 = "0jr6q4qd5ay93c6ibddxv70yi2zyhlnw2q7r028z4hqmswq08n9v";
        };
      };
    };
    "vlucas/phpdotenv" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "vlucas-phpdotenv-1a7ea2afc49c3ee6d87061f5a233e3a035d0eae7";
        src = fetchurl {
          url = "https://api.github.com/repos/vlucas/phpdotenv/zipball/1a7ea2afc49c3ee6d87061f5a233e3a035d0eae7";
          sha256 = "13h4xyxhdjn1n7xcxbcdhj20rv5fsaigbsbz61x2i224hj76620a";
        };
      };
    };
    "voku/portable-ascii" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "voku-portable-ascii-b56450eed252f6801410d810c8e1727224ae0743";
        src = fetchurl {
          url = "https://api.github.com/repos/voku/portable-ascii/zipball/b56450eed252f6801410d810c8e1727224ae0743";
          sha256 = "0gwlv1hr6ycrf8ik1pnvlwaac8cpm8sa1nf4d49s8rp4k2y5anyl";
        };
      };
    };
    "webmozart/assert" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-assert-11cb2199493b2f8a3b53e7f19068fc6aac760991";
        src = fetchurl {
          url = "https://api.github.com/repos/webmozarts/assert/zipball/11cb2199493b2f8a3b53e7f19068fc6aac760991";
          sha256 = "18qiza1ynwxpi6731jx1w5qsgw98prld1lgvfk54z92b1nc7psix";
        };
      };
    };
    "zbateson/mail-mime-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "zbateson-mail-mime-parser-20b3e48eb799537683780bc8782fbbe9bc25934a";
        src = fetchurl {
          url = "https://api.github.com/repos/zbateson/mail-mime-parser/zipball/20b3e48eb799537683780bc8782fbbe9bc25934a";
          sha256 = "0c98xvqq30vkzbvpa0ampnxql08m804hhnax18dbrldsx5na8csf";
        };
      };
    };
    "zbateson/mb-wrapper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "zbateson-mb-wrapper-faf35dddfacfc5d4d5f9210143eafd7a7fe74334";
        src = fetchurl {
          url = "https://api.github.com/repos/zbateson/mb-wrapper/zipball/faf35dddfacfc5d4d5f9210143eafd7a7fe74334";
          sha256 = "0k933wxj90mzlskphd12wcn02hnz35kbmyvz25ncc58gr14jf7cl";
        };
      };
    };
    "zbateson/stream-decorators" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "zbateson-stream-decorators-783b034024fda8eafa19675fb2552f8654d3a3e9";
        src = fetchurl {
          url = "https://api.github.com/repos/zbateson/stream-decorators/zipball/783b034024fda8eafa19675fb2552f8654d3a3e9";
          sha256 = "05imxpji6fm0h8spcgd7zcmb8ql7bgxd3pq0rrkdac4492g9ddr8";
        };
      };
    };
  };
  devPackages = {};
in
composerEnv.buildPackage {
  inherit packages devPackages noDev;
  name = "humix-psalm-env";
  src = composerEnv.filterSrc ./.;
  executable = true;
  symlinkDependencies = false;
  meta = {};
}
