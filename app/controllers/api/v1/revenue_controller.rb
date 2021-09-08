class Api::V1::RevenueController < ApplicationController
  def week
    revenues = InvoiceItem.weekly_revenue
    render json: RevenueSerializer.format_weekly_revenue(revenues)
  end

  def date_range
    if params[:start].nil? || params[:end].nil?
      render json: {error: 'Start or end date params missing'}, status: :bad_request
    elsif params[:start].empty? || params[:end].empty?
      render json: {error: 'Start or end date params missing'}, status: :bad_request
    else
      revenue = InvoiceItem.date_range_revenue(params[:start], params[:end])
      render json: RevenueSerializer.format_range_revenue(revenue)
    end
  end
end
