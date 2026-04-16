
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local maxDistance = 5
local WATER_GROUND_ID = 26382

local FORBIDDEN_ITEM_IDS = {
    [28063] = true,
    [29400] = true,
    [29401] = true
}

local CLOSED_DOOR_ID = 30126
local OPEN_DOOR_ID = 30127
local STAIR_EXIT_ITEM_ID = 28080

local STEP_INTERVAL_MIN = 500
local STEP_INTERVAL_MAX = 500

local IDLE_MIN = 7000
local IDLE_MAX = 18000

local VISIT_MIN = 16000
local VISIT_MAX = 34000

local SIT_MIN = 14000
local SIT_MAX = 28000

local ROAM_PULSE_MIN = 12000
local ROAM_PULSE_MAX = 30000
local ROAM_PULSE_CHANCE = 78

local INITIAL_ACTION_MIN = 4000
local INITIAL_ACTION_MAX = 90000

local TALK_COOLDOWN_MIN = 3500
local TALK_COOLDOWN_MAX = 7000

local TALK_TRY_MIN = 700
local TALK_TRY_MAX = 1200

local TALK_START_CHANCE = 97
local SPECIAL_CITIZEN_TALK_CHANCE = 92

local SPECIAL_CITIZEN_NAMES = {
    ["Yukari Yamada"] = true,
    ["Raiden Igarashi"] = true,
    ["Jiro Miyazaki"] = true,
    ["Souta Hirano"] = true,
    ["Saki Otsuka"] = true,
    ["Sumire Noguchi"] = true,
    ["Saburo Okabe"] = true,
    ["Miyu Okamoto"] = true,
    ["Chika Furukawa"] = true,
    ["Isamu Furukawa"] = true,
    ["Mika Hirano"] = true,
    ["Makoto Maeda"] = true,
    ["Yuna Okabe"] = true,
    ["Toma Matsuda"] = true,
    ["Shohei Kawasaki"] = true,
    ["Madoka Nakamura"] = true,
    ["Raiden Hirano"] = true,
    ["Takeru Sakamoto"] = true,
    ["Daisuke Kawasaki"] = true,
    ["Kenta Morita"] = true,
    ["Izumi Shibata"] = true,
    ["Shoma Tanimura"] = true,
    ["Keiji Okabe"] = true,
    ["Yuna Hirano"] = true,
    ["Kaori Kawamura"] = true,
    ["Marika Sakurai"] = true,
    ["Aoi Noguchi"] = true,
    ["Ryota Hashimoto"] = true,
    ["Eiji Furukawa"] = true,
    ["Hideo Kimura"] = true,
    ["Jiro Kawamura"] = true,
    ["Keiji Kawasaki"] = true,
    ["Riku Saito"] = true,
    ["Yui Fujita"] = true,
    ["Shohei Arai"] = true,
    ["Natsuo Ueda"] = true,
    ["Saburo Yamamoto"] = true,
    ["Ume Ishida"] = true,
    ["Shiro Sakurai"] = true,
    ["Hotaru Mizuno"] = true,
    ["Shiro Kobayashi"] = true,
    ["Haruka Nakamura"] = true,
    ["Keiji Endo"] = true,
    ["Hoshi Hoshino"] = true,
    ["Tatsuya Shimada"] = true,
    ["Jiro Igarashi"] = true,
    ["Kenta Okabe"] = true,
    ["Sora Furukawa"] = true,
    ["Izumi Arai"] = true,
    ["Ayame Matsuoka"] = true,
    ["Marika Kuroda"] = true,
    ["Haru Tsuchiya"] = true,
    ["Hoshi Okabe"] = true,
    ["Rei Hayashi"] = true,
    ["Atsushi Tachibana"] = true,
    ["Asami Maeda"] = true,
    ["Kenta Saito"] = true,
    ["Naoki Saito"] = true,
    ["Asami Yamamoto"] = true,
    ["Jiro Saito"] = true,
    ["Emi Okamoto"] = true,
    ["Koji Yamamoto"] = true,
    ["Yukari Endo"] = true,
    ["Nobu Endo"] = true,
    ["Rina Kawamura"] = true,
    ["Yuji Sakamoto"] = true,
    ["Itsuki Igarashi"] = true,
    ["Hayato Hashimoto"] = true,
    ["Koji Hirano"] = true,
    ["Tamaki Noguchi"] = true,
    ["Toma Hayashi"] = true,
    ["Koharu Takeda"] = true,
    ["Shin Fukuda"] = true,
    ["Hotaru Matsuoka"] = true,
    ["Shiori Yamamoto"] = true,
    ["Hideki Nakagawa"] = true,
    ["Masaru Yoshida"] = true,
    ["Yori Kawasaki"] = true,
    ["Haru Kuroda"] = true,
    ["Daichi Tachibana"] = true,
    ["Raiden Ishida"] = true,
    ["Taichi Inoue"] = true,
    ["Atsushi Kanzaki"] = true,
    ["Reika Sakurai"] = true,
    ["Fuyumi Mori"] = true,
    ["Tatsuya Nakamura"] = true,
    ["Yukari Tachibana"] = true,
    ["Akio Okamoto"] = true,
    ["Sayuri Yoshida"] = true,
    ["Yuji Matsuoka"] = true,
    ["Minato Morita"] = true,
    ["Kazuki Hoshino"] = true,
    ["Saki Yoshida"] = true,
    ["Koji Fujita"] = true,
    ["Miyu Mizuno"] = true,
    ["Emi Ishida"] = true,
    ["Eiji Sakurai"] = true,
    ["Kaori Morita"] = true,
    ["Daichi Tsuchiya"] = true,
    ["Toshiro Fukuda"] = true
}

local TALK_SEARCH_RANGE = 12
local TALK_IDLE_REQUIRED_MS = 0

local PATH_RECALC_MS = 1600
local PATH_MAX_NODES = 1200
local PATH_MARGIN = 4
local MAX_TARGET_DISTANCE = 28
local LOCAL_ROAM_RADIUS = 8
local STREET_ROAM_MIN_STEPS = 6
local STREET_ROAM_MAX_STEPS = 18
local STREET_ROAM_TURN_CHANCE = 30
local STREET_VISIT_CHANCE = 28

local LOOP_IDLE_MS = 500
local LOOP_MOVE_MS = 180
local LOOP_TALK_MS = 180
local LOOP_SEATED_MS = 700
local LOOP_VISIT_MS = 450

local PLAYER_NOTICE_RANGE = 5
local PLAYER_NOTICE_CHANCE = 18
local PLAYER_NOTICE_COOLDOWN_MIN = 15000
local PLAYER_NOTICE_COOLDOWN_MAX = 35000

local SELF_TALK_CHANCE = 5
local SELF_TALK_MIN = 18000
local SELF_TALK_MAX = 45000

local STUCK_REPATH_THRESHOLD = 3
local DETOUR_SEARCH_RADIUS = 2
local HARD_STUCK_THRESHOLD = 8

local TARGET_FAILS_BEFORE_CHANGE = 2

local MARKET_RECOVERY_RECTS = {
    {from = Position(5797, 5139, 7), to = Position(5810, 5151, 7)}
}

local MAIN_STREET_RECTS = {
    {from = Position(5803, 5001, 7), to = Position(5803, 5389, 7)},
    {from = Position(5545, 5144, 7), to = Position(6020, 5144, 7)},
    {from = Position(5573, 5042, 7), to = Position(5803, 5043, 7)},
    {from = Position(5702, 5007, 7), to = Position(5803, 5007, 7)},
    {from = Position(5803, 5018, 7), to = Position(5874, 5018, 7)},
    {from = Position(5863, 5032, 7), to = Position(5864, 5069, 7)},
    {from = Position(5803, 5069, 7), to = Position(5967, 5069, 7)},
    {from = Position(5827, 5069, 7), to = Position(5827, 5101, 7)},
    {from = Position(5909, 5144, 7), to = Position(5909, 5183, 7)},
    {from = Position(5934, 5183, 7), to = Position(5934, 5218, 7)},
    {from = Position(5954, 5218, 7), to = Position(5954, 5360, 7)},
    {from = Position(5718, 5332, 7), to = Position(5777, 5332, 7)},
    {from = Position(5718, 5252, 7), to = Position(5718, 5368, 7)}
}

local CONNECTOR_POSITIONS = {
    bar = Position(5804, 5119, 7),
    restaurant = Position(5871, 5068, 7),
    cemetery = Position(5968, 5126, 7)
}

local DEBUG_ENABLED = false

local PREFERRED_GROUNDS = {
    [28160] = 10,
    [26414] = 8,
    [27896] = 7,
    [27928] = 6,
    [26408] = 1
}

local resetToIdle
local chooseNewDestination

local states = {}

local triggerWords = {
    ["hi"] = true,
    ["hello"] = true,
    ["hey"] = true,
    ["greetings"] = true
}

local greetings = {
    "Hello there.",
    "Good day.",
    "Stay safe.",
    "Welcome to Konoha.",
    "Lovely weather today.",
    "Busy day, huh?",
    "Take care.",
    "Another day in the village.",
    "Good to see you.",
    "Do not cause trouble, alright?"
}

local playerNoticeLines = {
    "Hello, {name}.",
    "Good day, {name}.",
    "Stay safe out there, {name}.",
    "You look busy, {name}.",
    "Take care, {name}.",
    "Another day in Konoha, {name}?",
    "Do not get into trouble, {name}.",
    "You seem in a hurry, {name}.",
    "Careful on the roads, {name}.",
    "I hope your day goes well, {name}.",
    "Everything alright, {name}?",
    "The village is lively today, {name}.",
    "You look like you have somewhere to be, {name}.",
    "Try to enjoy the day, {name}.",
    "Keep your eyes open, {name}.",
    "Take it easy, {name}.",
    "The streets are crowded today, {name}.",
    "You are out early, {name}.",
    "Do not overwork yourself, {name}.",
    "Watch your step, {name}."
}

local namedNpcMentions = {
    "I saw Mizuki earlier. He looked busy as ever.",
    "Iruka always seems to have somewhere to be.",
    "Hiruzen still carries the whole village on his shoulders.",
    "Anko walks around like trouble is looking for her.",
    "Shibi never wastes words.",
    "Ibiki can make a room go silent just by entering it.",
    "Might Guy has enough energy for ten people.",
    "Naoki takes his duty at the academy gate seriously.",
    "Hibiki looked worried the last time I saw her.",
    "Makoto never seems far from his errands.",
    "Haruya always smells like snacks.",
    "Hiruzen probably knows half the village by name.",
    "Anko says what she thinks. Not everyone likes that.",
    "Mizuki keeps a close eye on the students.",
    "Iruka has more patience than most people here.",
    "Guy could probably encourage a stone to start training."
}

local importantHolidayMap = {
    ["01-01"] = "Founding Day",
    ["03-21"] = "Spring Festival",
    ["05-05"] = "Children's Day",
    ["07-01"] = "Academy Entrance Day",
    ["10-15"] = "Harvest Festival",
    ["12-31"] = "Lantern Night"
}

local weekdayTalkMap = {
    Monday = {
        "Mondays always feel a little heavier.",
        "It is Monday. Everyone already looks busy.",
        "A Monday crowd is never the friendliest crowd."
    },
    Tuesday = {
        "Tuesday is usually steadier than Monday.",
        "A Tuesday like this keeps the village moving.",
        "It is Tuesday. Work settles into its rhythm."
    },
    Wednesday = {
        "Wednesday always feels like the middle of a long road.",
        "A quiet Wednesday is rare in Konoha.",
        "It is Wednesday. Half the week is already gone."
    },
    Thursday = {
        "Thursday always makes the week feel faster.",
        "It is Thursday. People start thinking ahead.",
        "A Thursday crowd is easier to read than a Monday one."
    },
    Friday = {
        "Friday puts everyone in a lighter mood.",
        "It is Friday. Even the streets feel different.",
        "By Friday, people are ready to breathe a little."
    },
    Saturday = {
        "Saturday makes the village feel more relaxed.",
        "It is Saturday. No wonder the streets are full.",
        "A Saturday in Konoha always has its own energy."
    },
    Sunday = {
        "Sunday makes even busy people slow down a little.",
        "It is Sunday. The village sounds different today.",
        "A quiet Sunday is one of the best gifts Konoha can give."
    }
}

