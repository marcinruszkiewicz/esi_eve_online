ExUnit.start()

# Configure a default user agent for all tests
Application.put_env(:esi_eve_online, :user_agent, "EsiEveOnline-Test-Suite/1.0")
