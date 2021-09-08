class Api::V1::RevenueController < ApplicationController
  def week
    revenues = InvoiceItem.weekly_revenue
    render json: RevenueSerializer.format_weekly_revenue(revenues)
  end

  def date_range
    revenue = InvoiceItem.date_range_revenue(params[:start], params[:end])
    render json: RevenueSerializer.format_range_revenue(revenue)
  end
end
