class RevenueSerializer
  def self.format_weekly_revenue(revenues)
    {data:
      revenues.map do |revenue|
        { id: revenue.id,
          type: 'weekly_revenue',
        attributes: {
          week: revenue.week.strftime("%Y-%m-%d"),
          revenue: revenue.revenue
          }
        }
      end
    }
  end
end
