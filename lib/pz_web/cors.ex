defmodule PZWeb.CORS do
  @moduledoc """
  Handles CORS
  """
  defmodule Helpers do
    @moduledoc """
    Helpers for CORS - Defaults and helper functions
    """
    def load_corsica_config_field(field) when is_atom(field) do
      Application.get_env(:corsica, field, default(field))
    end

    def default(keyword) do
      defaults()
      |> Keyword.get(keyword)
    end

    defp defaults do
      [
        origins: "*",
        allow_methods: ["POST", "PUT", "PATCH", "DELETE"],
        allow_headers: [],
        # Corsica default is false, we use true
        allow_credentials: true,
        expose_headers: nil,
        # Corsica default is nil, we use 2 hours (Chromium max)
        max_age: 7200,
        log: false
      ]
    end
  end

  use Corsica.Router,
    origins: Helpers.load_corsica_config_field(:origins),
    allow_headers: Helpers.load_corsica_config_field(:allow_headers),
    # Simple Methods (HEAD, GET, or POST) are always allowed no matter what you specify
    # OPTIONS is also always allowed and checked by preflight methods
    allow_methods: Helpers.load_corsica_config_field(:allow_methods),
    allow_credentials: Helpers.load_corsica_config_field(:allow_credentials),
    expose_headers: Helpers.load_corsica_config_field(:expose_headers),
    max_age: Helpers.load_corsica_config_field(:max_age),
    log: Helpers.load_corsica_config_field(:log)

  # We can override single settings as well.
  # Allows additional `host:` settings which matches only on specific hosts - host: "mysubdomain."
  resource("/tracking/keys/validity/*", origins: "*")
  resource("/tracking/keys/validity", origins: "*")

  # Everything else is treated without any overrides
  resource("/*")
end
