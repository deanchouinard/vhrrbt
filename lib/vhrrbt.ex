defmodule VhrRbt do
  @moduledoc """
  VhrRbt keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  #defstruct ~w[name category instructions raw compiled generators checker]a
  defstruct ~w[location sensor temp humid batt ip_addr datetime]a
end