local holidayTalkMap = {
    ["Founding Day"] = {
        "Founding Day always makes people speak proudly about the village.",
        "There is something special in the air on Founding Day.",
        "Founding Day reminds people why Konoha stands."
    },
    ["Spring Festival"] = {
        "The Spring Festival always brightens the streets.",
        "The village feels softer during the Spring Festival.",
        "Even serious people loosen up a little during the Spring Festival."
    },
    ["Children's Day"] = {
        "Children's Day always makes the academy area louder.",
        "The village feels younger on Children's Day.",
        "Children's Day brings out a lot of smiles."
    },
    ["Academy Entrance Day"] = {
        "Academy Entrance Day always fills the village with nervous excitement.",
        "You can almost feel the future of the village on Academy Entrance Day.",
        "Academy Entrance Day reminds everyone where shinobi begin."
    },
    ["Harvest Festival"] = {
        "The Harvest Festival always makes the market feel warmer.",
        "People seem kinder during the Harvest Festival.",
        "A good Harvest Festival lifts the whole village."
    },
    ["Lantern Night"] = {
        "Lantern Night always slows people down in the best way.",
        "The village looks beautiful on Lantern Night.",
        "Lantern Night makes even hard days feel lighter."
    }
}

local randomSmallTalk = {
    "The village feels busy today.",
    "I should get back to my errands.",
    "There is always something going on in Konoha.",
    "A calm day is a rare gift.",
    "I hope the market is not too crowded.",
    "I could use a quiet cup of tea.",
    "So many people walking around today.",
    "Life in the village never really stops.",
    "The streets feel livelier than usual.",
    "I should not stay idle for too long.",
    "Everyone seems to be carrying something today.",
    "Konoha rarely stays quiet for long.",
    "I thought today would be calmer.",
    "There is always one more errand waiting.",
    "The market draws half the village before noon.",
    "A peaceful morning does wonders.",
    "I should stop by the cafe later.",
    "The academy side is always louder than the rest.",
    "The bar will be packed by evening.",
    "It is nice to have a moment without trouble.",
    "I wonder how crowded the ramen place is right now.",
    "The village has a rhythm of its own.",
    "Even a short walk can turn into a long day here.",
    "I should buy what I need before sunset.",
    "Some days the whole village feels restless.",
    "Konoha always finds a way to stay lively.",
    "The roads are never empty for long.",
    "People talk more when the weather is kind.",
    "A little quiet is more valuable than most people think.",
    "I should not waste the day standing around.",
    "There is always someone in a hurry here.",
    "The park is one of the few places that still feels slow.",
    "I should check the shops before they get crowded.",
    "Some corners of the village are calmer than others.",
    "You can learn a lot just by listening to the streets.",
    "A long day starts with a short errand.",
    "The market never really sleeps.",
    "I could spend half the day just watching people pass by.",
    "Konoha feels different every hour.",
    "This part of the village is calmer than most.",
    "The academy is full of energy again.",
    "I should be moving, not daydreaming.",
    "A crowded street still beats a silent one.",
    "The village feels healthy when people are out walking.",
    "Some days even the air feels busy.",
    "A short rest can save the whole day.",
    "There is always news somewhere in Konoha.",
    "I should not leave everything for later.",
    "A village this alive never stays still.",
    "The guards have looked especially alert today.",
    "I hope the shops still have fresh stock.",
    "The sound of people talking is comforting in its own way.",
    "Everyone seems to know something today.",
    "A good day starts with simple things.",
    "I should keep moving before I lose the mood for it.",
    "The streets feel warmer when the village is busy.",
    "I wonder what the academy students are up to now.",
    "It is hard to stay in a bad mood on a day like this.",
    "The village feels fuller near the center.",
    "There is always one familiar face around the next corner.",
    "Some people rush too much through their own day.",
    "A little patience goes a long way in Konoha.",
    "I should not get caught in the evening crowd.",
    "The best time to shop is before everyone else remembers to do it.",
    "Not every busy day is a bad one.",
    "Some places in Konoha make you slow down without trying.",
    "People seem friendlier when the streets are bright.",
    "I should stop putting off the smaller errands.",
    "The whole village feels connected when it is this busy.",
    "There is something comforting about the usual noise.",
    "A little routine keeps the day steady.",
    "The village changes mood faster than people realize.",
    "I should not keep anyone waiting too long.",
    "Even a simple walk can clear the mind.",
    "The roads near the market are never empty for long.",
    "A little fresh air helps more than most people admit.",
    "Konoha feels strongest when everyone is moving forward.",
    "There is always another reason to stay out a little longer.",
    "I could do with something warm to drink.",
    "The village center always pulls people in.",
    "Some days are meant for work. Some are meant for listening.",
    "The streets carry more stories than most books.",
    "A familiar face can improve a whole afternoon.",
    "I should make the most of a quiet moment.",
    "There are worse ways to spend a day than walking through Konoha.",
    "A village like this teaches patience whether you want it to or not.",
    "Even silence sounds different in Konoha.",
    "I should not let the day run ahead of me.",
    "Some people look like they have not slept enough.",
    "The academy grounds always make the village feel younger.",
    "There is comfort in ordinary days.",
    "I should remember to slow down once in a while.",
    "The village breathes differently in the morning.",
    "There is always more movement near the heart of Konoha.",
    "A steady day is often better than an exciting one.",
    "The roads look busier with each passing hour.",
    "A little order keeps the day from slipping away.",
    "It is good to see the village alive.",
    "Some corners of Konoha are better for thinking than others.",
    "A day without trouble is worth appreciating.",
    "You can tell a lot about the village by the sound of its streets.",
    "A little conversation can improve any errand."
}

local pairDialogues = {
    { a = {"did you hear what happened near the market?", "Konoha never stays quiet for long.", "still, today feels peaceful."}, b = {"only rumors. People love talking.", "that is true.", "let us hope it stays that way."} },
    { a = {"you are out early today.", "I had some errands to finish.", "the streets are getting crowded already."}, b = {"so are you.", "same here.", "the village is waking up fast."} },
    { a = {"have you been to the ramen place lately?", "it is always packed.", "but worth it."}, b = {"not today.", "that is usually a good sign.", "I cannot argue with that."} },
    { a = {"the park seems calmer than usual.", "maybe people are busy in the market.", "not the worst thing."}, b = {"I noticed that too.", "probably.", "a little peace is welcome."} },
    { a = {"you look tired.", "too much work?", "you should rest more."}, b = {"it has been a long day.", "among other things.", "you are probably right."} },
    { a = {"the weather has been kind lately.", "makes the village feel lighter.", "I do not mind that at all."}, b = {"for once, yes.", "it really does.", "neither do I."} },
    { a = {"did you come from the cafe?", "it smells amazing near that place.", "hard to resist."}, b = {"I passed by it earlier.", "it always does.", "that is true."} },
    { a = {"I should buy a few things before evening.", "the shops will get crowded soon.", "better not wait."}, b = {"that sounds wise.", "they usually do.", "then do not waste time."} },
    { a = {"the bar seems lively today.", "too lively, maybe.", "still better than silence."}, b = {"it usually gets worse later.", "that may be true.", "depends who you ask."} },
    { a = {"I was thinking of stopping by the market.", "maybe before the evening rush.", "that would be smart."}, b = {"you should go soon.", "yes, before it gets crowded.", "exactly."} },
    { a = {"the village feels calmer in this part.", "not for long, I bet.", "you may be right."}, b = {"enjoy it while it lasts.", "that is usually how it goes.", "still, I will take it."} },
    { a = {"have you seen how busy the streets are?", "feels like everyone is out today.", "no wonder the shops are packed."}, b = {"I noticed that too.", "there is no quiet corner left.", "that sounds about right."} },
    { a = {"have you seen Mizuki today?", "he looked busy earlier.", "the academy never slows down around him."}, b = {"not yet.", "that does not surprise me.", "it rarely does."} },
    { a = {"Iruka seems patient with everyone.", "I do not know how he manages it.", "I would lose my voice by noon."}, b = {"he has a gift for it.", "some people are built that way.", "I believe that."} },
    { a = {"Anko walked by earlier.", "she looked like trouble had somewhere to be.", "that woman never changes."}, b = {"that sounds like Anko.", "she rarely does.", "some things are better that way."} },
    { a = {"I passed the academy not long ago.", "the students were loud enough to wake the dead.", "at least they sound alive."}, b = {"that is the academy for you.", "always full of noise.", "better noise than silence."} },
    { a = {"the market has fresh goods today.", "I could smell it from the road.", "maybe I should head there soon."}, b = {"then do not wait too long.", "other people noticed too.", "you should go while you still can."} },
    { a = {"the guards looked tense earlier.", "maybe it is nothing.", "still, I noticed it."}, b = {"I noticed it too.", "sometimes the mood spreads.", "best not to cause trouble today."} },
    { a = {"Guy was training again.", "I could hear him before I saw him.", "the man has impossible energy."}, b = {"that sounds exactly right.", "some people never run low.", "I cannot imagine living like that."} },
    { a = {"the cafe is quieter than usual.", "I almost stayed there longer.", "it was hard to leave."}, b = {"quiet places do that.", "especially in a village like this.", "I understand that completely."} },
    { a = {"the week is moving quickly.", "feels like yesterday was the beginning of it.", "time runs faster in Konoha."}, b = {"it does feel that way.", "the village never lets you stand still.", "that is true enough."} },
    { a = {"do you think the bar gets too noisy by night?", "sometimes I can hear it from the road.", "some people enjoy that."}, b = {"many do.", "a little noise does not bother everyone.", "I prefer quieter places myself."} },
    { a = {"the park looked peaceful earlier.", "I almost forgot how loud the rest of the village can be.", "it was a good reminder."}, b = {"the park does that.", "some places settle the mind.", "you should go back there later."} },
    { a = {"people seem friendlier today.", "or maybe I am in a better mood.", "either way, I will take it."}, b = {"sometimes that is enough.", "a better mood changes everything.", "no reason to complain then."} },
    { a = {"I heard someone mention Founding Day earlier.", "it made the whole village sound prouder.", "days like that matter."}, b = {"they do.", "people remember what holds them together.", "that matters more than they realize."} },
    { a = {"somebody said the Spring Festival is not far off.", "that would explain the mood in the streets.", "people always soften around it."}, b = {"they do.", "the whole village feels lighter then.", "I would not mind that at all."} },
    { a = {"I saw Naoki at the academy gate.", "he looked like he would spot trouble from a mile away.", "probably a useful habit there."}, b = {"that sounds like him.", "the academy needs eyes like that.", "I would not argue with it."} },
    { a = {"do you ever feel the village listening back?", "all these voices, all these footsteps.", "sometimes Konoha feels alive in its own way."}, b = {"I know what you mean.", "a village this full leaves an impression.", "that is not a bad thing."} },
    { a = {"I keep meaning to finish my errands early.", "and yet the day always gets away from me.", "I am doing it again right now."}, b = {"many people do.", "Konoha is good at stealing hours.", "you should start with the closest task."} },
    { a = {"the church side is calmer than I expected.", "some places make people lower their voices naturally.", "I wish more places did that."}, b = {"it suits that area.", "calm has its own strength.", "people forget that too easily."} }
}

