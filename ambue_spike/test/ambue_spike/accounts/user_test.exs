defmodule AmbueSpike.Accounts.UserTest do
  use AmbueSpike.DataCase, async: true

  alias AmbueSpike.Accounts.User

  @create_params %{
    "name" => "Andrew Murray",
    "email" => "andy@wimbledon.com"
  }

  describe "User.changeset/2" do
    test "with valid params" do
      assert %{
               valid?: true,
               changes: %{
                 name: "Andrew Murray",
                 email: "andy@wimbledon.com"
               }
             } = User.changeset(%User{}, @create_params)
    end

    test "fails with invalid params" do
      invalid_params = %{@create_params | "name" => ""}
      assert %{valid?: false} = changeset = User.changeset(%User{}, invalid_params)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "email must be valid format" do
      invalid_params = %{@create_params | "email" => "andyatwimbledon.com"}
      assert %{valid?: false} = changeset = User.changeset(%User{}, invalid_params)
      assert %{email: ["has invalid format"]} = errors_on(changeset)
    end
  end
end
