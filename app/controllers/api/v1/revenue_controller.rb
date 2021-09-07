class Api::V1::RevenueController < ApplicationController
  def week
    revenues = InvoiceItem.weekly_revenue
  end
end