local zones = {
    {
        name = "market",
        weight = 12,
        rects = {
            {from = Position(5797, 5139, 7), to = Position(5810, 5151, 7)}
        },
        lines = {
            "Fresh goods everywhere today.",
            "The market is crowded as always.",
            "I should buy something before it gets busier.",
            "So many voices in one place.",
            "There is always someone selling something here."
        }
    },
    {
        name = "weapon_shop",
        weight = 6,
        rects = {
            {from = Position(5763, 5138, 7), to = Position(5767, 5141, 7)}
        },
        lines = {
            "Steel always has a certain smell to it.",
            "A good blade is never cheap.",
            "Shinobi keep these places busy.",
            "I would not want to stand here all day."
        }
    },
    {
        name = "bar",
        weight = 8,
        rects = {
            {from = Position(5807, 5115, 7), to = Position(5822, 5122, 7)},
            {from = Position(5820, 5106, 7), to = Position(5828, 5113, 7)}
        },
        seatIds = {
            [28555] = true,
            [28556] = true,
            [28557] = true,
            [28558] = true
        },
        tableIds = {
            [28551] = true,
            [28552] = true,
            [28553] = true,
            [28554] = true
        },
        orderSpots = {
            {from = Position(5824, 5119, 7), to = Position(5824, 5122, 7), faceDir = EAST}
        },
        blockedRects = {
            {from = Position(5825, 5118, 7), to = Position(5829, 5122, 7)}
        },
        lines = {
            "This place is louder after sunset.",
            "A drink sounds nice right now.",
            "People talk more honestly in places like this.",
            "The bar is lively today."
        },
        orderLines = {
            "One drink, please.",
            "What do you have today?",
            "I will wait here.",
            "Something warm would be nice."
        }
    },
    {
        name = "ramen",
        weight = 10,
        rects = {
            {from = Position(5820, 5140, 7), to = Position(5825, 5140, 7)}
        },
        seatIds = {
            [28555] = true,
            [28556] = true,
            [28557] = true,
            [28558] = true
        },
        tableIds = {
            [28551] = true,
            [28552] = true,
            [28553] = true,
            [28554] = true
        },
        lines = {
            "Now that smells good.",
            "Ramen always draws a crowd.",
            "I could stay here for a while.",
            "A hot bowl would be perfect right now."
        },
        forceLookDir = NORTH
    },
    {
        name = "cemetery",
        weight = 4,
        rects = {
            {from = Position(5954, 5107, 7), to = Position(5982, 5123, 7)},
            {from = Position(5973, 5127, 7), to = Position(5982, 5139, 7)}
        },
        lines = {
            "May they rest in peace.",
            "This place always quiets the mind.",
            "Some places make you speak softer.",
            "It is good to remember those who came before us."
        },
        silentChance = 70
    },
    {
        name = "church",
        weight = 5,
        rects = {
            {from = Position(5989, 5113, 7), to = Position(5998, 5121, 7)}
        },
        seatIds = {
            [27828] = true,
            [27829] = true
        },
        seatDirections = {
            [27933] = SOUTH,
            [27934] = WEST,
            [27935] = NORTH,
            [27936] = EAST
        },
        lines = {
            "May peace stay with this village.",
            "A quiet moment is never wasted.",
            "Some silence does the soul good.",
            "I should stay calm and grateful."
        }
    },
    {
        name = "park",
        weight = 10,
        rects = {
            {from = Position(5870, 5037, 7), to = Position(5905, 5047, 7)},
            {from = Position(5887, 5051, 7), to = Position(5912, 5067, 7)}
        },
        lines = {
            "It is pleasant here.",
            "The park feels calmer than the market.",
            "Fresh air does wonders.",
            "I should come here more often."
        }
    },
    {
        name = "restaurant",
        weight = 8,
        rects = {
            {from = Position(5867, 5056, 7), to = Position(5875, 5066, 7)}
        },
        seatIds = {
            [28555] = true,
            [28556] = true,
            [28557] = true,
            [28558] = true
        },
        tableIds = {
            [28551] = true,
            [28552] = true,
            [28553] = true,
            [28554] = true
        },
        lines = {
            "The food here smells incredible.",
            "This place is always tempting.",
            "Not bad. Not bad at all.",
            "I could stay for a meal."
        }
    },
    {
        name = "restaurant_patio",
        weight = 7,
        rects = {
            {from = Position(5878, 5056, 7), to = Position(5884, 5067, 7)}
        },
        seatIds = {
            [27933] = true,
            [27934] = true,
            [27935] = true,
            [27936] = true
        },
        seatDirections = {
            [27933] = SOUTH,
            [27934] = WEST,
            [27935] = NORTH,
            [27936] = EAST
        },
        lines = {
            "Eating outside has its charm.",
            "This patio is nicer than I expected.",
            "A peaceful place to sit for a while.",
            "Not a bad place to relax."
        }
    },
    {
        name = "academy_students",
        weight = 4,
        rects = {
            {from = Position(5616, 5003, 7), to = Position(5656, 5036, 7)}
        },
        lines = {
            "The academy is always full of energy.",
            "So many young voices around here.",
            "Everyone starts somewhere.",
            "The students seem lively today."
        }
    },
    {
        name = "cafe",
        weight = 8,
        rects = {
            {from = Position(5580, 5053, 7), to = Position(5585, 5060, 7)}
        },
        seatIds = {
            [28462] = true
        },
        tableIds = {
            [28532] = true,
            [28533] = true,
            [28534] = true,
            [28535] = true
        },
        lines = {
            "A cup of coffee sounds perfect.",
            "This cafe smells wonderful.",
            "I could sit here all afternoon.",
            "Quiet places like this are rare."
        }
    },
    {
        name = "cafe_patio",
        weight = 7,
        rects = {
            {from = Position(5573, 5069, 7), to = Position(5576, 5073, 7)}
        },
        seatIds = {
            [27933] = true,
            [27934] = true,
            [27935] = true,
            [27936] = true
        },
        tableIds = {
            [28344] = true
        },
        seatDirections = {
            [27933] = NORTH,
            [27934] = EAST,
            [27935] = SOUTH,
            [27936] = EAST
        },
        lines = {
            "This patio is cozy.",
            "It is nice to sit outside for a while.",
            "A calm corner like this is valuable.",
            "Not too noisy. I like that."
        }
    },
    {
        name = "police",
        weight = 3,
        rects = {
            {from = Position(6006, 5173, 7), to = Position(6019, 5175, 7)}
        },
        lines = {
            "Best not to cause trouble around here.",
            "The guards always look serious.",
            "Order must be kept, I suppose.",
            "This area feels stricter than the others."
        }
    },
    {
        name = "chess_watch",
        weight = 4,
        rects = {
            {from = Position(5902, 5245, 7), to = Position(5903, 5251, 7)}
        },
        lines = {
            "Interesting move.",
            "This game is getting serious.",
            "I wonder who is winning.",
            "One wrong move and it is over."
        },
        forceLookDir = EAST
    }
}

local zoneByName = {}
for i = 1, #zones do
    zoneByName[zones[i].name] = zones[i]
end

local function nowMs()
    if os.mtime then
        return os.mtime()
    end
    return os.time() * 1000
end

local function randMs(minValue, maxValue)
    return math.random(minValue, maxValue)
end

local function trim(str)
    return (str:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function copyPosition(pos)
    return Position(pos.x, pos.y, pos.z)
end

local function samePos(a, b)
    return a and b and a.x == b.x and a.y == b.y and a.z == b.z
end

local function posKey(pos)
    return pos.x .. ":" .. pos.y .. ":" .. pos.z
end

local function posToText(pos)
    if not pos then
        return "(nil)"
    end
    return "(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ")"
end

local function getNpcFullName(npc)
    if not npc or not npc.getName then
        return ""
    end
    return trim(npc:getName() or "")
end

local function isSpecialCitizenName(name)
    return name and SPECIAL_CITIZEN_NAMES[name] == true
end

local function debugProblem(npc, message)
    if not DEBUG_ENABLED or not npc then
        return
    end
    print("[CitizenError] " .. getNpcFullName(npc) .. " [" .. npc:getId() .. "] " .. message)
end

local function debugInfo(npc, message)
    if not DEBUG_ENABLED or not npc then
        return
    end
    print("[CitizenInfo] " .. getNpcFullName(npc) .. " [" .. npc:getId() .. "] " .. message)
end

local function getFirstName(name)
    if not name or name == "" then
        return "friend"
    end
    local first = name:match("^(%S+)")
    return first or name
end

local function getTodayInfo()
    local t = os.date("*t")
    local weekday = os.date("%A")
    local monthDay = string.format("%02d-%02d", t.month, t.day)
    local holiday = importantHolidayMap[monthDay]
    return weekday, holiday
end

local function resolveDynamicLine(line)
    local weekday, holiday = getTodayInfo()
    line = line:gsub("{weekday}", weekday)
    if holiday then
        line = line:gsub("{holiday}", holiday)
    else
        line = line:gsub("{holiday}", "the village season")
    end
    return line
end

local function formatDialogueToName(partnerName, line)
    local shortName = getFirstName(partnerName)
    if not line or line == "" then
        return shortName .. "."
    end

    local firstChar = line:sub(1, 1):upper()
    local rest = line:sub(2)
    return shortName .. ", " .. firstChar .. rest
end

local function formatLineToPlayer(line, playerName)
    return (line:gsub("{name}", playerName or "friend"))
end

local function getDirectionTo(fromPos, toPos)
    local dx = toPos.x - fromPos.x
    local dy = toPos.y - fromPos.y

    if math.abs(dx) > math.abs(dy) then
        if dx > 0 then
            return EAST
        else
            return WEST
        end
    else
        if dy > 0 then
            return SOUTH
        else
            return NORTH
        end
    end
end

local function getPosByDir(pos, dir)
    local p = Position(pos.x, pos.y, pos.z)
    if dir == NORTH then
        p.y = p.y - 1
    elseif dir == SOUTH then
        p.y = p.y + 1
    elseif dir == EAST then
        p.x = p.x + 1
    elseif dir == WEST then
        p.x = p.x - 1
    end
    return p
end

local function getDirectionBetweenAdjacent(fromPos, toPos)
    if toPos.x > fromPos.x then
        return EAST
    elseif toPos.x < fromPos.x then
        return WEST
    elseif toPos.y > fromPos.y then
        return SOUTH
    elseif toPos.y < fromPos.y then
        return NORTH
    end
    return nil
end

local function getManhattanDistance(a, b)
    return math.abs(a.x - b.x) + math.abs(a.y - b.y)
end

local function areFaceToFace(aPos, bPos)
    return getManhattanDistance(aPos, bPos) == 1 and aPos.z == bPos.z
end

local function getTileGroundId(tile)
    if not tile then
        return nil
    end
    local ground = tile:getGround()
    if not ground then
        return nil
    end
    return ground:getId()
end

local function tileHasForbiddenItems(tile)
    if not tile then
        return false
    end

    local items = tile:getItems()
    if not items then
        return false
    end

    for i = 1, #items do
        local item = items[i]
        if FORBIDDEN_ITEM_IDS[item:getId()] then
            return true
        end
    end

    return false
end

local function tileHasAnyItemId(tile, itemIdMap)
    if not tile or not itemIdMap then
        return false, nil
    end

    local ground = tile:getGround()
    if ground and itemIdMap[ground:getId()] then
        return true, ground:getId()
    end

    local items = tile:getItems()
    if not items then
        return false, nil
    end

    for i = 1, #items do
        local item = items[i]
        local itemId = item:getId()
        if itemIdMap[itemId] then
            return true, itemId
        end
    end

    return false, nil
end

local function tileIsSeatForZone(tile, zone)
    if not tile or not zone or not zone.seatIds then
        return false
    end

    local hasSeat = tileHasAnyItemId(tile, zone.seatIds)
    return hasSeat
end

local function findNearestTableDirection(pos, tableIds)
    if not pos or not tableIds then
        return nil
    end

    local checks = {
        {x = 0, y = -1, dir = NORTH},
        {x = 1, y = 0, dir = EAST},
        {x = 0, y = 1, dir = SOUTH},
        {x = -1, y = 0, dir = WEST}
    }

    for i = 1, #checks do
        local check = checks[i]
        local tile = Tile(Position(pos.x + check.x, pos.y + check.y, pos.z))
        local hasTable = tileHasAnyItemId(tile, tableIds)
        if hasTable then
            return check.dir
        end
    end

    return nil
