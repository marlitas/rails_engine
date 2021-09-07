class Api::V1::RevenueController < ApplicationController
  def week
    revenues = InvoiceItem.weekly_revenue
    render json: RevenueSerializer.format_weekly_revenue(revenues)
  end
end
