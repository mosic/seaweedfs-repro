defmodule SeaweedfsRepro do
  use Application
  alias Calendar.{DateTime, Strftime}

  def start(_type, _args) do
    batch_size = 50
    total_size = 10_000_000
    now = DateTime.now_utc

    File.cp("gpocam.jpg", "/run/shm/gpocam.jpg")

    Parallel.map(1..total_size, fn(seconds_to_advance) ->
      IO.puts seconds_to_advance

      timestamp = DateTime.advance!(now, seconds_to_advance) |> Strftime.strftime!("%Y/%m/%d/%H/%M_%S_%f")
      path = "gpocam/snapshots/recordings/#{timestamp}.jpg"

      HTTPoison.post!("http://localhost:8888/#{path}", {:multipart, [{:file, "/run/shm/gpocam.jpg", []}]})
    end, size: batch_size)

    {:ok, self}
  end
end