end

local function tileHasBlockingWallLikeItems(tile)
    if not tile then
        return false
    end

    if tile.hasFlag then
        if tile:hasFlag(TILESTATE_BLOCKSOLID) or tile:hasFlag(TILESTATE_IMMOVABLEBLOCKSOLID) then
            return true
        end
    end

    local items = tile:getItems()
    if not items then
        return false
    end

    for i = 1, #items do
        local item = items[i]

        if item:getId() ~= CLOSED_DOOR_ID and item:getId() ~= OPEN_DOOR_ID then
            if item.hasProperty then
                if item:hasProperty(CONST_PROP_BLOCKSOLID) or item:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) then
                    return true
                end
            end
        end
    end

    return false
end

local function clearFailedTargets(state)
    state.failedSeatKeys = {}
    state.failedOrderKeys = {}
end

local function getGroundPreferenceScore(pos)
    local tile = Tile(pos)
    if not tile then
        return -999
    end

    local groundId = getTileGroundId(tile)
    if not groundId then
        return -999
    end

    return PREFERRED_GROUNDS[groundId] or -50
end

local function isPlayerInRange(player, npc)
    local playerPos = player:getPosition()
    local npcPos = npc:getPosition()

    if playerPos.z ~= npcPos.z then
        return false
    end

    local distance = math.max(
        math.abs(playerPos.x - npcPos.x),
        math.abs(playerPos.y - npcPos.y)
    )
    return distance <= maxDistance
end

