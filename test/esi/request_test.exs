defmodule Esi.RequestTest do
  use ExUnit.Case
  doctest Esi.Request

  test "requests alliances" do
    request = %Esi.Request{verb: :get, path: "/alliances"}
    {:ok, alliances} = Esi.Request.run(request)
    assert is_list(alliances)
  end
end
