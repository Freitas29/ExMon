defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Player, Game}

  describe "start/2" do
    test "start the game state" do
      player = Player.build("Jogador", :soco, :chute, :heal)
      computer = Player.build("Baymanx", :soco, :chute, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state " do
      player = Player.build("Jogador", :soco, :chute, :heal)
      computer = Player.build("Baymanx", :soco, :chute, :heal)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Baymanx"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Jogador"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Jogador", :soco, :chute, :heal)
      computer = Player.build("Baymanx", :soco, :chute, :heal)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Baymanx"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Jogador"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Baymanx"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
          name: "Jogador"
        },
        status: :continue,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns info about player" do
      player = Player.build("Jogador", :soco, :chute, :heal)
      computer = Player.build("Baymanx", :soco, :chute, :heal)

      Game.start(computer, player)

      assert Game.player() == %Player{
               life: 100,
               moves: %{move_avg: :chute, move_heal: :heal, move_rnd: :soco},
               name: "Jogador"
             }
    end
  end

  describe "turn/0" do
    test "returns info about game" do
      player = Player.build("Jogador", :soco, :chute, :heal)
      computer = Player.build("Baymanx", :soco, :chute, :heal)

      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end
end