local function getExpandedSmallTalk()
    local lines = {}

    for i = 1, #randomSmallTalk do
        lines[#lines + 1] = randomSmallTalk[i]
    end

    local weekday, holiday = getTodayInfo()
    local weekdayLines = weekdayTalkMap[weekday]
    if weekdayLines then
        for i = 1, #weekdayLines do
            lines[#lines + 1] = weekdayLines[i]
        end
    end

    if holiday and holidayTalkMap[holiday] then
        for i = 1, #holidayTalkMap[holiday] do
            lines[#lines + 1] = holidayTalkMap[holiday][i]
        end
    end

    for i = 1, #namedNpcMentions do
        lines[#lines + 1] = namedNpcMentions[i]
    end

    lines[#lines + 1] = "It is {weekday}. The village has its own pace today."
    lines[#lines + 1] = "A {weekday} in Konoha rarely stays dull for long."

    if holiday then
        lines[#lines + 1] = "{holiday} always changes the mood of the village."
        lines[#lines + 1] = "You can feel {holiday} in the streets today."
    end

    return lines
end

local function getZoneLines(zone)
    local expanded = getExpandedSmallTalk()
    if zone and zone.lines and #zone.lines > 0 then
        local merged = {}
        for i = 1, #zone.lines do
            merged[#merged + 1] = zone.lines[i]
        end
        for i = 1, #expanded do
            merged[#merged + 1] = expanded[i]
        end
        return merged
    end

    return expanded
end

local function sayRandomFromList(npc, list)
    if not list or #list == 0 then
        return
    end

    local line = resolveDynamicLine(list[math.random(1, #list)])
    npc:say(line, TALKTYPE_MONSTER_SAY)
end

local function facePlayer(player, npc)
    local dir = getDirectionTo(npc:getPosition(), player:getPosition())
    npc:setDirection(dir)
end

local function isCitizenNpc(creature)
    if not creature or not creature:isNpc() then
        return false
    end
    return states[creature:getId()] ~= nil
end

local function posInsideRect(pos, rect)
    return pos.x >= rect.from.x and pos.x <= rect.to.x
        and pos.y >= rect.from.y and pos.y <= rect.to.y
        and pos.z == rect.from.z
end

local function getZoneByName(name)
    return zoneByName[name]
end

local function isInsideBlockedRect(pos, zone)
    if not zone or not zone.blockedRects then
        return false
    end

    for i = 1, #zone.blockedRects do
        if posInsideRect(pos, zone.blockedRects[i]) then
            return true
        end
    end

    return false
end

local function tryOpenDoorAt(pos)
    local tile = Tile(pos)
    if not tile then
        return false
    end

    local door = tile:getItemById(CLOSED_DOOR_ID)
    if door then
        door:transform(OPEN_DOOR_ID)
        door:decay()
        return true
    end

    return false
end

local function isConnectorPos(pos)
    if not pos or not CONNECTOR_POSITIONS then
        return false
    end

    for _, connectorPos in pairs(CONNECTOR_POSITIONS) do
        if connectorPos and samePos(pos, connectorPos) then
            return true
        end
    end

    return false
end

local function isWalkableForNpc(pos, npc, zone)
    if not pos then
        return false
    end

    local tile = Tile(pos)
    if not tile then
        return false
    end

    local groundId = getTileGroundId(tile)
    if not groundId or groundId == WATER_GROUND_ID then
        return false
    end

    if tileHasForbiddenItems(tile) then
        return false
    end

    if isInsideBlockedRect(pos, zone) then
        return false
    end

    local topCreature = tile:getTopCreature()
    if topCreature and topCreature:getId() ~= npc:getId() then
        return false
    end

    local isSeatTile = tileIsSeatForZone(tile, zone)

    if tile.queryAdd and tile:queryAdd(npc) ~= RETURNVALUE_NOERROR then
        if isSeatTile or isConnectorPos(pos) then
            return true
        end

        local opened = tryOpenDoorAt(pos)
        if opened then
            local tileAfter = Tile(pos)
            if tileAfter and tileAfter.queryAdd and tileAfter:queryAdd(npc) == RETURNVALUE_NOERROR then
                return true
            end
        end
        return false
    end

    return true
end

local function isSafeRecoveryTile(pos)
    if not pos or pos.z ~= 7 then
        return false
    end

    local tile = Tile(pos)
    if not tile then
        return false
    end

    local groundId = getTileGroundId(tile)
    if not groundId or groundId == WATER_GROUND_ID then
        return false
    end

    if tileHasForbiddenItems(tile) then
        return false
    end

    if tileHasBlockingWallLikeItems(tile) then
        return false
    end

    local topCreature = tile:getTopCreature()
    if topCreature then
        return false
    end

    return true
end

local function findMarketRecoveryPosition()
    local candidates = {}

    for r = 1, #MARKET_RECOVERY_RECTS do
        local rect = MARKET_RECOVERY_RECTS[r]
        for x = rect.from.x, rect.to.x do
            for y = rect.from.y, rect.to.y do
                local pos = Position(x, y, rect.from.z)
                if isSafeRecoveryTile(pos) then
                    candidates[#candidates + 1] = pos
                end
            end
        end
    end

    if #candidates == 0 then
        return nil
    end

    return candidates[math.random(1, #candidates)]
end

local function recoverNpcToSafeArea(npc, state, reason)
    local safePos = findMarketRecoveryPosition()
    if not safePos then
        debugProblem(npc, "recovery failed - no market tile found (" .. tostring(reason) .. ")")
        return false
    end

    npc:teleportTo(safePos)
    state.lastPos = copyPosition(safePos)
    state.lastMoveAt = nowMs()
    state.stuckCounter = 0
    state.hardStuckCounter = 0
    state.targetFailCount = 0
    state.nextStepAt = 0
    state.visitUntil = 0
    state.seatUntil = 0
    debugProblem(npc, "teleported to market because " .. tostring(reason) .. " -> " .. posToText(safePos))
    resetToIdle(npc, state, nowMs())
    return true
end

local function chooseWeightedZone()
    local total = 0

    for i = 1, #zones do
        total = total + (zones[i].weight or 1)
    end

    local roll = math.random(1, total)
    local acc = 0

    for i = 1, #zones do
        acc = acc + (zones[i].weight or 1)
        if roll <= acc then
            return zones[i]
        end
    end

    return zones[1]
end

local function getRandomPosInRect(rect)
    return Position(
        math.random(rect.from.x, rect.to.x),
        math.random(rect.from.y, rect.to.y),
        rect.from.z
    )
end

local function getRandomWalkablePosInZone(zone, npc, attempts)
    attempts = attempts or 60

    local bestPos = nil
    local bestScore = -999999

    for i = 1, attempts do
        local rect = zone.rects[math.random(1, #zone.rects)]
        local pos = getRandomPosInRect(rect)

        if not isConnectorPos(pos) and isWalkableForNpc(pos, npc, zone) then
            local score = getGroundPreferenceScore(pos)
            if score > bestScore then
                bestScore = score
                bestPos = pos

                if score >= 10 then
                    return pos
                end
            end
        end
    end

    return bestPos
end

local function getRandomWalkablePosInSpecialRect(rect, npc, zone, attempts)
    attempts = attempts or 35

    local bestPos = nil
    local bestScore = -999999

    for i = 1, attempts do
        local pos = getRandomPosInRect(rect)
        if not isConnectorPos(pos) and isWalkableForNpc(pos, npc, zone) then
            local score = getGroundPreferenceScore(pos)
            if score > bestScore then
                bestScore = score
                bestPos = pos
            end
        end
    end

    return bestPos
end

local function getStreetAxisForRect(rect)
    local width = rect.to.x - rect.from.x
    local height = rect.to.y - rect.from.y

    if width >= height then
        return "horizontal"
    end
    return "vertical"
end

local function getStreetRectsContaining(pos)
    local result = {}
    for i = 1, #MAIN_STREET_RECTS do
        if posInsideRect(pos, MAIN_STREET_RECTS[i]) then
            result[#result + 1] = MAIN_STREET_RECTS[i]
        end
    end
    return result
end

local function getRandomWalkableMainStreetPos(npc, attemptsPerRect)
    attemptsPerRect = attemptsPerRect or 40

    local candidates = {}

    for i = 1, #MAIN_STREET_RECTS do
        local pos = getRandomWalkablePosInSpecialRect(MAIN_STREET_RECTS[i], npc, nil, attemptsPerRect)
        if pos then
            candidates[#candidates + 1] = pos
        end
    end

    if #candidates == 0 then
        return nil
    end

    return candidates[math.random(1, #candidates)]
end

local function isStreetPreferredGround(pos)
    local tile = Tile(pos)
    if not tile then
        return false
    end

    local groundId = getTileGroundId(tile)
    return groundId == 28160 or groundId == 26414
end

local function isWalkableStreetTile(pos, npc)
    if not pos then
        return false
    end

    if not isStreetPreferredGround(pos) then
        return false
    end

    if not isWalkableForNpc(pos, npc, nil) then
        return false
    end

    local rects = getStreetRectsContaining(pos)
    return #rects > 0
end

local function getStreetStepPos(pos, axis, dir)
    if not pos or not axis or not dir then
        return nil
    end

    local nextPos = Position(pos.x, pos.y, pos.z)

    if axis == "vertical" then
        if dir == NORTH then
            nextPos.y = nextPos.y - 1
        elseif dir == SOUTH then
            nextPos.y = nextPos.y + 1
        else
            return nil
        end
    elseif axis == "horizontal" then
        if dir == EAST then
            nextPos.x = nextPos.x + 1
        elseif dir == WEST then
            nextPos.x = nextPos.x - 1
        else
            return nil
        end
    else
        return nil
    end

    return nextPos
end

local function getOppositeStreetDir(dir)
    if dir == NORTH then
        return SOUTH
    elseif dir == SOUTH then
        return NORTH
    elseif dir == EAST then
        return WEST
    elseif dir == WEST then
        return EAST
    end
    return nil
end

local function chooseStreetRoamTarget(npc, state)
    local currentPos = npc:getPosition()
    local rects = getStreetRectsContaining(currentPos)

    if #rects == 0 then
        local fallback = getRandomWalkableMainStreetPos(npc, 60)
        if fallback then
            local fallbackRects = getStreetRectsContaining(fallback)
            local fallbackRect = fallbackRects[math.random(1, #fallbackRects)]
            local axis = getStreetAxisForRect(fallbackRect)
            state.streetAxis = axis
            if axis == "vertical" then
                state.streetDir = math.random(1, 2) == 1 and NORTH or SOUTH
            else
                state.streetDir = math.random(1, 2) == 1 and EAST or WEST
            end
        end
        return fallback
    end

    local rect = rects[math.random(1, #rects)]
    local axis = getStreetAxisForRect(rect)
    state.streetAxis = axis

    if axis == "vertical" then
        if not state.streetDir or (state.streetDir ~= NORTH and state.streetDir ~= SOUTH) then
            state.streetDir = math.random(1, 2) == 1 and NORTH or SOUTH
        elseif math.random(1, 100) <= STREET_ROAM_TURN_CHANCE then
            state.streetDir = getOppositeStreetDir(state.streetDir)
        end
    else
        if not state.streetDir or (state.streetDir ~= EAST and state.streetDir ~= WEST) then
            state.streetDir = math.random(1, 2) == 1 and EAST or WEST
        elseif math.random(1, 100) <= STREET_ROAM_TURN_CHANCE then
            state.streetDir = getOppositeStreetDir(state.streetDir)
        end
    end

    local steps = math.random(STREET_ROAM_MIN_STEPS, STREET_ROAM_MAX_STEPS)
    local cursor = Position(currentPos.x, currentPos.y, currentPos.z)
    local lastValid = nil

    for _ = 1, steps do
        local nextPos = getStreetStepPos(cursor, axis, state.streetDir)
        if not nextPos or not posInsideRect(nextPos, rect) or not isWalkableStreetTile(nextPos, npc) then
            break
        end

        lastValid = Position(nextPos.x, nextPos.y, nextPos.z)
        cursor = nextPos
    end

    if lastValid then
        return lastValid
    end

    local oppositeDir = getOppositeStreetDir(state.streetDir)
    if oppositeDir then
        state.streetDir = oppositeDir
    end

    cursor = Position(currentPos.x, currentPos.y, currentPos.z)
    lastValid = nil

    for _ = 1, steps do
        local nextPos = getStreetStepPos(cursor, axis, state.streetDir)
        if not nextPos or not posInsideRect(nextPos, rect) or not isWalkableStreetTile(nextPos, npc) then
            break
        end

        lastValid = Position(nextPos.x, nextPos.y, nextPos.z)
        cursor = nextPos
    end

    return lastValid
end

local function isTargetCloseEnough(fromPos, toPos)
    if not fromPos or not toPos or fromPos.z ~= toPos.z then
        return false
    end

    local dx = math.abs(fromPos.x - toPos.x)
    local dy = math.abs(fromPos.y - toPos.y)
    return math.max(dx, dy) <= MAX_TARGET_DISTANCE
end

local function getLocalRoamPos(npc, attempts)
    attempts = attempts or 30

    local npcPos = npc:getPosition()
    local bestPos = nil
    local bestScore = -999999

    for i = 1, attempts do
        local pos = Position(
            math.random(npcPos.x - LOCAL_ROAM_RADIUS, npcPos.x + LOCAL_ROAM_RADIUS),
            math.random(npcPos.y - LOCAL_ROAM_RADIUS, npcPos.y + LOCAL_ROAM_RADIUS),
            npcPos.z
        )

        if not isConnectorPos(pos) and isWalkableForNpc(pos, npc, nil) then
            local score = getGroundPreferenceScore(pos)
            if score > bestScore then
                bestScore = score
                bestPos = pos
            end
        end
    end

    return bestPos
end

local function getConnectorForZone(zoneName)
    if not CONNECTOR_POSITIONS then
        return nil
    end

    if zoneName == "bar" then
        return CONNECTOR_POSITIONS.bar
    elseif zoneName == "restaurant" or zoneName == "restaurant_patio" then
        return CONNECTOR_POSITIONS.restaurant
    elseif zoneName == "cemetery" then
        return CONNECTOR_POSITIONS.cemetery
    end

    return nil
end

local function findNearestStairExitOnLevel(npc, attemptsRadius)
    local npcPos = npc:getPosition()
    local bestPos = nil
    local bestDist = nil
    local radius = attemptsRadius or 20

    for x = npcPos.x - radius, npcPos.x + radius do
        for y = npcPos.y - radius, npcPos.y + radius do
            local pos = Position(x, y, npcPos.z)
            local tile = Tile(pos)
            if tile then
                local hasExit = tile:getItemById(STAIR_EXIT_ITEM_ID)
                if hasExit and isWalkableForNpc(pos, npc, nil) then
                    local dist = math.abs(npcPos.x - x) + math.abs(npcPos.y - y)
                    if not bestDist or dist < bestDist then
                        bestDist = dist
                        bestPos = pos
                    end
                end
            end
        end
    end

    return bestPos
end

local function getStateById(npcId, npc)
    if not states[npcId] then
        states[npcId] = {
            running = false,
            mode = "idle",
            targetPos = nil,
            targetZone = nil,
            targetKind = nil,
            nextStepAt = 0,
            nextActionAt = 0,
            nextSpeechAt = 0,
            nextTalkTryAt = 0,
            talkCooldownUntil = 0,
            seatUntil = 0,
            visitUntil = 0,
            faceDir = nil,
            partnerId = nil,
            partnerName = nil,
            dialogLines = nil,
            dialogIndex = 1,
            role = nil,
            stuckCounter = 0,
            hardStuckCounter = 0,
            targetFailCount = 0,
            lastPos = npc and copyPosition(npc:getPosition()) or nil,
            lastMoveAt = npc and nowMs() or 0,
            cachedPath = nil,
            cachedPathIndex = 1,
            pathBuiltAt = 0,
            nextPlayerNoticeAt = 0,
            nextRoamPulseAt = 0,
            nextSelfTalkAt = 0,
            failedSeatKeys = {},
            failedOrderKeys = {},
            streetAxis = nil,
            streetDir = nil,
            pendingZoneName = nil,
            pendingFinalPos = nil,
            pendingFinalKind = nil,
            pendingFaceDir = nil
        }
    end
    return states[npcId]
end

local function getState(npc)
    return getStateById(npc:getId(), npc)
end

local function clearStateById(npcId)
    states[npcId] = nil
end

local function clearState(npc)
    states[npc:getId()] = nil
end

local function tryNoticeNearbyPlayer(npc, state, tickNow)
    if tickNow < state.nextPlayerNoticeAt then
        return false
    end

    state.nextPlayerNoticeAt = tickNow + randMs(PLAYER_NOTICE_COOLDOWN_MIN, PLAYER_NOTICE_COOLDOWN_MAX)

    if math.random(1, 100) > PLAYER_NOTICE_CHANCE then
        return false
    end

    local npcPos = npc:getPosition()
    local spectators = Game.getSpectators(npcPos, false, true, PLAYER_NOTICE_RANGE, PLAYER_NOTICE_RANGE, PLAYER_NOTICE_RANGE, PLAYER_NOTICE_RANGE)
    if not spectators or #spectators == 0 then
        return false
    end

    local candidates = {}

    for i = 1, #spectators do
        local player = spectators[i]
        if player and player:isPlayer() then
            local playerPos = player:getPosition()
            if playerPos.z == npcPos.z then
                candidates[#candidates + 1] = player
            end
        end
    end

    if #candidates == 0 then
        return false
    end

    local player = candidates[math.random(1, #candidates)]
    npc:setDirection(getDirectionTo(npc:getPosition(), player:getPosition()))
    npc:say(formatLineToPlayer(playerNoticeLines[math.random(1, #playerNoticeLines)], player:getName()), TALKTYPE_MONSTER_SAY)
    return true
end

resetToIdle = function(npc, state, tickNow)
    tickNow = tickNow or nowMs()

    state.mode = "idle"
    state.targetPos = nil
    state.targetZone = nil
    state.targetKind = nil
    state.faceDir = nil
    state.streetAxis = nil
    state.streetDir = nil
    state.partnerId = nil
    state.partnerName = nil
    state.dialogLines = nil
    state.dialogIndex = 1
    state.role = nil
    state.visitUntil = 0
    state.seatUntil = 0
    state.cachedPath = nil
    state.cachedPathIndex = 1
    state.pathBuiltAt = 0
    state.pendingZoneName = nil
    state.pendingFinalPos = nil
    state.pendingFinalKind = nil
    state.pendingFaceDir = nil
    state.nextActionAt = tickNow + randMs(IDLE_MIN, IDLE_MAX)
    state.nextTalkTryAt = tickNow + randMs(TALK_TRY_MIN, TALK_TRY_MAX)
    state.nextRoamPulseAt = tickNow + randMs(ROAM_PULSE_MIN, ROAM_PULSE_MAX)
    state.nextSelfTalkAt = tickNow + randMs(SELF_TALK_MIN, SELF_TALK_MAX)
    clearFailedTargets(state)
end

local function findSeatInZone(zone, npc, excludePos, state)
    if not zone or not zone.seatIds then
        return nil, nil
    end

    local candidates = {}

    for r = 1, #zone.rects do
        local rect = zone.rects[r]
        for x = rect.from.x, rect.to.x do
            for y = rect.from.y, rect.to.y do
                local pos = Position(x, y, rect.from.z)
                local key = posKey(pos)

                if not isConnectorPos(pos)
                    and not (excludePos and samePos(pos, excludePos))
                    and not (state and state.failedSeatKeys and state.failedSeatKeys[key])
                then
                    local tile = Tile(pos)
                    local hasSeat, seatId = tileHasAnyItemId(tile, zone.seatIds)

                    if hasSeat and isWalkableForNpc(pos, npc, zone) then
                        local dir = nil

                        if zone.seatDirections and zone.seatDirections[seatId] then
                            dir = zone.seatDirections[seatId]
                        elseif zone.tableIds then
                            dir = findNearestTableDirection(pos, zone.tableIds)
                        elseif zone.forceLookDir then
                            dir = zone.forceLookDir
                        end

                        local score = getGroundPreferenceScore(pos)
                        local weight = math.max(1, score + 6)

                        candidates[#candidates + 1] = {
                            pos = pos,
                            dir = dir,
                            weight = weight
                        }
                    end
                end
            end
        end
    end

    if #candidates == 0 then
        return nil, nil
    end

    local totalWeight = 0
    for i = 1, #candidates do
        totalWeight = totalWeight + candidates[i].weight
    end

    local roll = math.random(1, totalWeight)
    local acc = 0

    for i = 1, #candidates do
        acc = acc + candidates[i].weight
        if roll <= acc then
            return candidates[i].pos, candidates[i].dir
        end
    end

    return candidates[#candidates].pos, candidates[#candidates].dir
end

local function findOrderSpotInZone(zone, npc, excludePos, state)
    if not zone or not zone.orderSpots then
        return nil, nil
    end

    local bestPos = nil
    local bestDir = nil
    local bestScore = -999999

    for i = 1, #zone.orderSpots do
        local spot = zone.orderSpots[i]
        local pos = getRandomWalkablePosInSpecialRect({from = spot.from, to = spot.to}, npc, zone, 25)

        if pos then
            local key = posKey(pos)
            if not isConnectorPos(pos)
                and not (excludePos and samePos(pos, excludePos))
                and not (state and state.failedOrderKeys and state.failedOrderKeys[key])
            then
                local score = getGroundPreferenceScore(pos)
                if score > bestScore then
                    bestScore = score
                    bestPos = pos
                    bestDir = spot.faceDir
                end
            end
        end
    end

    return bestPos, bestDir
end

local function getPreferredDirectionsToward(fromPos, targetPos)
    local dx = targetPos.x - fromPos.x
    local dy = targetPos.y - fromPos.y

    if math.abs(dx) >= math.abs(dy) then
        if dx >= 0 then
            if dy >= 0 then
                return {EAST, SOUTH, NORTH, WEST}
            else
                return {EAST, NORTH, SOUTH, WEST}
            end
        else
            if dy >= 0 then
                return {WEST, SOUTH, NORTH, EAST}
            else
                return {WEST, NORTH, SOUTH, EAST}
            end
        end
    else
        if dy >= 0 then
            if dx >= 0 then
                return {SOUTH, EAST, WEST, NORTH}
            else
                return {SOUTH, WEST, EAST, NORTH}
            end
        else
            if dx >= 0 then
                return {NORTH, EAST, WEST, SOUTH}
            else
                return {NORTH, WEST, EAST, SOUTH}
            end
        end
    end
end

local function buildPath(npc, startPos, targetPos, zone)
    if samePos(startPos, targetPos) then
        return {copyPosition(startPos)}
    end

    local startKey = posKey(startPos)
    local targetKey = posKey(targetPos)

    local minX = math.min(startPos.x, targetPos.x) - PATH_MARGIN
    local maxX = math.max(startPos.x, targetPos.x) + PATH_MARGIN
    local minY = math.min(startPos.y, targetPos.y) - PATH_MARGIN
    local maxY = math.max(startPos.y, targetPos.y) + PATH_MARGIN
    local z = startPos.z

    local queue = {copyPosition(startPos)}
    local queueIndex = 1

    local visited = {}
    local parent = {}
    local nodesVisited = 0

    visited[startKey] = true

    while queueIndex <= #queue and nodesVisited < PATH_MAX_NODES do
        local current = queue[queueIndex]
        queueIndex = queueIndex + 1
        nodesVisited = nodesVisited + 1

        local orderedDirs = getPreferredDirectionsToward(current, targetPos)

        for i = 1, 4 do
            local nextPos = getPosByDir(current, orderedDirs[i])

            if nextPos.z == z
                and nextPos.x >= minX and nextPos.x <= maxX
                and nextPos.y >= minY and nextPos.y <= maxY
            then
                local nextKey = posKey(nextPos)

                if not visited[nextKey] and (samePos(nextPos, targetPos) or isWalkableForNpc(nextPos, npc, zone)) then
                    visited[nextKey] = true
                    parent[nextKey] = current

                    if nextKey == targetKey then
                        local path = {copyPosition(targetPos)}
                        local backPos = parent[nextKey]

                        while backPos do
                            table.insert(path, 1, copyPosition(backPos))
                            backPos = parent[posKey(backPos)]
                        end

                        return path
                    end

                    queue[#queue + 1] = copyPosition(nextPos)
                end
            end
        end
    end

    return nil
end

local function chooseDetourPath(npc, targetPos, zone)
    local npcPos = npc:getPosition()
    local bestPath = nil
    local bestScore = nil

    for x = npcPos.x - DETOUR_SEARCH_RADIUS, npcPos.x + DETOUR_SEARCH_RADIUS do
        for y = npcPos.y - DETOUR_SEARCH_RADIUS, npcPos.y + DETOUR_SEARCH_RADIUS do
            local detourPos = Position(x, y, npcPos.z)

            if not samePos(detourPos, npcPos) and isWalkableForNpc(detourPos, npc, zone) then
                local detourPath = buildPath(npc, npcPos, detourPos, zone)
                if detourPath and #detourPath > 1 then
                    local targetDist = math.abs(detourPos.x - targetPos.x) + math.abs(detourPos.y - targetPos.y)
                    local score = targetDist - (getGroundPreferenceScore(detourPos) * 0.2) + (#detourPath * 0.3)

                    if not bestScore or score < bestScore then
                        bestScore = score
                        bestPath = detourPath
                    end
                end
            end
        end
    end

    return bestPath
end

local function setMoveTarget(npc, state, zone, pos, kind)
    state.mode = "moving"
    state.targetZone = zone and zone.name or nil
    state.targetPos = pos
    state.targetKind = kind or "visit"
    state.faceDir = nil
    state.nextStepAt = 0
    state.nextActionAt = 0
    state.stuckCounter = 0
    state.cachedPath = nil
    state.cachedPathIndex = 1
    state.pathBuiltAt = 0
end

local function setConnectorTransit(state, zone, connectorPos, finalPos, finalKind, faceDir)
    state.targetZone = zone and zone.name or nil
    state.targetPos = connectorPos
    state.targetKind = "connector_pass"
    state.pendingZoneName = zone and zone.name or nil
    state.pendingFinalPos = finalPos and copyPosition(finalPos) or nil
    state.pendingFinalKind = finalKind
    state.pendingFaceDir = faceDir
end

local function incrementTargetFail(npc, state, tickNow, reason)
    state.targetFailCount = (state.targetFailCount or 0) + 1
    debugProblem(npc, "target fail " .. state.targetFailCount .. "/" .. TARGET_FAILS_BEFORE_CHANGE .. " because " .. tostring(reason))

    if state.targetFailCount >= TARGET_FAILS_BEFORE_CHANGE then
        state.targetFailCount = 0
        clearFailedTargets(state)
        chooseNewDestination(npc, state, tickNow)
        return true
    end

    return false
end

local function tryPickAlternativeTargetInSameZone(npc, state, zone, tickNow)
    if not zone then
        return false
    end

    if state.targetKind == "seat" then
        if state.targetPos then
            state.failedSeatKeys[posKey(state.targetPos)] = true
        end

        local seatPos, seatDir = findSeatInZone(zone, npc, state.targetPos, state)
        if seatPos then
            local path = buildPath(npc, npc:getPosition(), seatPos, zone)
            if path then
                state.targetPos = seatPos
                state.faceDir = seatDir or zone.forceLookDir
                state.cachedPath = path
                state.cachedPathIndex = 2
                state.pathBuiltAt = tickNow
                state.stuckCounter = 0
                return true
            else
                state.failedSeatKeys[posKey(seatPos)] = true
            end
        end

        debugProblem(npc, "no valid alternative seat in zone " .. tostring(zone.name))
    elseif state.targetKind == "order" then
        if state.targetPos then
            state.failedOrderKeys[posKey(state.targetPos)] = true
        end

        local orderPos, orderDir = findOrderSpotInZone(zone, npc, state.targetPos, state)
        if orderPos then
            local path = buildPath(npc, npc:getPosition(), orderPos, zone)
            if path then
                state.targetPos = orderPos
                state.faceDir = orderDir
                state.cachedPath = path
                state.cachedPathIndex = 2
                state.pathBuiltAt = tickNow
                state.stuckCounter = 0
                return true
            else
                state.failedOrderKeys[posKey(orderPos)] = true
            end
        end

        debugProblem(npc, "no valid alternative order spot in zone " .. tostring(zone.name))
    end

    return false
end

local function pickFinalDestinationInZone(npc, state, zone, npcPos, tickNow)
    if zone.orderSpots and math.random(1, 100) <= 35 then
        local orderPos, orderDir = findOrderSpotInZone(zone, npc, nil, state)
        if orderPos and isTargetCloseEnough(npcPos, orderPos) then
            local testPath = buildPath(npc, npcPos, orderPos, zone)
            if testPath then
                return orderPos, "order", orderDir, testPath
            end
        end
    end

    local seatPos, seatDir = findSeatInZone(zone, npc, nil, state)
    local wantSeat = seatPos and math.random(1, 100) <= 55

    if wantSeat and isTargetCloseEnough(npcPos, seatPos) then
        local testPath = buildPath(npc, npcPos, seatPos, zone)
        if testPath then
            return seatPos, "seat", seatDir, testPath
        end
    end

    local bestPos = nil
    local bestPath = nil
    local bestScore = -999999

    for i = 1, 10 do
        local pos = getRandomWalkablePosInZone(zone, npc, 20)
        if pos and isTargetCloseEnough(npcPos, pos) then
            local path = buildPath(npc, npcPos, pos, zone)
            if path then
                local score = getGroundPreferenceScore(pos) * 50 - #path
                if score > bestScore then
                    bestScore = score
                    bestPos = pos
                    bestPath = path
                end
            end
        end
    end

    if bestPos and bestPath then
        return bestPos, "visit", zone.forceLookDir, bestPath
    end

    return nil, nil, nil, nil
end

chooseNewDestination = function(npc, state, tickNow)
    local npcPos = npc:getPosition()
    clearFailedTargets(state)
    state.targetFailCount = 0
    state.pendingZoneName = nil
    state.pendingFinalPos = nil
    state.pendingFinalKind = nil
    state.pendingFaceDir = nil

    if npcPos.z ~= 7 then
        local stairPos = findNearestStairExitOnLevel(npc, 25)
        if stairPos then
            local stairPath = buildPath(npc, npcPos, stairPos, nil)
            if stairPath then
                setMoveTarget(npc, state, nil, stairPos, "visit")
                state.cachedPath = stairPath
                state.cachedPathIndex = 2
                state.pathBuiltAt = tickNow
                debugProblem(npc, "found stair exit on higher floor -> " .. posToText(stairPos))
                return
            end
        end

        debugProblem(npc, "on wrong floor and no stair exit path found")
        recoverNpcToSafeArea(npc, state, "wrong floor without exit")
        return
    end

    for attempt = 1, 8 do
        local zone = chooseWeightedZone()
        if zone then
            local finalPos, finalKind, finalFaceDir, finalPath = pickFinalDestinationInZone(npc, state, zone, npcPos, tickNow)
            if finalPos and finalPath then
                local connectorPos = getConnectorForZone(zone.name)

                if connectorPos
                    and not samePos(npcPos, connectorPos)
                    and not samePos(finalPos, connectorPos)
                    and isTargetCloseEnough(npcPos, connectorPos)
                then
                    local connectorPath = buildPath(npc, npcPos, connectorPos, zone)
                    if connectorPath then
                        setMoveTarget(npc, state, zone, connectorPos, "connector_pass")
                        state.pendingZoneName = zone.name
                        state.pendingFinalPos = copyPosition(finalPos)
                        state.pendingFinalKind = finalKind
                        state.pendingFaceDir = finalFaceDir
                        state.cachedPath = connectorPath
                        state.cachedPathIndex = 2
                        state.pathBuiltAt = tickNow
                        return
                    end
                end

                setMoveTarget(npc, state, zone, finalPos, finalKind)
                state.faceDir = finalFaceDir
                state.cachedPath = finalPath
                state.cachedPathIndex = 2
                state.pathBuiltAt = tickNow
                return
            end
        end
    end

    local mainStreetPos = getRandomWalkableMainStreetPos(npc, 50)
    if mainStreetPos then
        local mainStreetPath = buildPath(npc, npcPos, mainStreetPos, nil)
        if mainStreetPath then
            setMoveTarget(npc, state, nil, mainStreetPos, "street_roam")
            state.cachedPath = mainStreetPath
            state.cachedPathIndex = 2
            state.pathBuiltAt = tickNow

            local streetRects = getStreetRectsContaining(mainStreetPos)
            if #streetRects > 0 then
                state.streetAxis = getStreetAxisForRect(streetRects[1])
                if state.streetAxis == "vertical" then
                    state.streetDir = math.random(1, 2) == 1 and NORTH or SOUTH
                else
                    state.streetDir = math.random(1, 2) == 1 and EAST or WEST
                end
            end

            return
        end
    end

    local localPos = getLocalRoamPos(npc, 40)
    if localPos then
        local localPath = buildPath(npc, npcPos, localPos, nil)
        if localPath then
            setMoveTarget(npc, state, nil, localPos, "visit")
            state.cachedPath = localPath
            state.cachedPathIndex = 2
            state.pathBuiltAt = tickNow
            return
        end
    end

    debugProblem(npc, "failed to choose destination, back to idle")
    resetToIdle(npc, state, tickNow)
end

local function startCitizenConversation(npc, otherNpc, state, otherState, tickNow)
    local dialog = pairDialogues[math.random(1, #pairDialogues)]
    local myName = getNpcFullName(npc)
    local otherName = getNpcFullName(otherNpc)

    state.mode = "talking"
    state.partnerId = otherNpc:getId()
    state.partnerName = otherName
    state.dialogLines = dialog.a
    state.dialogIndex = 1
    state.role = "a"
    state.nextSpeechAt = tickNow + math.random(250, 700)
    state.talkCooldownUntil = tickNow + randMs(TALK_COOLDOWN_MIN, TALK_COOLDOWN_MAX)
    state.nextTalkTryAt = state.talkCooldownUntil
    state.cachedPath = nil
    state.cachedPathIndex = 1
    state.targetPos = nil
    state.targetZone = nil
    state.targetKind = nil
    state.pathBuiltAt = 0
    state.faceDir = nil
    state.stuckCounter = 0
    state.targetFailCount = 0
    state.nextStepAt = 0
    state.visitUntil = 0
    state.seatUntil = 0
    state.pendingZoneName = nil
    state.pendingFinalPos = nil
    state.pendingFinalKind = nil
    state.pendingFaceDir = nil
    clearFailedTargets(state)

    otherState.mode = "talking"
    otherState.partnerId = npc:getId()
    otherState.partnerName = myName
    otherState.dialogLines = dialog.b
    otherState.dialogIndex = 1
    otherState.role = "b"
    otherState.nextSpeechAt = tickNow + math.random(1200, 2000)
    otherState.talkCooldownUntil = tickNow + randMs(TALK_COOLDOWN_MIN, TALK_COOLDOWN_MAX)
    otherState.nextTalkTryAt = otherState.talkCooldownUntil
    otherState.cachedPath = nil
    otherState.cachedPathIndex = 1
    otherState.targetPos = nil
    otherState.targetZone = nil
    otherState.targetKind = nil
    otherState.pathBuiltAt = 0
    otherState.faceDir = nil
    otherState.stuckCounter = 0
    otherState.targetFailCount = 0
    otherState.nextStepAt = 0
    otherState.visitUntil = 0
    otherState.seatUntil = 0
    otherState.pendingZoneName = nil
    otherState.pendingFinalPos = nil
    otherState.pendingFinalKind = nil
    otherState.pendingFaceDir = nil
    clearFailedTargets(otherState)

    npc:setDirection(getDirectionTo(npc:getPosition(), otherNpc:getPosition()))
    otherNpc:setDirection(getDirectionTo(otherNpc:getPosition(), npc:getPosition()))

    debugInfo(npc, "started conversation with " .. otherName)
    debugInfo(otherNpc, "started conversation with " .. myName)
end

local function tryStartLocalConversation(npc, state, tickNow)
    if tickNow < state.talkCooldownUntil then
        return false
    end

    if tickNow < state.nextTalkTryAt then
        return false
    end

    if (tickNow - (state.lastMoveAt or 0)) < TALK_IDLE_REQUIRED_MS then
        return false
    end

    state.nextTalkTryAt = tickNow + randMs(TALK_TRY_MIN, TALK_TRY_MAX)

    local myName = getNpcFullName(npc)
    if not isSpecialCitizenName(myName) then
        return false
    end

    if math.random(1, 100) > TALK_START_CHANCE then
        return false
    end

    if math.random(1, 100) > SPECIAL_CITIZEN_TALK_CHANCE then
        return false
    end

    local npcPos = npc:getPosition()
    local spectators = Game.getSpectators(npcPos, false, false, TALK_SEARCH_RANGE, TALK_SEARCH_RANGE, TALK_SEARCH_RANGE, TALK_SEARCH_RANGE)
    if not spectators or #spectators == 0 then
        return false
    end

    local candidates = {}

    for i = 1, #spectators do
        local creature = spectators[i]
        if creature and creature:getId() ~= npc:getId() and isCitizenNpc(creature) then
            local otherState = states[creature:getId()]
            local otherName = getNpcFullName(creature)

            if otherState
                and otherName ~= ""
                and otherName ~= myName
                and isSpecialCitizenName(otherName)
                and otherState.mode ~= "talking"
                and tickNow >= (otherState.talkCooldownUntil or 0)
                and tickNow >= (otherState.nextTalkTryAt or 0)
            then
                local otherPos = creature:getPosition()
                local dist = math.max(math.abs(npcPos.x - otherPos.x), math.abs(npcPos.y - otherPos.y))

                if dist <= TALK_SEARCH_RANGE then
                    candidates[#candidates + 1] = {
                        npc = creature,
                        state = otherState,
                        dist = dist
                    }
                end
            end
        end
    end

    if #candidates == 0 then
        return false
    end

    table.sort(candidates, function(a, b)
        return a.dist < b.dist
    end)

    local pickCount = math.min(#candidates, 4)
    local picked = candidates[math.random(1, pickCount)]

    if picked and picked.npc and picked.state then
        startCitizenConversation(npc, picked.npc, state, picked.state, tickNow)
        return true
    end

    return false
end

local function tryMoveCloserFaceToFace(npc, partner, zone)
    local npcPos = npc:getPosition()
    local partnerPos = partner:getPosition()

    local candidatePositions = {
        Position(partnerPos.x + 1, partnerPos.y, partnerPos.z),
        Position(partnerPos.x - 1, partnerPos.y, partnerPos.z),
        Position(partnerPos.x, partnerPos.y + 1, partnerPos.z),
        Position(partnerPos.x, partnerPos.y - 1, partnerPos.z)
    }

    local bestPos = nil
    local bestPath = nil
    local bestLen = nil

    for i = 1, #candidatePositions do
        local pos = candidatePositions[i]
        if isWalkableForNpc(pos, npc, zone) then
            local path = buildPath(npc, npcPos, pos, zone)
            if path then
                local len = #path
                if not bestLen or len < bestLen then
                    bestLen = len
                    bestPos = pos
                    bestPath = path
                end
            end
        end
    end

    if bestPos and bestPath and bestPath[2] then
        local nextPos = bestPath[2]
        local dir = getDirectionBetweenAdjacent(npcPos, nextPos)
        if dir and isWalkableForNpc(nextPos, npc, zone) then
            tryOpenDoorAt(nextPos)
            doMoveCreature(npc:getId(), dir)
            return true
        end
    end

    local preferredDirs = getPreferredDirectionsToward(npcPos, partnerPos)
    for i = 1, 4 do
        local dir = preferredDirs[i]
        local nextPos = getPosByDir(npcPos, dir)
        if isWalkableForNpc(nextPos, npc, zone) then
            tryOpenDoorAt(nextPos)
            doMoveCreature(npc:getId(), dir)
            return true
        end
    end

    return false
end

local function handleTalking(npc, state, tickNow)
    local partner = state.partnerId and Creature(state.partnerId) or nil
    if not partner or not isCitizenNpc(partner) then
        debugProblem(npc, "conversation ended - missing partner")
        resetToIdle(npc, state, tickNow)
        return
    end

    local partnerState = states[partner:getId()]
    if not partnerState or partnerState.partnerId ~= npc:getId() then
        debugProblem(npc, "conversation ended - partner state mismatch")
        resetToIdle(npc, state, tickNow)
        return
    end

    local npcPos = npc:getPosition()
    local partnerPos = partner:getPosition()

    if not areFaceToFace(npcPos, partnerPos) then
        if state.role == "a" then
            if tickNow >= state.nextStepAt then
                local moved = tryMoveCloserFaceToFace(npc, partner, nil)
                state.nextStepAt = tickNow + randMs(STEP_INTERVAL_MIN, STEP_INTERVAL_MAX)

                if moved then
                    state.lastMoveAt = tickNow
                    return
                end

                debugProblem(npc, "conversation approach failed, reset")
                resetToIdle(npc, state, tickNow)
                resetToIdle(partner, partnerState, tickNow)
                return
            end
        else
            npc:setDirection(getDirectionTo(npcPos, partnerPos))
        end
        return
    end

    npc:setDirection(getDirectionTo(npcPos, partnerPos))

    if not state.dialogLines or state.dialogIndex > #state.dialogLines then
        resetToIdle(npc, state, tickNow)
        return
    end

    if tickNow >= state.nextSpeechAt then
        local rawLine = state.dialogLines[state.dialogIndex]
        local finalLine = resolveDynamicLine(formatDialogueToName(state.partnerName, rawLine))
        npc:say(finalLine, TALKTYPE_MONSTER_SAY)
        state.dialogIndex = state.dialogIndex + 1
        state.nextSpeechAt = tickNow + math.random(1700, 2900)

        if state.dialogIndex > #state.dialogLines then
            state.nextActionAt = tickNow + math.random(900, 1800)
        end
    elseif state.dialogIndex > #state.dialogLines and tickNow >= state.nextActionAt then
        resetToIdle(npc, state, tickNow)
    end
end

local function handleArrivedInZone(npc, state, zone, tickNow)
    state.targetFailCount = 0

    if state.targetKind == "connector_pass" then
        local pendingZone = state.pendingZoneName and getZoneByName(state.pendingZoneName) or zone
        local pendingPos = state.pendingFinalPos
        local pendingKind = state.pendingFinalKind or "visit"
        local pendingFaceDir = state.pendingFaceDir

        state.pendingZoneName = nil
        state.pendingFinalPos = nil
        state.pendingFinalKind = nil
        state.pendingFaceDir = nil

        if pendingZone and pendingPos then
            local nextPath = buildPath(npc, npc:getPosition(), pendingPos, pendingZone)
            if nextPath then
                setMoveTarget(npc, state, pendingZone, pendingPos, pendingKind)
                state.faceDir = pendingFaceDir
                state.cachedPath = nextPath
                state.cachedPathIndex = 2
                state.pathBuiltAt = tickNow
                debugInfo(npc, "passed connector and continues to " .. tostring(pendingZone.name) .. " " .. posToText(pendingPos))
                return
            end
        end

        chooseNewDestination(npc, state, tickNow)
        return
    end

    if state.targetKind == "street_roam" then
        if math.random(1, 100) <= STREET_VISIT_CHANCE then
            chooseNewDestination(npc, state, tickNow)
            return
        end

        local streetTarget = chooseStreetRoamTarget(npc, state)
        if streetTarget and not samePos(streetTarget, npc:getPosition()) then
            local streetPath = buildPath(npc, npc:getPosition(), streetTarget, nil)
            if streetPath then
                setMoveTarget(npc, state, nil, streetTarget, "street_roam")
                state.cachedPath = streetPath
                state.cachedPathIndex = 2
                state.pathBuiltAt = tickNow
                return
            end
        end

        state.mode = "visiting"
        state.visitUntil = tickNow + math.random(2000, 5000)
        state.nextSpeechAt = tickNow + math.random(4000, 8000)

        if state.streetDir then
            npc:setDirection(state.streetDir)
        end
        return
    end

    if state.targetKind == "seat" then
        if not isWalkableForNpc(npc:getPosition(), npc, zone) then
            if tryPickAlternativeTargetInSameZone(npc, state, zone, tickNow) then
                state.mode = "moving"
                return
            end

            if incrementTargetFail(npc, state, tickNow, "invalid seat on arrival") then
                return
            end

            debugProblem(npc, "arrival seat invalid, reset")
            resetToIdle(npc, state, tickNow)
            return
        end

        state.mode = "seated"
        state.seatUntil = tickNow + randMs(SIT_MIN, SIT_MAX)
        state.nextSpeechAt = tickNow + math.random(3000, 9000)

        local finalSeatDir = nil

        if zone and zone.tableIds then
            finalSeatDir = findNearestTableDirection(npc:getPosition(), zone.tableIds)
        end

        if not finalSeatDir and state.faceDir then
            finalSeatDir = state.faceDir
        end

        if not finalSeatDir and zone and zone.forceLookDir then
            finalSeatDir = zone.forceLookDir
        end

        if finalSeatDir then
            npc:setDirection(finalSeatDir)
            state.faceDir = finalSeatDir
        end
        return
    end

    if state.targetKind == "order" then
        state.mode = "visiting"
        state.visitUntil = tickNow + math.random(5000, 12000)
        state.nextSpeechAt = tickNow + math.random(800, 2400)

        if state.faceDir then
            npc:setDirection(state.faceDir)
        end

        return
    end

    state.mode = "visiting"
    state.visitUntil = tickNow + randMs(VISIT_MIN, VISIT_MAX)
    state.nextSpeechAt = tickNow + math.random(4000, 12000)

    if zone and zone.forceLookDir then
        npc:setDirection(zone.forceLookDir)
        state.faceDir = zone.forceLookDir
    end
end

local function handleWrongFloor(npc, state, tickNow)
    local npcPos = npc:getPosition()
    if npcPos.z == 7 then
        return false
    end

    debugProblem(npc, "wrong floor detected at " .. posToText(npcPos) .. ", teleporting to safe market tile")
    recoverNpcToSafeArea(npc, state, "wrong floor")
    return true
end

local function handleMoving(npc, state, tickNow)
    local npcPos = npc:getPosition()

    if handleWrongFloor(npc, state, tickNow) then
        return
    end

    local targetPos = state.targetPos
    if not targetPos then
        resetToIdle(npc, state, tickNow)
        return
    end

    local zone = state.targetZone and getZoneByName(state.targetZone) or nil

    if tryStartLocalConversation(npc, state, tickNow) then
        return
    end

    if samePos(npcPos, targetPos) then
        handleArrivedInZone(npc, state, zone, tickNow)
        return
    end

    if tickNow < state.nextStepAt then
        return
    end

    if not state.cachedPath or tickNow - state.pathBuiltAt >= PATH_RECALC_MS then
        state.cachedPath = buildPath(npc, npcPos, targetPos, zone)
        state.cachedPathIndex = 2
        state.pathBuiltAt = tickNow

        if not state.cachedPath then
            if incrementTargetFail(npc, state, tickNow, "path rebuild failed") then
                return
            end
            debugProblem(npc, "path rebuild failed to " .. posToText(targetPos))
        end
    end

    local moved = false

    if state.cachedPath and state.cachedPath[state.cachedPathIndex] then
        local nextPos = state.cachedPath[state.cachedPathIndex]
        local dir = getDirectionBetweenAdjacent(npcPos, nextPos)

        if dir and isWalkableForNpc(nextPos, npc, zone) then
            tryOpenDoorAt(nextPos)
            doMoveCreature(npc:getId(), dir)
            moved = true
            state.cachedPathIndex = state.cachedPathIndex + 1
        end
    end

    if not moved then
        local preferredDirs = getPreferredDirectionsToward(npcPos, targetPos)

        for i = 1, 4 do
            local dir = preferredDirs[i]
            local nextPos = getPosByDir(npcPos, dir)
            if isWalkableForNpc(nextPos, npc, zone) then
                tryOpenDoorAt(nextPos)
                doMoveCreature(npc:getId(), dir)
                moved = true
                break
            end
        end
    end

    state.nextStepAt = tickNow + randMs(STEP_INTERVAL_MIN, STEP_INTERVAL_MAX)

    local currentPos = npc:getPosition()
    if state.lastPos and samePos(currentPos, state.lastPos) then
        state.stuckCounter = state.stuckCounter + 1
    else
        state.stuckCounter = 0
        state.hardStuckCounter = 0
        state.lastPos = copyPosition(currentPos)
    end

    if moved then
        state.lastMoveAt = tickNow
        return
    end

    state.hardStuckCounter = state.hardStuckCounter + 1

    if state.stuckCounter == STUCK_REPATH_THRESHOLD then
        debugProblem(npc, "stuck on path, trying detour to " .. posToText(targetPos))
    end

    if state.stuckCounter >= STUCK_REPATH_THRESHOLD then
        local detourPath = chooseDetourPath(npc, targetPos, zone)
        if detourPath then
            state.cachedPath = detourPath
            state.cachedPathIndex = 2
            state.pathBuiltAt = tickNow
            state.stuckCounter = 0
            return
        end
    end

    if state.hardStuckCounter >= HARD_STUCK_THRESHOLD then
        recoverNpcToSafeArea(npc, state, "hard stuck")
        return
    end

    if not moved or state.stuckCounter >= 5 then
        state.stuckCounter = 0
        state.cachedPath = nil
        state.cachedPathIndex = 1

        if state.targetKind ~= "connector_pass" and tryPickAlternativeTargetInSameZone(npc, state, zone, tickNow) then
            return
        end

        local fallback = zone and getRandomWalkablePosInZone(zone, npc, 30) or nil
        if fallback and not samePos(fallback, targetPos) then
            local fallbackPath = buildPath(npc, npc:getPosition(), fallback, zone)
            if fallbackPath then
                state.targetPos = fallback
                state.targetKind = "visit"
                state.cachedPath = fallbackPath
                state.cachedPathIndex = 2
                state.pathBuiltAt = tickNow
                return
            end
        end

        if incrementTargetFail(npc, state, tickNow, "could not advance toward target") then
            return
        end

        debugProblem(npc, "movement failed, reset to idle")
        resetToIdle(npc, state, tickNow)
    end
end

local function handleSeated(npc, state, tickNow)
    local zone = state.targetZone and getZoneByName(state.targetZone) or nil
    local seatedDir = nil

    if zone and zone.tableIds then
        seatedDir = findNearestTableDirection(npc:getPosition(), zone.tableIds)
    end

    if not seatedDir then
        seatedDir = state.faceDir
    end

    if seatedDir then
        npc:setDirection(seatedDir)
        state.faceDir = seatedDir
    end

    if tryNoticeNearbyPlayer(npc, state, tickNow) then
        state.nextSpeechAt = tickNow + math.random(8000, 18000)
        return
    end

    if tryStartLocalConversation(npc, state, tickNow) then
        return
    end

    if zone and tickNow >= state.nextSpeechAt then
        if not zone.silentChance or math.random(1, 100) > zone.silentChance then
            sayRandomFromList(npc, getZoneLines(zone))
        end
        state.nextSpeechAt = tickNow + math.random(8000, 18000)
    end

    if tickNow >= state.seatUntil then
        resetToIdle(npc, state, tickNow)
    end
end

local function handleVisiting(npc, state, tickNow)
    local zone = state.targetZone and getZoneByName(state.targetZone) or nil

    if zone and state.faceDir then
        npc:setDirection(state.faceDir)
    end

    if tryNoticeNearbyPlayer(npc, state, tickNow) then
        state.nextSpeechAt = tickNow + math.random(8000, 18000)
        return
    end

    if tryStartLocalConversation(npc, state, tickNow) then
        return
    end

    if zone and tickNow >= state.nextSpeechAt then
        if state.targetKind == "order" and zone.orderLines and #zone.orderLines > 0 then
            sayRandomFromList(npc, zone.orderLines)
        elseif not zone.silentChance or math.random(1, 100) > zone.silentChance then
            sayRandomFromList(npc, getZoneLines(zone))
        end
        state.nextSpeechAt = tickNow + math.random(8000, 18000)
    end

    if tickNow >= state.visitUntil then
        resetToIdle(npc, state, tickNow)
    end
end

local function handleIdle(npc, state, tickNow)
    local npcPos = npc:getPosition()

    if npcPos.z ~= 7 then
        handleWrongFloor(npc, state, tickNow)
        return
    end

    if tryNoticeNearbyPlayer(npc, state, tickNow) then
        return
    end

    if tickNow >= state.nextSelfTalkAt then
        state.nextSelfTalkAt = tickNow + randMs(SELF_TALK_MIN, SELF_TALK_MAX)

        if math.random(1, 100) <= SELF_TALK_CHANCE then
            sayRandomFromList(npc, getExpandedSmallTalk())
            return
        end
    end

    if tryStartLocalConversation(npc, state, tickNow) then
        return
    end

    if tickNow >= state.nextRoamPulseAt then
        state.nextRoamPulseAt = tickNow + randMs(ROAM_PULSE_MIN, ROAM_PULSE_MAX)

        local groundScore = getGroundPreferenceScore(npc:getPosition())
        if groundScore <= 1 or math.random(1, 100) <= ROAM_PULSE_CHANCE then
            chooseNewDestination(npc, state, tickNow)
            return
        end
    end

    if tickNow >= state.nextActionAt then
        chooseNewDestination(npc, state, tickNow)
    end
end

local function onCitizenMessage(cid, msgType, msg)
    local player = Player(cid)
    if not player then
        return false
    end

    local npc = Npc()
    if not npc then
        return false
    end

    local text = trim(msg:lower())
    if not triggerWords[text] then
        return false
    end

    if not isPlayerInRange(player, npc) then
        return false
    end

    facePlayer(player, npc)
    npc:say(greetings[math.random(1, #greetings)], TALKTYPE_MONSTER_SAY)
    return true
end

local function loop(npcId)
    local npc = Creature(npcId)
    if not npc or not npc:isNpc() then
        clearStateById(npcId)
        return
    end

    local state = getStateById(npcId, npc)
    local tickNow = nowMs()

    if not state.lastPos then
        state.lastPos = copyPosition(npc:getPosition())
    end

    if state.mode == "talking" then
        handleTalking(npc, state, tickNow)
        addEvent(loop, LOOP_TALK_MS, npcId)
        return
    elseif state.mode == "moving" then
        handleMoving(npc, state, tickNow)
        addEvent(loop, LOOP_MOVE_MS, npcId)
        return
    elseif state.mode == "seated" then
        handleSeated(npc, state, tickNow)
        addEvent(loop, LOOP_SEATED_MS, npcId)
        return
    elseif state.mode == "visiting" then
        handleVisiting(npc, state, tickNow)
        addEvent(loop, LOOP_VISIT_MS, npcId)
        return
    else
        handleIdle(npc, state, tickNow)
        addEvent(loop, LOOP_IDLE_MS, npcId)
        return
    end
end

function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)

    local npc = Npc()
    if npc then
        local state = getState(npc)
        local tickNow = nowMs()

        state.lastPos = copyPosition(npc:getPosition())
        state.lastMoveAt = tickNow

        if state.nextActionAt == 0 then
            state.nextActionAt = tickNow + randMs(INITIAL_ACTION_MIN, INITIAL_ACTION_MAX)
            state.nextSpeechAt = tickNow + math.random(7000, 16000)
            state.nextTalkTryAt = tickNow + randMs(TALK_TRY_MIN, TALK_TRY_MAX)
            state.nextPlayerNoticeAt = tickNow + randMs(5000, 20000)
            state.nextRoamPulseAt = tickNow + randMs(ROAM_PULSE_MIN, ROAM_PULSE_MAX)
            state.nextSelfTalkAt = tickNow + randMs(SELF_TALK_MIN, SELF_TALK_MAX)
        end
    end
end

function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)

    local npc = Npc()
    if npc and cid == npc:getId() then
        clearState(npc)
    end
end

function onCreatureSay(cid, msgType, msg)
    if onCitizenMessage(cid, msgType, msg) then
        return true
    end

    return true
end

function onThink()
    npcHandler:onThink()

    local npc = Npc()
    if not npc then
        return
    end

    local state = getState(npc)
    if state.running then
        return
    end

    state.running = true

    if state.nextActionAt == 0 then
        local tickNow = nowMs()
        state.nextActionAt = tickNow + randMs(INITIAL_ACTION_MIN, INITIAL_ACTION_MAX)
        state.nextSpeechAt = tickNow + math.random(7000, 16000)
        state.nextTalkTryAt = tickNow + randMs(TALK_TRY_MIN, TALK_TRY_MAX)
        state.nextPlayerNoticeAt = tickNow + randMs(5000, 20000)
        state.nextRoamPulseAt = tickNow + randMs(ROAM_PULSE_MIN, ROAM_PULSE_MAX)
        state.nextSelfTalkAt = tickNow + randMs(SELF_TALK_MIN, SELF_TALK_MAX)
        state.lastMoveAt = tickNow
    end

    addEvent(loop, math.random(1, 1000), npc:getId())
end
