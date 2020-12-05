defmodule ExMonActionsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Actions

  describe "attack/1" do
    test "when a is valid attack move, returns a message" do
      player = ExMon.create_player("Arão", :soco, :chute, :chura)

      messages = capture_io(fn ->
        ExMon.start_game(player)
        assert Actions.attack(:move_avg) == :ok
      end)

      assert messages =~ "The player attacked the computer"
    end
  end

  describe "heal/1" do
    test "when a is valid heal move, returns a message" do
      player = ExMon.create_player("Arão", :soco, :chute, :chura)

      messages = capture_io(fn ->
        ExMon.start_game(player)
        assert Actions.heal() == :ok
      end)

      assert messages =~ "The player healled itself"
    end
  end

  describe "fetch_move/1" do
    test "returns the move" do
      player = ExMon.create_player("Arão", :soco, :chute, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      assert Actions.fetch_move(:cura) == {:ok, :move_heal}
    end
  end


end
