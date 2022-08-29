defmodule NervesTestClient.CAStore do
  use Zola.NervesHubCAStore,
    otp_app: :test
end
