module ApplicationHelper
  def full_title page_title = ""
    base_title = t "title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def select_role
    User.roles.keys.map {|role| [role.titleize,role]}
  end

  def link_to_toggle_user_subscription user
    if user.admin?
      link_to("Set User", admin_user_path(user),
        method: :patch, remote: true, class: "btn info custom-btn", id: "btn-set-#{user.id}")
    elsif user.user?
      link_to("Set Admin", admin_user_path(user),
        method: :patch, remote: true, class: "btn info custom-btn", id: "btn-set-#{user.id}")
    end
  end

  def link_to_delete user
    if user.user?
      link_to("Delete", admin_user_path(user), method: :delete,
        data: { confirm: "You sure?" }, class: "btn danger custom-btn", id: "btn-delete-#{user.id}")
    elsif user.admin?
      link_to("","#",id: "btn-delete-#{user.id}")
    end
  end

  def valid_admin user
    current_user&.admin? && !current_user?(user)
  end

  def load_avatar object
    object.attached? unless object.attached?.blank?
    "login.png"
  end

  def check_current_user
    return new_post_path(current_user) if logged_in?
  end

  def format_time time
    time.strftime("%b %d, %Y")
  end

  def check_time_post time
    time_diff = (Time.now - time.localtime).abs
    time_change = time_diff/60/60
    if time_change <= 24
      "#{time_change.to_i}h"
    else
      format_time time
    end
  end
end
