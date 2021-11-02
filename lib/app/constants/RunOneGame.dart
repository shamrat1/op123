enum GameOptionType {
  wicket,
  wide_ball,
  dot_ball,
  no_ball,
  run_1,
  run_2,
  run_3,
  run_4,
  run_6,
}
Map<GameOptionType, String> gameOptionTypes = {
  GameOptionType.dot_ball: "Dot Ball",
  GameOptionType.wide_ball: "WIDE",
  GameOptionType.no_ball: "No Ball",
  GameOptionType.run_1: "1 Run",
  GameOptionType.run_2: "2 Run",
  GameOptionType.run_3: "3 Run",
  GameOptionType.run_4: "4 Run",
  GameOptionType.run_6: "6 Run",
  GameOptionType.wicket: "Wicket",
};

class RunOneGame {
  final Map<int, GameOptionType> labels = {
    1: GameOptionType.run_1,
    2: GameOptionType.no_ball,
    3: GameOptionType.run_2,
    4: GameOptionType.wide_ball,
    5: GameOptionType.wicket,
    6: GameOptionType.dot_ball,
  };
}

class RunSixGame {
  final Map<int, GameOptionType> labels = {
    1: GameOptionType.run_1,
    2: GameOptionType.no_ball,
    3: GameOptionType.run_2,
    4: GameOptionType.wide_ball,
    5: GameOptionType.run_3,
    6: GameOptionType.wicket,
    7: GameOptionType.run_4,
    8: GameOptionType.run_6,
    9: GameOptionType.dot_ball,
  };
}

class RunFourGame {
  final Map<int, GameOptionType> labels = {
    1: GameOptionType.run_1,
    2: GameOptionType.no_ball,
    3: GameOptionType.run_2,
    4: GameOptionType.wide_ball,
    5: GameOptionType.run_3,
    6: GameOptionType.wicket,
    7: GameOptionType.run_4,
    8: GameOptionType.dot_ball,
  };
}

class RunThreeGame {
  final Map<int, GameOptionType> labels = {
    1: GameOptionType.run_1,
    2: GameOptionType.no_ball,
    3: GameOptionType.run_2,
    4: GameOptionType.wide_ball,
    5: GameOptionType.run_3,
    6: GameOptionType.wicket,
    7: GameOptionType.dot_ball,
  };
}
