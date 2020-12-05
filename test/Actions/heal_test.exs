defmodule ExMon.ActionsHealTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player
  alias ExMon.Game.Actions


  describe "heal_life/1" do
    test "when a player heal, return a message" do
      player = Player.build("Arão", :chute, :soco, :cura)


      messages = capture_io(fn ->
        ExMon.start_game(player)
        Actions.attack(:move_avg)
        Actions.Heal.heal_life(:player) == :ok
      end)

      assert messages =~ "The player healled itself"
    end
  end
end
