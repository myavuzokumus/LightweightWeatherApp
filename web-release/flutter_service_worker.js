'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "05ee7e38a82a118139f4ab8ae5865ee8",
"assets/AssetManifest.json": "89f2c115dec918bbb2f55f86d41b1467",
"assets/assets/app_icon/launch_icon.png": "54a5cc455c3602b5dd84217004e4649d",
"assets/assets/icons/lottie/alert-avalanche-danger.json": "a8a929d313fdc7c3df491ab4f0d87f07",
"assets/assets/icons/lottie/alert-falling-rocks.json": "3d818cfe714148809d2cbde6bb96b222",
"assets/assets/icons/lottie/barometer.json": "4048c4e790cfe40aa2aef4c2d9e3c992",
"assets/assets/icons/lottie/beanie.json": "a920405c9a6490a86586445e44e4f37f",
"assets/assets/icons/lottie/celsius.json": "39e642a0b07a1607b7dbc4dfc9806b87",
"assets/assets/icons/lottie/clear-day.json": "390fd590333d979854dd0da8cadd7f74",
"assets/assets/icons/lottie/clear-night.json": "ae1ca38b0c1b22ada3918cc9f8b5b38f",
"assets/assets/icons/lottie/cloud-down.json": "6cfa07837c2e868202ee5898bfd8592a",
"assets/assets/icons/lottie/cloud-up.json": "e0bc7a92e7af3bd5383af839eddae1a9",
"assets/assets/icons/lottie/cloudy.json": "f9bcc0ad6f39d0c323f82cea17d3702f",
"assets/assets/icons/lottie/code-green.json": "1a82b5d367386a87fbaa635c66704808",
"assets/assets/icons/lottie/code-orange.json": "22b154e678fb4f42e0c74774fbbdc9d6",
"assets/assets/icons/lottie/code-red.json": "5b2946a77574cf8740892a7adde9df29",
"assets/assets/icons/lottie/code-yellow.json": "ee2212cfc0b17e78ce4a689fc5b257af",
"assets/assets/icons/lottie/compass.json": "d172859075d9b848b6de1d77ae7f7278",
"assets/assets/icons/lottie/drizzle.json": "2f89a1dc6d310fbd7932401dd283da82",
"assets/assets/icons/lottie/dust-day.json": "10d1f75603beafd9089ac6fd3504d609",
"assets/assets/icons/lottie/dust-night.json": "dac57b3bc648f73462939caa52b22c08",
"assets/assets/icons/lottie/dust-wind.json": "ad27bd28e82441dd89b0f5d9f76e8ceb",
"assets/assets/icons/lottie/dust.json": "23ea9400dad32a6f9a5d342b76ec9ef3",
"assets/assets/icons/lottie/extreme-day-drizzle.json": "101ad69bd36b72a30d5153a26247fa74",
"assets/assets/icons/lottie/extreme-day-fog.json": "646da6f0d15b1cc2a8ef0c3fc215d651",
"assets/assets/icons/lottie/extreme-day-hail.json": "8240174045ddd29edd2d7c3080f46928",
"assets/assets/icons/lottie/extreme-day-haze.json": "04538f40881ad58925730739df6ad0ce",
"assets/assets/icons/lottie/extreme-day-rain.json": "33f0c8f92c7f0773f3730b924d3be67e",
"assets/assets/icons/lottie/extreme-day-sleet.json": "76419b1a4dbd5737256858df28fb861b",
"assets/assets/icons/lottie/extreme-day-smoke.json": "eecf236479e2cdd40c9b50c8ab421c9c",
"assets/assets/icons/lottie/extreme-day-snow.json": "1fc4024bf6a076ccbf83ee3d286dfcec",
"assets/assets/icons/lottie/extreme-day.json": "8ea1d08a2d6d57b7ae142ea049159cfe",
"assets/assets/icons/lottie/extreme-drizzle.json": "4e8a3075c39e5518e7bc87a665bafcb3",
"assets/assets/icons/lottie/extreme-fog.json": "405d86ec4e8eac8902b65959a1ba4df8",
"assets/assets/icons/lottie/extreme-hail.json": "3db63e7c9a590beb11ff4d041513e8c2",
"assets/assets/icons/lottie/extreme-haze.json": "655eb55abf36a9aceab4dc1e51e45725",
"assets/assets/icons/lottie/extreme-night-drizzle.json": "2c013ebee4ce2ae99544346956dbaff1",
"assets/assets/icons/lottie/extreme-night-fog.json": "56a0073924b93c51a7424ea698336651",
"assets/assets/icons/lottie/extreme-night-hail.json": "9e164a303f9dafa42704190d21c8b046",
"assets/assets/icons/lottie/extreme-night-haze.json": "242822656424fe489f6e4b8ce27d26d5",
"assets/assets/icons/lottie/extreme-night-rain.json": "4ecceca4326a3be6ff277391e1ad370d",
"assets/assets/icons/lottie/extreme-night-sleet.json": "c66122355a835181f8836d4ea2303af1",
"assets/assets/icons/lottie/extreme-night-smoke.json": "88a4f2d0d0b14332645e802c3907e2c1",
"assets/assets/icons/lottie/extreme-night-snow.json": "3c428b5a82a52d288671a39896bb10a5",
"assets/assets/icons/lottie/extreme-night.json": "25b59b03af5c027d8c7ab42d99ca4621",
"assets/assets/icons/lottie/extreme-rain.json": "f66e5608499c32a6a75c0dbff67d3cf7",
"assets/assets/icons/lottie/extreme-sleet.json": "ed48bffe458984b7bdd0d5457d16ee2b",
"assets/assets/icons/lottie/extreme-smoke.json": "91358fbefbd9fbd12f795a3885469eb1",
"assets/assets/icons/lottie/extreme-snow.json": "a55eba12e628628334e3035e3113c9a0",
"assets/assets/icons/lottie/extreme.json": "003ff3123578669bdefc15d82431f238",
"assets/assets/icons/lottie/fahrenheit.json": "35d9eae57f99132ffdcfc63cab10a857",
"assets/assets/icons/lottie/falling-stars.json": "320e3508c432961cccfbd86d08674235",
"assets/assets/icons/lottie/flag-gale-warning.json": "7161d4ab298fd14bc0863462ac882cb9",
"assets/assets/icons/lottie/flag-hurricane-warning.json": "dd0616f52b6b12f21d616c605b5d8c72",
"assets/assets/icons/lottie/flag-small-craft-advisory.json": "0314feb93d8fe365be38be05ea7235ac",
"assets/assets/icons/lottie/flag-storm-warning.json": "f33a6c125b724963942a79f124e21664",
"assets/assets/icons/lottie/fog-day.json": "1acf395385600360ab93ab0f8b54814d",
"assets/assets/icons/lottie/fog-night.json": "f8f3446792de1246fac7e70001b007dd",
"assets/assets/icons/lottie/fog.json": "b95c4cec6e2c69ace966f639bf5fcec4",
"assets/assets/icons/lottie/glove.json": "631ba94b57fedaed9073886c674a2133",
"assets/assets/icons/lottie/hail.json": "ca247f7b68127b2f7d728a7a66acb4fe",
"assets/assets/icons/lottie/haze-day.json": "627573a46953bfc056272f7f7af675c9",
"assets/assets/icons/lottie/haze-night.json": "7b09a20be64e33b8e2e5420086b6f4f3",
"assets/assets/icons/lottie/haze.json": "74a77bac04a1ed1f5c66f2ecc33f0ec0",
"assets/assets/icons/lottie/horizon.json": "cd04b439c2f27eed3c7452074247295c",
"assets/assets/icons/lottie/humidity.json": "2943462aeb9123ddd27944223d840fa3",
"assets/assets/icons/lottie/hurricane.json": "72be1206df1a3c67e4a5d3de181a06d2",
"assets/assets/icons/lottie/lightning-bolt.json": "5e4bbd5755fd652f315b83adc69aaf14",
"assets/assets/icons/lottie/mist.json": "9ddbe1c41c3dd0dd03befada652a8bbe",
"assets/assets/icons/lottie/moon-first-quarter.json": "1030b17a98eee6dfcb645d935d2079ed",
"assets/assets/icons/lottie/moon-full.json": "b6f33434a7d93975a3c7e8f42f142680",
"assets/assets/icons/lottie/moon-last-quarter.json": "2ac42f1833affed5542bcdb8bb7ed2b6",
"assets/assets/icons/lottie/moon-new.json": "d8115e2bea96b3f86c31d3d9e1b6ceda",
"assets/assets/icons/lottie/moon-waning-crescent.json": "13462bc42930ebd34af7536262ddffeb",
"assets/assets/icons/lottie/moon-waning-gibbous.json": "82ab8e3ee0cb025f0a127ddd5dd13066",
"assets/assets/icons/lottie/moon-waxing-crescent.json": "f19a290debd799511ac53ebc54ab724e",
"assets/assets/icons/lottie/moon-waxing-gibbous.json": "ae0345bdb31b79cf88620257c009015a",
"assets/assets/icons/lottie/moonrise.json": "55e1f7a3226032c952a9c49068e4c016",
"assets/assets/icons/lottie/moonset.json": "807b76bd8191d3961e7743d5cd819f34",
"assets/assets/icons/lottie/not-available.json": "c1ccc4605b027dab65e1ed5a8c415311",
"assets/assets/icons/lottie/overcast-day-drizzle.json": "fcd39bd62ca03d11b5c9fd154654484d",
"assets/assets/icons/lottie/overcast-day-fog.json": "9714925dc030870c2bef9da3157089eb",
"assets/assets/icons/lottie/overcast-day-hail.json": "6746218f8a0544028863b1a84def1542",
"assets/assets/icons/lottie/overcast-day-haze.json": "0721c936e27bb2c75990eee2e534bee2",
"assets/assets/icons/lottie/overcast-day-rain.json": "01fbc620efef7ec4bb4f64ef3d3f395f",
"assets/assets/icons/lottie/overcast-day-sleet.json": "b948b85d20d061cf95fa330ae0e571f7",
"assets/assets/icons/lottie/overcast-day-smoke.json": "ff9933afe20267ca65a85c4d2df089fc",
"assets/assets/icons/lottie/overcast-day-snow.json": "077dcc59018717c4557e4529edd06af8",
"assets/assets/icons/lottie/overcast-day.json": "8a085d83dc1be2bb8c275f0b5a908952",
"assets/assets/icons/lottie/overcast-drizzle.json": "f593788c6090f3ee3e0b3464a8ccc885",
"assets/assets/icons/lottie/overcast-fog.json": "af0fe6a7aae975575e3b1f5798a8699a",
"assets/assets/icons/lottie/overcast-hail.json": "5b90198a6e61e6bc4a646b15e0b3e2ba",
"assets/assets/icons/lottie/overcast-haze.json": "57cb7977ed5c60466991c804113b3372",
"assets/assets/icons/lottie/overcast-night-drizzle.json": "54b7ee23c090dd2f0663dac59fec28be",
"assets/assets/icons/lottie/overcast-night-fog.json": "988b011a7507d5897ddc8c890601b8c5",
"assets/assets/icons/lottie/overcast-night-hail.json": "992fbc9d6ab483829426da7861b88625",
"assets/assets/icons/lottie/overcast-night-haze.json": "aab0fdcd06ca11dd14aa2673f230040d",
"assets/assets/icons/lottie/overcast-night-rain.json": "66206714815ed55a9d18a7faa5a0ad94",
"assets/assets/icons/lottie/overcast-night-sleet.json": "da36f4bbe81bf54d79d6cdfaae8fba73",
"assets/assets/icons/lottie/overcast-night-smoke.json": "25124f5553dceb88e6081de2f803e7f0",
"assets/assets/icons/lottie/overcast-night-snow.json": "6904d13e12cbf263eecc878a5d5d3244",
"assets/assets/icons/lottie/overcast-night.json": "afb55e90832f6685f7350a826e7db132",
"assets/assets/icons/lottie/overcast-rain.json": "beb98bf42b5d54a4a131969bfc9e00e0",
"assets/assets/icons/lottie/overcast-sleet.json": "b6780078ad05e2d05c5039f60af86770",
"assets/assets/icons/lottie/overcast-smoke.json": "b9d8e278cb377377d97db2bcb100097d",
"assets/assets/icons/lottie/overcast-snow.json": "f1f96e6448bcbfe6e82d7442c1647cb8",
"assets/assets/icons/lottie/overcast.json": "a4d277582088c46add59fff6c6a5d0f1",
"assets/assets/icons/lottie/partly-cloudy-day-drizzle.json": "7f89a5497c8414c0256e3a5124c836ca",
"assets/assets/icons/lottie/partly-cloudy-day-fog.json": "0d9f599b9b34fc51ae8f8e84fc80988d",
"assets/assets/icons/lottie/partly-cloudy-day-hail.json": "2de5a504d0a21148a6a829c281a8b993",
"assets/assets/icons/lottie/partly-cloudy-day-haze.json": "ae7a3f0fd9df3eb1de3f860cd472c88f",
"assets/assets/icons/lottie/partly-cloudy-day-rain.json": "339f40fca8dc00c95e857561c8e22fdb",
"assets/assets/icons/lottie/partly-cloudy-day-sleet.json": "38ed690a0b9e5751a86e12f21f3186c1",
"assets/assets/icons/lottie/partly-cloudy-day-smoke.json": "8f8f4546570acdff4568e71c0cbe150e",
"assets/assets/icons/lottie/partly-cloudy-day-snow.json": "72e0c45f760744ff06412a3cb9346249",
"assets/assets/icons/lottie/partly-cloudy-day.json": "7872a9bb188b19c416b46053671ce8b3",
"assets/assets/icons/lottie/partly-cloudy-night-drizzle.json": "ec28fd2a1cfd013230c69027ef5258d5",
"assets/assets/icons/lottie/partly-cloudy-night-fog.json": "b8bfc0fa52a5099bd84bcb5a166321b1",
"assets/assets/icons/lottie/partly-cloudy-night-hail.json": "a9c06ede1cac02b6c3b30c9b40f6c954",
"assets/assets/icons/lottie/partly-cloudy-night-haze.json": "d97562d08ad42c1464f8ca0ff0c2000e",
"assets/assets/icons/lottie/partly-cloudy-night-rain.json": "ef42ffdf33e745c8ae7f76e9eb42a25a",
"assets/assets/icons/lottie/partly-cloudy-night-sleet.json": "48a171f8c8cea0ee6899086464b5b630",
"assets/assets/icons/lottie/partly-cloudy-night-smoke.json": "e31414c5739c638f1f4e83aa9d8c0980",
"assets/assets/icons/lottie/partly-cloudy-night-snow.json": "b1195e2d4831991b4b6617212781cb22",
"assets/assets/icons/lottie/partly-cloudy-night.json": "781b55a4e30136c578fc7a6ddaa8b93f",
"assets/assets/icons/lottie/pollen-flower.json": "d07b928f8673ba223fa9c7cdec6ddcd9",
"assets/assets/icons/lottie/pollen-grass.json": "1b8351e10688639a073758d5c58dc25b",
"assets/assets/icons/lottie/pollen-tree.json": "e0d77be4108e5ae1de4ff7c19e8951c8",
"assets/assets/icons/lottie/pollen.json": "3df342fdcb1f0df37a8bbd401b2a8e9b",
"assets/assets/icons/lottie/pressure-high-alt.json": "97fa896f17ebb37f6815525befb65f2d",
"assets/assets/icons/lottie/pressure-high.json": "874e7fc1e371adc26df0656f3987e6c3",
"assets/assets/icons/lottie/pressure-low-alt.json": "b13077d78190066f60944628d88c49f7",
"assets/assets/icons/lottie/pressure-low.json": "f34447f8f7aa769b9c17695218ada16d",
"assets/assets/icons/lottie/rain.json": "d511d849812b30095ecea06d8fcbbba4",
"assets/assets/icons/lottie/rainbow-clear.json": "b48cb0bdb2566bc9dbdf6eb5eb74a92c",
"assets/assets/icons/lottie/rainbow.json": "5d665df953edba3866edf7769786ae5b",
"assets/assets/icons/lottie/raindrop-measure.json": "889c9849255a508770cb5999633593a0",
"assets/assets/icons/lottie/raindrop.json": "7b2954c8a0b3b16e6a871307437bdb94",
"assets/assets/icons/lottie/raindrops.json": "2d9fae3f455d48a4c0470d5009013ccc",
"assets/assets/icons/lottie/sleet.json": "0241971bbe63a2bafd1a29e955765f66",
"assets/assets/icons/lottie/smoke-particles.json": "4f5b613184d1e22140ffe146bc364ba0",
"assets/assets/icons/lottie/smoke.json": "f5f3c1777eed5c63f170772d48fadceb",
"assets/assets/icons/lottie/snow.json": "0d5b929993777cc4317d804bcf6d3ed4",
"assets/assets/icons/lottie/snowflake.json": "8c98e389e83a83efcabdc5f9610f9486",
"assets/assets/icons/lottie/snowman.json": "1ce5498a5bafb146c4e46258ca7b4f22",
"assets/assets/icons/lottie/solar-eclipse.json": "018dc5a53f85da7791d5b9f185b7d3ed",
"assets/assets/icons/lottie/star.json": "4a7e02af23d53c8fb6cb98c320033b75",
"assets/assets/icons/lottie/starry-night.json": "1c3472a051cfd5f327ad20ca404525a6",
"assets/assets/icons/lottie/sun-hot.json": "9c3e912c778619affa1d295e7c0c8fcf",
"assets/assets/icons/lottie/sunrise.json": "c1d0bf866372f913ebf52a50326689d5",
"assets/assets/icons/lottie/sunset.json": "1e075f0fd920febef34b5288618aeb4b",
"assets/assets/icons/lottie/thermometer-celsius.json": "e637522b545c68590d14d3a2c808a7d2",
"assets/assets/icons/lottie/thermometer-colder.json": "e6e6394df415d97ca8aad3240d3c2278",
"assets/assets/icons/lottie/thermometer-fahrenheit.json": "e12c74415915f3311356e505d310f3f5",
"assets/assets/icons/lottie/thermometer-glass-celsius.json": "1ea3c8a098c1171b5935d3ab7c67524e",
"assets/assets/icons/lottie/thermometer-glass-fahrenheit.json": "26a403d45c836884f600c5c1dbc7e7d5",
"assets/assets/icons/lottie/thermometer-glass.json": "50508cc2100f10001086e1a692916c70",
"assets/assets/icons/lottie/thermometer-mercury-cold.json": "a682c1f8d876793d6f1349a00416a1bc",
"assets/assets/icons/lottie/thermometer-mercury.json": "86493c35a1e924ad7a34fadf7b9ccd0c",
"assets/assets/icons/lottie/thermometer-moon.json": "ad0b802771d8a0b2b7c1529c2f1ea231",
"assets/assets/icons/lottie/thermometer-raindrop.json": "e49ada39babeb7d9a0009c589743c0ea",
"assets/assets/icons/lottie/thermometer-snow.json": "9b7cd8375cdd9d52a7325bde90317459",
"assets/assets/icons/lottie/thermometer-sun.json": "73095b9d81c442cd523fbb985363a73f",
"assets/assets/icons/lottie/thermometer-warmer.json": "5c9c15207267394dab5dfa04d2047fd0",
"assets/assets/icons/lottie/thermometer-water.json": "9cb8f2a421c798570cdab02ae2442c89",
"assets/assets/icons/lottie/thermometer.json": "d8e42bffa917efdbc4ec7112a01401e6",
"assets/assets/icons/lottie/thunderstorms-day-extreme-rain.json": "9c263b7226117532211d2b21f6d6bce6",
"assets/assets/icons/lottie/thunderstorms-day-extreme-snow.json": "75019a80ad92716d3185340ae815f876",
"assets/assets/icons/lottie/thunderstorms-day-extreme.json": "189a05a56175f88f494aee77f0b7db5c",
"assets/assets/icons/lottie/thunderstorms-day-overcast-rain.json": "cab2cedb8fbc5f3cf2f51560d8f06fa7",
"assets/assets/icons/lottie/thunderstorms-day-overcast-snow.json": "d56eed6497c6d62606a12df9d4a860b5",
"assets/assets/icons/lottie/thunderstorms-day-overcast.json": "0d458749570a4de03aed80001bc02177",
"assets/assets/icons/lottie/thunderstorms-day-rain.json": "54c0b499b452a9918799aba1620869b8",
"assets/assets/icons/lottie/thunderstorms-day-snow.json": "c0544b31331676db62d878a6971d6a9b",
"assets/assets/icons/lottie/thunderstorms-day.json": "31be2a55c98318a85b6bfa659104fb4c",
"assets/assets/icons/lottie/thunderstorms-extreme-rain.json": "e93c525270de34d9d584d6e20d793724",
"assets/assets/icons/lottie/thunderstorms-extreme-snow.json": "35722780861d6be660d879085c9a991c",
"assets/assets/icons/lottie/thunderstorms-extreme.json": "7c080cd4e2cb495ef1e5bfa28a4395fd",
"assets/assets/icons/lottie/thunderstorms-night-extreme-rain.json": "41e654049349056daa8e383e5b5820cc",
"assets/assets/icons/lottie/thunderstorms-night-extreme-snow.json": "291621a7701cd584ced52ec78ca5a316",
"assets/assets/icons/lottie/thunderstorms-night-extreme.json": "0490c61579d2927d8f454652a62bf058",
"assets/assets/icons/lottie/thunderstorms-night-overcast-rain.json": "46e8624fa7a9e7ad63947cc01bdbc12a",
"assets/assets/icons/lottie/thunderstorms-night-overcast-snow.json": "75eb39c07b90dedf41dc0695dcc8f35e",
"assets/assets/icons/lottie/thunderstorms-night-overcast.json": "56e642b79124ccf650a2bdedfe987017",
"assets/assets/icons/lottie/thunderstorms-night-rain.json": "0f753cb0d660f7e8444028be7aaca9b3",
"assets/assets/icons/lottie/thunderstorms-night-snow.json": "d725721e40ccd1975708682c6ca0f9f7",
"assets/assets/icons/lottie/thunderstorms-night.json": "ec62c05d104cf5a901f8cd51bb3bd85f",
"assets/assets/icons/lottie/thunderstorms-overcast-rain.json": "b36449462166c909119c583b76d1a214",
"assets/assets/icons/lottie/thunderstorms-overcast-snow.json": "b2e2c25c52a5d18f277085a17036b3ba",
"assets/assets/icons/lottie/thunderstorms-overcast.json": "30cada7285ab7193ccb8c121af48056a",
"assets/assets/icons/lottie/thunderstorms-rain.json": "5a8c2f745d24c4daa28ff8a0f6094914",
"assets/assets/icons/lottie/thunderstorms-snow.json": "c3739aa17123824fd857b913cdc5834c",
"assets/assets/icons/lottie/thunderstorms.json": "6bfc424934e08038ed0a553d6f60741c",
"assets/assets/icons/lottie/tide-high.json": "c84c15270b58ed43417d826ba99dd96f",
"assets/assets/icons/lottie/tide-low.json": "254fe829b0747109e84bab055dfc83cb",
"assets/assets/icons/lottie/time-afternoon.json": "4be2feaf128eace833329ed7078f2d1d",
"assets/assets/icons/lottie/time-evening.json": "ac950db55181a3ff5099d78725c9d74a",
"assets/assets/icons/lottie/time-late-afternoon.json": "0a12b8a8383ebba93721b0587e9744ff",
"assets/assets/icons/lottie/time-late-evening.json": "53187cf56376eac1106758014a012282",
"assets/assets/icons/lottie/time-late-morning.json": "6fe0b571501827bdea5435550d96f95e",
"assets/assets/icons/lottie/time-late-night.json": "ef2b864eb22c1fb2494d51bee2a1d1a6",
"assets/assets/icons/lottie/time-morning.json": "3c4f81d210315d5750a333b91630aeae",
"assets/assets/icons/lottie/time-night.json": "fa9d4caa7b2ca11b92ebebda660e9e7a",
"assets/assets/icons/lottie/tornado.json": "86ee7cec64d33a61d7f9ec16f19fbc85",
"assets/assets/icons/lottie/umbrella-wind-alt.json": "0d8499305f4daa06b753df0a377dedd2",
"assets/assets/icons/lottie/umbrella-wind.json": "3d75e863133efb6be3bc7f43fc18cf81",
"assets/assets/icons/lottie/umbrella.json": "f2594947dde0c638830d9b689645f891",
"assets/assets/icons/lottie/uv-index-1.json": "4ad984b9fbd9503029e3b28b61d9eccd",
"assets/assets/icons/lottie/uv-index-10.json": "186dccc15370a43e5bcedc35b96153d0",
"assets/assets/icons/lottie/uv-index-11.json": "b7758c29f70618cd92ccaa08699094b5",
"assets/assets/icons/lottie/uv-index-2.json": "be5e16fd18379dfa24aed95a0bdca36e",
"assets/assets/icons/lottie/uv-index-3.json": "aec5647326bda2f858b0263fd19e3f90",
"assets/assets/icons/lottie/uv-index-4.json": "8d242113ecd78525445f77fdba86e866",
"assets/assets/icons/lottie/uv-index-5.json": "17366fea60b256984923c1d9b6875fe6",
"assets/assets/icons/lottie/uv-index-6.json": "64f00c9a36675330c77fd19e98b3cb6e",
"assets/assets/icons/lottie/uv-index-7.json": "d91135cb08b56af848f15f52bd0e7f10",
"assets/assets/icons/lottie/uv-index-8.json": "cd0af38b473d9c62e8899532b804e548",
"assets/assets/icons/lottie/uv-index-9.json": "412a0d7cdf10332adc929d2001334d42",
"assets/assets/icons/lottie/uv-index.json": "6c32682d2dab12dd6d10aec5ffa0d17d",
"assets/assets/icons/lottie/wind-alert.json": "7e55e517ebb79a083eff6a2bfe33d003",
"assets/assets/icons/lottie/wind-beaufort-0.json": "f64b6f1483a8e05d2f7b235179de6454",
"assets/assets/icons/lottie/wind-beaufort-1.json": "897bb41c63a529b44821e5425c31b01a",
"assets/assets/icons/lottie/wind-beaufort-10.json": "293af2c7f860f5e88f8490c9fb4ce589",
"assets/assets/icons/lottie/wind-beaufort-11.json": "c20145d95314d8df64c29f0158955e90",
"assets/assets/icons/lottie/wind-beaufort-12.json": "6d9dacea0ce3141256e6650440f14a77",
"assets/assets/icons/lottie/wind-beaufort-2.json": "80b385b0b5c601e177d387c518adb567",
"assets/assets/icons/lottie/wind-beaufort-3.json": "fe4f765df86c8fe36f35198e0d72407c",
"assets/assets/icons/lottie/wind-beaufort-4.json": "8908dc3750ddb3f5b6ae880bc7aa7f82",
"assets/assets/icons/lottie/wind-beaufort-5.json": "2bb2182062983f824684e5a898fb9e10",
"assets/assets/icons/lottie/wind-beaufort-6.json": "5cda9cebed81ae657203271a6dfc7a1f",
"assets/assets/icons/lottie/wind-beaufort-7.json": "1dbbb330b34663d9a20bbbacc2555124",
"assets/assets/icons/lottie/wind-beaufort-8.json": "32fd3e7c98bf481219a9c42361701fa7",
"assets/assets/icons/lottie/wind-beaufort-9.json": "a1a58a9f1651432b96c23923a2e95f70",
"assets/assets/icons/lottie/wind-offshore.json": "5ee83dd647e57ae55a752c10db7353a4",
"assets/assets/icons/lottie/wind-onshore.json": "0d5afe536ec98b6f7eec749a9eef704f",
"assets/assets/icons/lottie/wind-snow.json": "ee76d382d6e1697aef2a49e75d87d749",
"assets/assets/icons/lottie/wind.json": "7222cda567692575e8e83523770ab219",
"assets/assets/icons/lottie/windsock-weak.json": "6b6f9471cb7daf67b6feeda8fb87a918",
"assets/assets/icons/lottie/windsock.json": "f4660547456b217cb79b8f44938f7ed1",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "d8eb6ac8d45f174a6737c9045d64f2c6",
"assets/NOTICES": "bdad859b32d5088e02b3e7c13aef22ed",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "c03b38fbd388953bd76516b92a476883",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "5ebf00e80265da2b34fd7ef939c15dad",
"icons/Icon-512.png": "d30b1c24908d4b1899fac0b1af7c2421",
"icons/Icon-maskable-192.png": "5ebf00e80265da2b34fd7ef939c15dad",
"icons/Icon-maskable-512.png": "d30b1c24908d4b1899fac0b1af7c2421",
"index.html": "a27105107f125a97ecb5b248c088ae9d",
"/": "a27105107f125a97ecb5b248c088ae9d",
"main.dart.js": "848b7b630615e2e21673b060f1890f6e",
"manifest.json": "213e0911922f66c429857f1f7ab7ad6a",
"version.json": "cb52daa919d6aa3bbe5d0f27829cdad0"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
