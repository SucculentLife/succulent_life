module Public::ItemsHelper
  def item_status_name(item)
    if item.is_active
      '販売中'
    else
      '売切れ'
    end
  end
end
