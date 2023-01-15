class OrderCreatedMapper
  def initialize(event)
    @event = event
  end

  def map
    {
      order_id: event['id'],
      user_id: event['account_id'],
      created_at: event['created_at'],
      products: event['products'],
      status: event['status']
    }
  end

  private

  attr_reader :event
end
