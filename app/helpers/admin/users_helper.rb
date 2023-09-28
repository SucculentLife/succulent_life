module Admin::UsersHelper
  def user_status_name(user)
    if user.is_deleted
      '退会'
    else
      '有効'
    end
  end
end
