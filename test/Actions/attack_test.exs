defmodule ExMon.ActionsAttackTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player
  alias ExMon.Game.Actions


  describe "attack/1" do
    test "when a attack is valid, return a message" do
      player = Player.build("Arão", :chute, :soco, :cura)


      messages = capture_io(fn ->
        assert ExMon.start_game(player)
        assert Actions.Attack.attack_opponent(:computer, :move_avg) == :ok
      end)

      assert messages =~ "The player attacked the computer"
    end
  end
end
