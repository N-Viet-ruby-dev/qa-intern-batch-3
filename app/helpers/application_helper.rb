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

  def link_to_set_post post
    if post.actived?
      link_to("Hide", admin_post_path(post), remote: true, method: :patch, class: "btn btn-secondary btn-sm", id: "btn-post-#{post.id}")
    else
      link_to("Approve", admin_post_path(post), remote: true, method: :patch, class: "btn btn-primary btn-sm", id: "btn-post-#{post.id}")
    end
  end
end
