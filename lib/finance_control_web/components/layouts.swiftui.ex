defmodule FinanceControlWeb.Layouts.SwiftUI do
  use FinanceControlNative, [:layout, format: :swiftui]

  embed_templates "layouts_swiftui/*"
end
