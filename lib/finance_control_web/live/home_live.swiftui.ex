defmodule FinanceControlWeb.HomeLive.SwiftUI do
  @moduledoc false
  use FinanceControlNative, [:render_component, format: :swiftui]

  def render(assigns, interface) do
    ~LVN"""
    <VStack id="hello-ios">
      <Text><%= @counter %></Text>
      <Button phx-click="test">
        Up
      </Button>
    </VStack>
    """
  end
end
