defmodule Esi.ErrorTest do
  use ExUnit.Case, async: true

  alias Esi.Error

  describe "error creation functions" do
    test "http_error/3 creates HTTP error" do
      error = Error.http_error(404, "Not found", %{extra: "info"})
      
      assert %Error{
        type: :http_error,
        status: 404,
        message: "Not found",
        details: %{extra: "info"},
        request_id: nil,
        retry_after: nil
      } = error
    end

    test "api_error/3 creates API error" do
      error = Error.api_error(400, "Bad request", %{field: "invalid"})
      
      assert %Error{
        type: :api_error,
        status: 400,
        message: "Bad request",
        details: %{field: "invalid"}
      } = error
    end

    test "validation_error/2 creates validation error" do
      error = Error.validation_error("Invalid parameter", %{param: "character_id"})
      
      assert %Error{
        type: :validation_error,
        status: nil,
        message: "Invalid parameter",
        details: %{param: "character_id"}
      } = error
    end

    test "network_error/2 creates network error" do
      error = Error.network_error("Connection timeout")
      
      assert %Error{
        type: :network_error,
        status: nil,
        message: "Connection timeout",
        details: %{}
      } = error
    end

    test "timeout_error/2 creates timeout error" do
      error = Error.timeout_error("Request timed out", %{timeout: 30_000})
      
      assert %Error{
        type: :timeout_error,
        status: nil,
        message: "Request timed out",
        details: %{timeout: 30_000}
      } = error
    end

    test "timeout_error/0 creates default timeout error" do
      error = Error.timeout_error()
      
      assert %Error{
        type: :timeout_error,
        message: "Request timed out",
        details: %{}
      } = error
    end
  end

  describe "error enhancement functions" do
    test "with_retry_after/2 adds retry after information" do
      error = Error.http_error(429, "Rate limited")
      enhanced = Error.with_retry_after(error, 60)
      
      assert enhanced.retry_after == 60
    end

    test "with_request_id/2 adds request ID" do
      error = Error.api_error(500, "Internal error")
      enhanced = Error.with_request_id(error, "req-123")
      
      assert enhanced.request_id == "req-123"
    end

    test "chaining enhancement functions" do
      error = 
        Error.api_error(503, "Service unavailable")
        |> Error.with_retry_after(120)
        |> Error.with_request_id("req-456")
      
      assert error.retry_after == 120
      assert error.request_id == "req-456"
    end
  end
end
