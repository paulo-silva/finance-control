defmodule FinanceControlWeb.HomeLive do
  @moduledoc false
  use FinanceControlWeb, :live_view

  use LiveViewNative.LiveView,
    formats: [:swiftui],
    layouts: [
      swiftui: {FinanceControlWeb.Layouts.SwiftUI, :app}
    ]

  @impl Phoenix.LiveView
  def mount(_, _, socket) do
    {:ok, assign(socket, :counter, 0)}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div>
      Home Page (Web)
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("test", _, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end
end
